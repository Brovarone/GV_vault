import os
import re
import glob
from bs4 import BeautifulSoup
from html_to_markdown import HtmlToMarkdown # Uso di html-to-markdown
from html_to_markdown.html_to_markdown import HtmdConfig # Per configurare il convertitore

# --- CONFIGURAZIONE PERCORSI ---
INPUT_DIR = r"C:\Users\Cristiano\Documents\Obsidian\D&D\D&D\z_GV\GV_fonti"
OUTPUT_BASE_DIR = r"C:\Users\Cristiano\Documents\Obsidian\D&D\D&D\z_GV"

# --- COSTANTI DI FORMATTAZIONE ---
DELIMITER = "--- FILE: "

def clean_and_convert(html_content):
    """
    Pulisce il contenuto, manipola i tag di intestazione (h2->h3, h4->h2) 
    e converte l'HTML risultante in Markdown usando HtmlToMarkdown.
    """
    if not html_content:
        return ""
        
    soup = BeautifulSoup(html_content, 'html.parser')
    
    # 1. Manipolazione dei titoli: essenziale per il tuo requisito
    for tag in soup.find_all(['h2', 'h4']):
        if tag.name == 'h2':
            tag.name = 'h3' # h2 -> h3
        elif tag.name == 'h4':
            tag.name = 'h2' # h4 -> h2

    # 2. Conversione a Markdown
    # Configura HtmlToMarkdown per usare gli header ATX (#)
    config = HtmdConfig(
        use_github_style_tables=True,
        heading_style="ATX",
        code_style="fenced",
        wrap=True
    )
    converter = HtmlToMarkdown(config=config)
    markdown_content = converter.convert(str(soup)).strip()
    
    # 3. Pulizia finale del tag 'Descrizione' superfluo
    markdown_content = re.sub(r'#+\s*descrizione\s*', '', markdown_content, flags=re.IGNORECASE).strip()
    
    return markdown_content

def process_file(html_file_path, output_base_dir):
    """Elabora un singolo file HTML e salva i file Markdown nella sottocartella."""
    
    # Deriva il nome della sottocartella dal nome del file HTML (es. 'Talenti' da 'Talenti.html')
    base_name = os.path.splitext(os.path.basename(html_file_path))[0]
    output_folder = os.path.join(output_base_dir, base_name)
    
    print(f"-> Elaborazione di {os.path.basename(html_file_path)}...")
    
    # Crea la cartella di output se non esiste
    os.makedirs(output_folder, exist_ok=True)
    
    try:
        with open(html_file_path, 'r', encoding='utf8') as f:
            html_doc = f.read()
    except Exception as e:
        print(f"ERRORE: Impossibile leggere il file {html_file_path}. {e}")
        return

    soup = BeautifulSoup(html_doc, 'html.parser')
    
    # Cerca la tabella principale
    table = soup.find('table', class_='dataTable')
    if not table:
         table = soup.find('table')
         if not table:
             print(f"AVVISO: Impossibile trovare la tabella dei dati in {base_name}. File saltato.")
             return
    
    rows = table.find('tbody').find_all('tr') if table.find('tbody') else table.find_all('tr')
    
    processed_count = 0
    
    for row in rows:
        cells = row.find_all('td')
        
        # Le righe devono avere almeno 6 celle (Nome, Tipo, Gruppo, Livello/Prerequisiti, Descrizione)
        if len(cells) < 6:
            continue
            
        # 1. Estrazione dei dati
        name = cells[0].text.strip()
        item_type = cells[1].text.strip()
        group = cells[2].text.strip()
        
        # I prossimi campi dipendono se il file è 'Benefici' o 'Talenti'
        # Assumiamo la struttura a 6 colonne usata per Talenti/Benefici.
        col4_content = cells[3].text.strip()
        col5_content = cells[4].text.strip()
        
        # Pulizia e Conversione della Descrizione (Cella 6)
        description_html = str(cells[5]) 
        description_md = clean_and_convert(description_html)

        # 2. Assegna Livello e Prerequisiti (ipotizzando che siano in col4 e col5)
        # Il codice è abbastanza robusto per entrambi i tipi di file (Benefici ha spesso "Nessuno")
        level = col4_content
        prerequisites = col5_content

        # 3. Formattazione Frontmatter
        frontmatter = f"""---
name: {name}
type: {item_type}
group: {group}
level: {level}
prerequisites: {prerequisites}
---

**Descrizione**
{description_md}"""
        
        # 4. Salvataggio del file
        # Rimuove caratteri non validi dal nome del file (come /)
        file_name = f"{name}.md".replace("/", "-").replace(":", "_").replace("?", "")
        output_file_path = os.path.join(output_folder, file_name)
        
        try:
            with open(output_file_path, 'w', encoding='utf8') as out_f:
                out_f.write(frontmatter)
            processed_count += 1
        except Exception as e:
            print(f"ERRORE: Impossibile salvare il file {file_name}. {e}")

    print(f"-> Salvati {processed_count} file nella cartella: {output_folder}")

def batch_process_html(input_dir, output_base_dir):
    """Cerca e processa tutti i file HTML nella cartella di input."""
    
    # Costruisce il pattern di ricerca: cerca tutti i file .html nella cartella di input
    search_pattern = os.path.join(input_dir, "*.html")
    html_files = glob.glob(search_pattern)
    
    if not html_files:
        print(f"Nessun file .html trovato nella cartella: {input_dir}")
        return

    print(f"Trovati {len(html_files)} file HTML da elaborare.")
    
    for file_path in html_files:
        process_file(file_path, output_base_dir)

if __name__ == "__main__":
    # Assicurati che le cartelle di base esistano
    os.makedirs(OUTPUT_BASE_DIR, exist_ok=True)
    
    print("--- Avvio Conversione HTML in Markdown ---")
    batch_process_html(INPUT_DIR, OUTPUT_BASE_DIR)
    print("--- Conversione Completata ---")