import os
import re
import glob
import subprocess 
from bs4 import BeautifulSoup, element
from html_to_markdown import convert, ConversionOptions 
from typing import Dict, Any, List

# --- CONFIGURAZIONE PERCORSI E URL ---
# Cartella di Input per salvare i file HTML scaricati
INPUT_DIR = r"C:\Users\Cristiano\Documents\Obsidian\D&D\D&D\z_GV\GV_fonti"
# Cartella di Output per salvare i file Markdown (crea sottocartelle qui)
OUTPUT_BASE_DIR = r"C:\Users\Cristiano\Documents\Obsidian\D&D\D&D\z_GV"

# Mappa dei file e degli URL da scaricare
URLS = {
    "Condizioni.html":"https://www.grajaversion.org/Rules/Conditions",
}
URLS_ok = {
    "Razze_Classi.html": "http://www.grajaversion.org/Home/RaceClasses",
    "Talenti.html": "http://www.grajaversion.org/Features",
    "Benefici.html": "http://www.grajaversion.org/Features/Benefits",
    "Stili.html": "http://www.grajaversion.org/Powers/Styles",
    "Incantesimi.html": "http://www.grajaversion.org/Powers/Spells",
    "Preghiere.html": "http://www.grajaversion.org/Powers/Prayers",
    "Discipline.html": "http://www.grajaversion.org/Powers/Disciplines",
    "Condizioni.html":"https://www.grajaversion.org/Rules/Conditions",
}

# Mappa per correggere il tipo di elemento
ITEM_TYPE_MAP = {
    "Talenti": "Talento", 
    "Benefici": "Beneficio",
    "Stili": "Stile", 
    "Incantesimi": "Incantesimo", 
    "Preghiere": "Preghiera", 
    "Discipline": "Disciplina",
    "Condizioni": "Condizione"
}

# --- MAPPATURA CLASSI (NUOVA) ---
# Definisce la classe associata al tipo di oggetto (Mago per Incantesimi, Chierico per Preghiere, ecc.)
CLASS_MAP = {
    'Incantesimi': 'Mago',
    'Preghiere': 'Sacerdote',
    'Discipline': 'Guerriero',
    'Stili': 'Vagabondo', 
    "Talenti" : None,   
}
# ----------------------------------------------------------------------
# FASE 1: DOWNLOAD (Utilizzo di Curl)
# ----------------------------------------------------------------------

def download_files_with_curl(urls, input_dir):
    """Scarica tutti i file HTML utilizzando curl e li salva nella cartella di input."""
    
    print("\n--- Avvio Download Pagine GV (Utilizzo di Curl) ---")
    os.makedirs(input_dir, exist_ok=True)
    
    total_downloaded = 0
    
    for filename, url in urls.items():
        file_path = os.path.join(input_dir, filename)
        
        try:
            print(f"-> Scaricando {filename} da {url}...")
            
            curl_command = [
                'curl', 
                '-L', 
                '-o', file_path, 
                '-A', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
                url
            ]
            
            subprocess.run(curl_command, check=True, capture_output=True, text=True, encoding='utf8')
            
            if os.path.exists(file_path) and os.path.getsize(file_path) > 0:
                print(f"-> ✅ {filename} salvato.")
                total_downloaded += 1
            else:
                 print(f"ERRORE di download per {filename}: Il file è vuoto o non è stato creato correttamente.")

        except subprocess.CalledProcessError as e:
            print(f"ERRORE di curl per {filename} (codice {e.returncode}): {e.stderr.strip()}")
        except FileNotFoundError:
            print("ERRORE: Comando 'curl' non trovato. Assicurati che Curl sia installato e nel tuo PATH.")
        except Exception as e:
            print(f"ERRORE sconosciuto durante il salvataggio di {filename}: {e}")
            
    if total_downloaded == len(urls):
        print("--- Download Completato! ---")
    else:
        print(f"--- Download Terminati con {total_downloaded} successi su {len(urls)} ---")
        
# ----------------------------------------------------------------------
# FASE 2: CONVERSIONE E PULIZIA 
# ----------------------------------------------------------------------

def clean_and_convert(html_content):
    """
    Pulisce, manipola gli header (h2->h3, h4->h2) e converte in Markdown 
    utilizzando la funzione convert() e ConversionOptions.
    """
    if not html_content:
        return ""
        
    soup = BeautifulSoup(html_content, 'html.parser')
    
    # Manipolazione dei titoli: h2 -> h3, h4 -> h2
    for tag in soup.find_all(['h2', 'h4']):
        if tag.name == 'h2':
            tag.name = 'h3' 
        elif tag.name == 'h4':
            tag.name = 'h2' 

    options = ConversionOptions(
        heading_style="atx", 
        code_block_style="backticks", 
        wrap=True,
    )
    
    markdown_content = convert(str(soup), options=options).strip()
    markdown_content = re.sub(r'#+\s*descrizione\s*', '', markdown_content, flags=re.IGNORECASE).strip()
    
    return markdown_content

def clean_and_convert_list(html_content):
    # Esempio molto basilare: estrae solo il testo e lo formatta come lista se trova <ul>
    soup = BeautifulSoup(html_content, 'html.parser')
    
    # Se è una lista (Condizioni/Benefici), la formattiamo come lista Markdown
    list_items = soup.find_all('li')
    if list_items:
        # Aggiungo un piccolo spazio in più per la leggibilità del Markdown
        md_list = "\n" + "\n".join([f"* {li.text.strip()}" for li in list_items])
        return md_list
    
    # Altrimenti, restituisci solo il testo
    return soup.get_text().strip()

def link_conditions(text: str, conditions_list: list) -> str:
    """
    Sostituisce le Condizioni note nel testo con link interni di Obsidian (MD).
    Gestisce i modificatori numerici (es. Scosso X) lasciandoli fuori dal link.
    """
    
    # Ordina la lista per lunghezza (dal più lungo al più corto) per evitare match parziali.
    conditions_list.sort(key=len, reverse=True)
    
    valid_conditions = [re.escape(c) for c in conditions_list if c]
    if not valid_conditions:
        return text

    conditions_pattern = '|'.join(valid_conditions)
    
    # La regex cerca:
    # 1. \b(conditions_pattern)\b: il nome della condizione come parola intera.
    # 2. \s*(\d*): uno spazio opzionale seguito da un numero opzionale (il modificatore X).
    # Reimplemento la regex per gestire meglio le condizioni come "Scosso X" o "Rallentato 2".
    # Usiamo un lookahead negativo `(?! da fonte)` per prevenire la cattura di nomi non voluti,
    # anche se l'estrazione in get_condition_names dovrebbe aver risolto il problema della fonte.
    pattern = re.compile(r'\b(' + conditions_pattern + r')\s*(\d*)\b', re.IGNORECASE)
    
    def replacer(match):
        # match.group(1) è la Condizione (es. "Scosso")
        # match.group(2) è il numero (es. "X" o "2" o stringa vuota)
        name_part = match.group(1)
        mod_part = match.group(2)
        
        # Capitalizza il nome della Condizione (es. "scosso" -> "Scosso")
        # per il link [[Nome]]
        linked_name = name_part[0].upper() + name_part[1:]
        
        # Crea il link, mantenendo il modificatore dopo il link se presente
        # Esempio: "Scosso 2" -> "[[Scosso]] 2"
        return f"[[{linked_name}]] {mod_part}" if mod_part else f"[[{linked_name}]]"

    text = pattern.sub(replacer, text)
        
    return text

# ----------------------------------------------------------------------
# FASE 3: LOGICA DI ESTRAZIONE DA TABELLA (per i Poteri e come Fallback)
# ----------------------------------------------------------------------

def process_box_structure(soup, base_output_folder, base_name, fixed_cost):
    """
    Gestisce l'estrazione per strutture TABS/Accordion/Box (Talenti, Discipline, Stili),
    applicando un costo fisso specificato.
    """
    
    tabs_container = soup.find('div', class_='vertical hc-tabs')
    if not tabs_container:
        print(f"ERRORE: Contenitore principale {base_name} non trovato.")
        return 0
        
    tab_content_container = tabs_container.find('div', class_='tab-content')
    group_elements = tab_content_container.find_all('div', class_='tab-pane') if tab_content_container else tabs_container.find_all('div', class_='tab-pane')
    
    if not group_elements:
         print(f"AVVISO: Nessuna scheda (tab-pane) trovata in {base_name}.html.")
         return 0

    processed_count = 0
    item_type = ITEM_TYPE_MAP.get(base_name, base_name) # 'Talento', 'Disciplina', 'Stile'

    # Flag per includere il campo 'action_type' solo nei Talenti
    include_action_type = (base_name == "Talenti")

    for group_element in group_elements:
        
        boxes_to_process = []
        
        # 1. Estrazione del nome della CLASSE/CATEGORIA (es. "A due armi")
        class_name_tag = group_element.find('h1', class_='title')
        class_name = class_name_tag.text.strip() if class_name_tag else "Senza Categoria"
        
        # 2. Iteriamo sui gruppi (panel-default) all'interno del Tab
        for panel in group_element.find_all('div', class_='panel-default'):
            
            # Estrazione del nome dell'ALBERO/SUB-CATEGORIA (Titolo dell'Accordion)
            tree_title_tag = panel.find('h4', class_='panel-title')
            tree = "Base"
            if tree_title_tag and tree_title_tag.find('a'):
                tree = tree_title_tag.find('a').text.strip().replace('\n', ' ')

            cost = fixed_cost # Costo fisso passato (5 per Talenti, 4 per Discipline/Stili)
                        
            # 3. Estrazione dei singoli item (box-style-2)
            panel_body = panel.find('div', class_='panel-body')
            if panel_body:
                for item_box in panel_body.find_all('div', class_='box-style-2'):
                    
                    # Estrazione del LIVELLO
                    level = "0"
                    if (base_name == "Talenti"):
                        level_match = re.search(r'Livello\s*(\d+)', panel.text.strip()) 
                        level = level_match.group(1) if level_match else "0"
                    else:
                        # Estrazione del LIVELLO (Dal tag <p> che inizia con "Livello:")
                        level_tag = item_box.find('p', string=re.compile(r'Livello:\s*(\d+)', re.IGNORECASE))
                        level_match = re.search(r'Livello:\s*(\d+)', level_tag.text.strip()) if level_tag else None
                        level = level_match.group(1) if level_match else "0"

                    # Estrazione del TIPO DI AZIONE (Azione:, Bonus:, Reazione:, ecc.)
                    action_tag = item_box.find('p', string=re.compile(r'(Azioni:|Bonus:|Reazione:)\s*(\w+)', re.IGNORECASE))
                    action_type = ""
                    if action_tag:
                         match = re.search(r'(Azioni|Bonus|Reazione):\s*([^<]+)', action_tag.text.strip(), re.IGNORECASE)
                         if match:
                             # Es: "Azione" (il tipo) e "Standard" (il valore)
                             action_type = f"{match.group(1).strip()}: {match.group(2).strip()}" 
                    
                    boxes_to_process.append({
                        'box': item_box, 
                        'level': level, 
                        'cost': cost, 
                        'class_name': class_name, 
                        'tree': tree, 
                        'action_type': action_type,
                        'tree_name': class_name,
                        })

        # --- B. Estrazione dei dati e Salvataggio ---
        for item_data in boxes_to_process:
            
            item_box = item_data['box']
            level = item_data['level']
            cost = item_data['cost']
            class_name = item_data['class_name'] if CLASS_MAP.get(base_name,item_type) is None else CLASS_MAP.get(base_name, item_type)
            tree = item_data['tree'] 
            tree_name = item_data['tree_name'] 
            action_type = item_data['action_type']

            name_tag = item_box.find('h2')
            if not name_tag: continue
            name = name_tag.text.strip()
            
            # Prerequisiti: cerchiamo il tag <em> (spesso contiene "Requisiti:" o "Speciale:")
            prerequisites_tag = item_box.find('em')
            prerequisites_raw = prerequisites_tag.text.strip() if prerequisites_tag else ""
            prerequisites = prerequisites_raw.replace('Caratteristiche:', '').replace('Requisiti:', '').replace('Speciale:', '').strip()
            
            # Descrizione: estraggo tutto il contenuto dopo <h2> che non sia livello o prerequisito.
            description_parts = []
            
            # Inizio la ricerca dopo il tag del nome (h2)
            for sibling in name_tag.next_siblings:
                if isinstance(sibling, element.Tag):
                    # Se è un tag <p> e non è il livello o non contiene requisiti 
                    is_level = sibling.text.strip().lower().startswith('livello:')
                    contains_em = sibling.find('em') is not None
                    
                    if sibling.name == 'p' and not is_level and not contains_em:
                         description_parts.append(str(sibling))
                    
                    # Aggiungo anche il contenuto all'interno del box (es. <div> con righe)
                    elif sibling.name in ['div', 'span'] and not sibling.find('h2'):
                         description_parts.append(str(sibling))
                         
                elif isinstance(sibling, str) and sibling.strip():
                    description_parts.append(sibling.strip())

            description_md = clean_and_convert("".join(description_parts)).strip()
            
            # Formattazione Prerequisiti
            prerequisites_output = f"[[{prerequisites}]]" if prerequisites else ""
            
            frontmatter = f"""---
name: {name}
type: {item_type}
class: {class_name}
level: {level}
cost: {cost}
"""
            # Aggiunta condizionale delle proprietà
            if base_name in ["Discipline", "Stili"]:
                 frontmatter += f"tree_name: {tree_name}\n"
                 frontmatter += f"tree: {tree}\n"
            
            if include_action_type and action_type:
                 frontmatter += f"action_type: {action_type}\n"
                 
            frontmatter += f"prerequisites: {prerequisites_output}\n---"

            # Aggiunta Descrizione
            frontmatter += f"""\n
**Descrizione**
{description_md}"""
    
            invalid_chars = r'[<>:"/\\|?*]'
            file_name = re.sub(invalid_chars, '', f"{name}.md")
            
            group_output_folder = os.path.join(base_output_folder, class_name)
            os.makedirs(group_output_folder, exist_ok=True)
            
            output_file_path = os.path.join(group_output_folder, file_name)
            
            try:
                with open(output_file_path, 'w', encoding='utf8') as out_f:
                    out_f.write(frontmatter)
                processed_count += 1
            except Exception as e:
                print(f"ERRORE: Impossibile salvare il file {file_name} in {group_output_folder}. {e}")

    return processed_count

def process_powers_table(soup, base_output_folder, base_name, fixed_cost):
    """
    Gestisce l'estrazione per Incantesimi, Preghiere, Poteri (Struttura TABS/Accordion/Box)
    con parsing avanzato dei metadati e inclusione della Scuola.
    Correzioni implementate:
    1. 'class' usa l'inferenza (es. Mago) basata su base_name.
    2. 'level' viene estratto dal Livello X del tab, se non trovato nel box.
    3. 'school' pulita da parentesi (es. (3)).
    4. Campi vuoti del metadati omessi nel frontmatter.
    5. Estrazione 'prerequisites' più restrittiva.
    """
    tabs_container = soup.find('div', class_='vertical hc-tabs')
    if not tabs_container:
        print(f"ERRORE: Contenitore principale {base_name} non trovato.")
        return 0
        
    tab_content_container = tabs_container.find('div', class_='tab-content')
    group_elements = tab_content_container.find_all('div', class_='tab-pane') if tab_content_container else tabs_container.find_all('div', class_='tab-pane')
    
    if not group_elements:
        print(f"AVVISO: Nessuna scheda (tab-pane) trovata in {base_name}.html.")
        return 0

    processed_count = 0
    item_type = ITEM_TYPE_MAP.get(base_name, base_name)
    # NUOVO: Inserisce la classe dell'incantatore/personaggio
    caster_class = CLASS_MAP.get(base_name, item_type)
    
    for group_element in group_elements:
        
        boxes_to_process = []
        
        # 1. Estrazione del nome della CLASSE/CATEGORIA (Tab principale: es. Livello 1)
        class_name_tag = group_element.find('h1', class_='title')
        class_name_raw = class_name_tag.text.strip() if class_name_tag else "Senza Categoria"
        
        # 2. Iteriamo sui gruppi (panel-default) all'interno del Tab
        for panel in group_element.find_all('div', class_='panel-default'):
            
            # Estrazione del nome dell'ALBERO/SUB-CATEGORIA (Titolo dell'Accordion: es. Abiurazione)
            tree_title_tag = panel.find('h4', class_='panel-title')
            tree_name = "Base"
            school_name = "Sconosciuta"
            
            if tree_title_tag and tree_title_tag.find('a'):
                tree_name = tree_title_tag.find('a').text.strip().replace('\n', ' ')
                
                match_school = re.search(r'-\s*(.+)', tree_name) 
                school_name = match_school.group(1).strip() if match_school else tree_name.strip()
                
                school_name = school_name.replace(base_name, '').replace('di livello', '').strip(' -').strip()
                
                # CORREZIONE 3: Rimuoviamo parentesi e contenuto (es. "(3)")
                school_name = re.sub(r'\s*\([^)]*\)', '', school_name).strip()
            
            # 3. Estrazione dei singoli item (box-style-2)
            panel_body = panel.find('div', class_='panel-body')
            if panel_body:
                for item_box in panel_body.find_all('div', class_='box-style-2'):
                    
                    level_tag = item_box.find('p', string=re.compile(r'Livello:\s*(\d+)', re.IGNORECASE))
                    level_match = re.search(r'Livello:\s*(\d+)', level_tag.text.strip()) if level_tag else None
                    level = level_match.group(1) if level_match else "0"
                    
                    # CORREZIONE 2: Se il livello nel box è 0 (o non trovato), cerchiamo nel titolo del tab principale (es. 'Livello 1')
                    if level == "0" and base_name in ['Incantesimi', 'Preghiere', 'Discipline']:
                        level_from_class_match = re.search(r'Livello\s*(\d+)', class_name_raw)
                        if level_from_class_match:
                            level = level_from_class_match.group(1)
                            
                    boxes_to_process.append({
                        'box': item_box, 
                        'level': level, 
                        'cost': fixed_cost, 
                        'class_name': caster_class, # CORREZIONE 1: Usa la classe inferita (es. Mago)
                        'tree': tree_name, 
                        'school': school_name
                    })

        # --- B. Estrazione dei dati e Salvataggio ---
        for item_data in boxes_to_process:
            
            item_box = item_data['box']
            level = item_data['level']
            cost = item_data['cost']
            class_name = item_data['class_name'] # Ora è Mago, Chierico, etc.
            school = item_data['school']
            
            name_tag = item_box.find('h2')
            if not name_tag: continue
            name = name_tag.text.strip()
            
            # CORREZIONE 5: Prerequisiti: cerchiamo il tag <em> solo se contiene parole chiave di requisiti.
            prerequisites_tag = item_box.find('em')
            prerequisites = ""
            
            if prerequisites_tag:
                prerequisites_raw = prerequisites_tag.text.strip()
                # Cerchiamo Caratteristiche/Requisiti/Speciale per confermare che sia un prerequisito
                if re.search(r'(caratteristiche|requisiti|speciale):', prerequisites_raw, re.IGNORECASE):
                    prerequisites = prerequisites_raw.replace('Caratteristiche:', '').replace('Requisiti:', '').replace('Speciale:', '').strip()
            
            prerequisites_output = f"[[{prerequisites}]]" if prerequisites else ""
            
            # Estrai tutti i contenuti non titolo e non prerequisito
            description_text_parts = []
            
            # Troviamo il tag di livello da escludere (se esiste)
            level_tag_to_exclude = item_box.find('p', string=re.compile(r'Livello:\s*(\d+)', re.IGNORECASE))

            for sibling in name_tag.next_siblings:
                if isinstance(sibling, element.Tag): 
                    # Escludi h2 (già fatto), il tag di livello P (se trovato) e il tag <em> (prerequisito)
                    if sibling == name_tag: continue
                    if level_tag_to_exclude and sibling == level_tag_to_exclude: continue
                    if prerequisites_tag and sibling == prerequisites_tag: continue
                    
                    # Escludi qualsiasi <p> che inizi con "Livello:"
                    is_level_p = sibling.name == 'p' and re.search(r'Livello:\s*(\d+)', sibling.text.strip(), re.IGNORECASE)
                    if is_level_p: continue
                    
                    # La logica precedente `contains_em` era troppo restrittiva. Aggiungiamo i tag.
                    # Ma dobbiamo assicurarci che non stiamo riaggiungendo l'em.
                    # Se il tag <em> è un figlio diretto di un <div> o <p> che è un 'sibling',
                    # lo stiamo includendo. Per ora manteniamo il controllo del nome per 
                    # includere i tag di descrizione come <p> e <div>, escludendo l'h2,
                    # il tag p del livello e l'em del prerequisito.
                    
                    # La logica migliorata: includi tutto ciò che non è il titolo, il livello o il prerequisito
                    if sibling.name not in ['h2', 'em']:
                        description_text_parts.append(str(sibling))
                        
                elif isinstance(sibling, str) and sibling.strip():
                    description_text_parts.append(sibling.strip())

            raw_text_content = clean_and_convert("".join(description_text_parts)).strip()
            
            # Parsing Metadati Avanzato
            metadata = parse_metadata_from_text(raw_text_content, SPELL_META_KEYS)
            
            # Effetto (la descrizione principale) viene separato dai metadati
            body_description_md = metadata.pop("Effetto", "").strip()
                
            
            # --- Costruzione Frontmatter ---
            frontmatter = f"""---
name: {name}
type: {item_type}
class: {class_name}
level: {level}
cost: {cost}
school: {school}
"""
            # CORREZIONE 4: Mappa i metadati estratti SOLO se il valore NON è vuoto
            for key, value in metadata.items():
                if value.strip():
                    frontmatter += f"{key.lower().strip()}: {value.strip()}\n"

            # Aggiunge i prerequisiti solo se non sono vuoti
            if prerequisites_output and prerequisites_output != "[[None]]":
                frontmatter += f"prerequisites: {prerequisites_output}\n---\n"
            else:
                 frontmatter += f"---\n"


            # --- Costruzione Body della Nota ---
            body_content = "\n"
            
            # 1. Metadati nel corpo
            body_content += f"**Scuola**: {school}\n"
            for key, value in metadata.items():
                if value:
                    body_content += f"**{key.strip()}**: {value.strip()}\n"
            
            # 2. Descrizione principale
            body_content += "\n**Descrizione**\n"
            body_content += body_description_md
            
            final_content = frontmatter + body_content.strip()

            # --- Salvataggio ---
            invalid_chars = r'[<>:"/\\|?*]'
            file_name = re.sub(invalid_chars, '', f"{name}.md")
            
            group_output_folder = os.path.join(base_output_folder, school)
            os.makedirs(group_output_folder, exist_ok=True)
            
            output_file_path = os.path.join(group_output_folder, file_name)
            
            try:
                with open(output_file_path, 'w', encoding='utf8') as out_f:
                    out_f.write(final_content)
                processed_count += 1
            except Exception as e:
                print(f"ERRORE: Impossibile salvare il file {file_name} in {group_output_folder}. {e}")

    return processed_count

def process_benefits(soup, base_output_folder, base_name="Benefici"):
    """Gestisce l'estrazione per Benefici.html (Struttura Accordion)."""
    
    accordion_container = soup.find('div', class_='panel-group', id='accordion-3')
    if not accordion_container:
        print(f"ERRORE: Contenitore principale Benefici non trovato.")
        return 0

    # Benefici: ogni group_element è una categoria (Generali, Razza A, Classe B)
    group_elements = accordion_container.find_all('div', class_='panel-default')
    
    processed_count = 0
    item_type = ITEM_TYPE_MAP[base_name]

    for group_element in group_elements:
        
        # Estrazione del nome della CLASSE (es. "Generali", "Razza A", "Classe B")
        group_tag = group_element.find('h4', class_='panel-title')
        group_name = "Generale"
        if group_tag and group_tag.find('a'):
            group_name = group_tag.find('a').text.strip().split('(')[0].strip()
        
        # Parametri fissi per i benefici
        level = "1"
        cost = "1"
        
        # FIX: Seleziono l'elemento 'panel-body' e da lì tutti i box
        panel_body = group_element.find('div', class_='panel-body')
        talent_boxes = panel_body.find_all('div', class_='box-style-2') if panel_body else []
        
        boxes_to_process = [{'box': box, 'level': level, 'cost': cost, 'class_name': group_name} for box in talent_boxes]
        
        # --- Estrazione e Formattazione ---
        for item_data in boxes_to_process:
            
            talent_box = item_data['box']
            class_name = item_data['class_name']
            
            name_tag = talent_box.find('h2')
            if not name_tag: continue
            name = name_tag.text.strip()
            
            # I benefici/caratteristiche non hanno prerequisiti visibili sotto h2/em, ma usiamo la logica di type
            
            description_tag = talent_box.find('p')
            description_html = str(description_tag) if description_tag else ""
            description_md = clean_and_convert(description_html)
            
            
            # Logica Caratteristica vs Beneficio: controlla la presenza del titolo Caratteristiche
            current_type = item_type
            frontmatter_content = f"""name: {name}
type: {current_type}
#class: {class_name}
class: "Generali"
level: {level}
cost: {cost}
"""
            # Cerchiamo se il gruppo (panel) contiene la parola "Caratteristiche"
            if "Caratteristiche" in group_element.text: 
                current_type = "Caratteristica"
                frontmatter_content = frontmatter_content.replace(f"type: {item_type}", f"type: {current_type}")
                frontmatter_content += f"ability: \n" # Proprietà 'ability' senza valore
            else:
                frontmatter_content += f"prerequisites: \n" # Benefici senza prerequisiti
            
            
            frontmatter = f"""---
{frontmatter_content.strip()}
---

**Descrizione**
{description_md}"""

            invalid_chars = r'[<>:"/\\|?*]'
            file_name = re.sub(invalid_chars, '', f"{name}.md")
            
            group_output_folder = os.path.join(base_output_folder, class_name)
            os.makedirs(group_output_folder, exist_ok=True)
            
            output_file_path = os.path.join(group_output_folder, file_name)
            
            try:
                with open(output_file_path, 'w', encoding='utf8') as out_f:
                    out_f.write(frontmatter)
                processed_count += 1
            except Exception as e:
                print(f"ERRORE: Impossibile salvare il file {file_name} in {group_output_folder}. {e}")

    return processed_count

def process_conditions(soup, base_output_folder, base_name="Condizioni"):
    """Gestisce l'estrazione per Condizioni.html (Struttura Accordion)."""
    
    # PRIMO PASSO: ESTRE TUTTI I NOMI DELLE CONDIZIONI (es. "Dominato" invece di "Dominato (da fonte)")
    conditions_to_link = get_condition_names(soup)
    if not conditions_to_link:
        print("AVVISO: Nessuna condizione trovata nella pre-passata.")
    
    accordion_container = soup.find('div', class_='panel-group', id='accordion-3')
    if not accordion_container:
        print(f"ERRORE: Contenitore principale {base_name} non trovato.")
        return 0

    # Benefici: ogni group_element è una categoria (Generali, Razza A, Classe B)
    group_elements = accordion_container.find_all('div', class_='panel-default')
    
    processed_count = 0
    item_type = ITEM_TYPE_MAP[base_name]

    for group_element in group_elements:
        
        # 1. Estrazione del NOME (dal titolo dell'Accordion)
        group_tag = group_element.find('h4', class_='panel-title')
        name = "Sconosciuto"
        if group_tag and group_tag.find('a'):
            # Il nome della Condizione è nel testo del link (es. "Accecato")
            # Uso split('(') per rimuovere eventuali parentesi, anche se non presenti nel tuo esempio
            name = group_tag.find('a').text.strip().split('(')[0].strip()
        
        # 2. Estrazione del CONTENUTO/DESCRIZIONE (dal panel-body)
        panel_body_tag = group_element.find('div', class_='panel-collapse')
        if not panel_body_tag: continue # Salta se non c'è il corpo collassabile

        # Trova il corpo visibile del contenuto
        content_div = panel_body_tag.find('div', class_='panel-body')
        
        description_html = ""
        if content_div:
            # Per le Condizioni, il contenuto rilevante è la lista <ul>
            list_tag = content_div.find('ul', class_='list-icons')
            
            if list_tag:
                description_html = str(list_tag)
            else:
                description_html = "".join(str(c) for c in content_div.contents).strip()
        
        description_md = clean_and_convert_list(description_html)
        
        # >>> APPLICAZIONE DEI LINK INTERNI DINAMICI <<<
        description_md_linked = link_conditions(description_md, conditions_to_link)
        
        # --- Formattazione Frontmatter ---
        
        # Parametri fissi per Condizioni
        class_name = "Generali"
        level = "0" # Livello non rilevante per le condizioni
        cost = "0"  # Costo non rilevante per le condizioni
        
        frontmatter_content = f"""type: {item_type}
class: "{class_name}"
level: {level}
cost: {cost}
"""
        # Il titolo del blocco di testo è 'Effetti' per chiarezza
        frontmatter = f"""---
{frontmatter_content.strip()}
---

**Effetti della Condizione**
{description_md_linked}"""

        # --- Salvataggio File ---
        invalid_chars = r'[<>:"/\\|?*]'
        file_name = re.sub(invalid_chars, '', f"{name}.md")
        
        # Salva i file in una sottocartella chiamata "Condizioni"
        os.makedirs(base_output_folder, exist_ok=True)
        
        output_file_path = os.path.join(base_output_folder, file_name)
        
        try:
            with open(output_file_path, 'w', encoding='utf8') as out_f:
                out_f.write(frontmatter)
            processed_count += 1
        except Exception as e:
            print(f"ERRORE: Impossibile salvare il file {file_name} in {base_output_folder}. {e}")

    return processed_count

def get_condition_names(soup):
    """
    Esegue una pre-passata per estrarre tutti i nomi delle Condizioni
    dall'intestazione dell'accordion.
    Gestisce i casi come "Dominato (da fonte)" estraendo solo "Dominato".
    """
    condition_names = set()
    accordion_container = soup.find('div', class_='panel-group', id='accordion-3')
    
    if not accordion_container:
        return condition_names

    group_elements = accordion_container.find_all('div', class_='panel-default')
    
    for group_element in group_elements:
        group_tag = group_element.find('h4', class_='panel-title')
        if group_tag and group_tag.find('a'):
            name_raw = group_tag.find('a').text.strip()
            
            # Pulizia: prende solo il nome principale prima di eventuali parentesi
            name = name_raw.split('(')[0].strip()
            
            # Pulizia per rimuovere spazi aggiuntivi o punteggiatura finale
            name = name.strip() 
            
            if name:
                condition_names.add(name)
                
    return list(condition_names)

def process_simple_page(soup, output_folder, base_name):
    """Gestisce l'estrazione per file HTML semplici o come fallback (Razze_Classi)."""
    
    main_content = soup.find('div', class_='container body-content')
    if main_content:
        content_to_convert = str(main_content)
        
        markdown_content = clean_and_convert(content_to_convert)
        
        output_file_path = os.path.join(output_folder, f"{base_name}_Completo.md")
        try:
            with open(output_file_path, 'w', encoding='utf8') as out_f:
                out_f.write(markdown_content)
            return 1 
        except Exception as e:
            print(f"ERRORE: Impossibile salvare il file {base_name}_Completo.md. {e}")
            return 0 
    else:
        print(f"AVVISO: Impossibile trovare il contenuto principale per {base_name}. Nessun file salvato.")
        return 0
               
# ----------------------------------------------------------------------
# FASE 5: FUNZIONE DI DELEGA PRINCIPALE
# ----------------------------------------------------------------------

def process_file(html_file_path, output_base_dir):
    """Delega l'elaborazione del file alla funzione corretta in base al suo nome."""
    
    base_name = os.path.splitext(os.path.basename(html_file_path))[0]
    base_output_folder = os.path.join(output_base_dir, base_name)
    
    print(f"\n-> Elaborazione in corso per {base_name}...")
    os.makedirs(base_output_folder, exist_ok=True)
    
    try:
        with open(html_file_path, 'r', encoding='utf8') as f:
            html_doc = f.read()
    except Exception as e:
        print(f"ERRORE: Impossibile leggere il file {html_file_path}. {e}")
        return

    soup = BeautifulSoup(html_doc, 'html.parser')
    
    processed_count = 0
    
    # 1. Gestione Talenti (Struttura Complessa TABS/Accordion)
    if base_name == "Talenti":
        processed_count = process_box_structure(soup, base_output_folder, base_name, fixed_cost="5")
        
    # 2. Gestione Struttura Box (Discipline/Stili: costo 4)
    elif base_name in ["Discipline", "Stili"]:
        processed_count = process_box_structure(soup, base_output_folder, base_name, fixed_cost="4")

    # 3. Gestione Benefici (Struttura Accordion)
    elif base_name in ["Benefici"]:
        processed_count = process_benefits(soup, base_output_folder, base_name)

    # 4. Gestione Poteri/Stili/Incantesimi (Struttura Tabella)
    elif base_name in ["Stili", "Incantesimi", "Preghiere", "Discipline"]:
        processed_count = process_powers_table(soup, base_output_folder, base_name, fixed_cost="1")
        
    # 5. Gestione Pagine Semplici
    elif base_name in ["Razze_Classi"]:
        processed_count = process_simple_page(soup, base_output_folder, base_name)
    
    # 6. Gestione Condizioni (Struttura Accordion)
    elif base_name in [ "Condizioni"]:
        processed_count = process_conditions(soup, base_output_folder, base_name)

    else:
        print(f"AVVISO: File {base_name} non mappato ad una procedura specifica.")
        return
    
    if processed_count > 0:
        print(f"-> ✅ Salvati {processed_count} elementi in: {base_output_folder}/")
    else:
         print(f"-> ⚠️ Attenzione: 0 elementi estratti o salvataggio come file unico per {base_name}.")

def batch_process_html(input_dir, output_base_dir):
    """Cerca e processa tutti i file HTML nella cartella di input."""
    
    print("\n--- Avvio Conversione HTML in Markdown ---")
    
    search_pattern = os.path.join(input_dir, "*.html")
    html_files = glob.glob(search_pattern)
    
    if not html_files:
        print(f"Nessun file .html trovato in {input_dir}. Assicurati che il download sia andato a buon fine.")
        return

    print(f"Trovati {len(html_files)} file HTML da elaborare.")
    
    for file_path in html_files:
        process_file(file_path, output_base_dir)

# Chiavi per il parsing dei metadati di Incantesimi/Poteri
SPELL_META_KEYS = [
    "Descrittori", "Componenti", "Azioni", "Area", 
    "Bersagli", "Durata", "Recupero", "Effetto" # Effetto è l'ultima e contiene la descrizione principale
]

def parse_metadata_from_text(text: str, keys: List[str]) -> Dict[str, str]:
    """Simula il parsing avanzato dei metadati dal testo della descrizione."""
    metadata = {}
    remaining_text = text

    # Per l'esempio di Allarme: l'effetto principale è l'unico testo che rimane.
    # In un ambiente reale, questa funzione dovrebbe estrarre i metadati usando le chiavi
    # e lasciare il resto come "Effetto".
    
    # Esempio semplificato: assumiamo che se le chiavi non sono trovate, l'intero testo
    # sia l'Effetto.
    
    # Implementazione di esempio per simulare il comportamento desiderato:
    # rimuove le righe vuote e simula l'estrazione.
    
    body_parts = []
    
    for line in text.split('\n'):
        line = line.strip()
        is_metadata = False
        for key in keys:
            if line.lower().startswith(key.lower() + ':'):
                metadata[key] = line.split(':', 1)[1].strip()
                is_metadata = True
                break
        if not is_metadata and line:
            body_parts.append(line)
            
    metadata["Effetto"] = "\n\n".join(body_parts)

    return metadata

# ----------------------------------------------------------------------
# PUNTO DI INGRESSO PRINCIPALE
# ----------------------------------------------------------------------

if __name__ == "__main__":
    os.makedirs(OUTPUT_BASE_DIR, exist_ok=True)
    
    # 1. Esegue il download utilizzando Curl
    # download_files_with_curl(URLS, INPUT_DIR)
    
    # 2. Esegue la conversione in batch
    batch_process_html(INPUT_DIR, OUTPUT_BASE_DIR)
    
    print("\n--- Processo Totale Completato ---")