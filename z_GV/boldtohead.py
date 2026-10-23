import os
import re
from pathlib import Path
import shutil

def convert_bold_to_header(md_folder: str = "."):
    """
    Converte tutti i file .md in una directory:
    **Testo** → ## Testo
    """
    md_path = Path(md_folder)
    pattern = re.compile(r'\*\*([^*]+)\*\*')
    
    for md_file in md_path.rglob("*.md"):
        with open(md_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        new_content = pattern.sub(r'## \1', content)
        
        if new_content != content:
            with open(md_file, 'w', encoding='utf-8') as f:
                f.write(new_content)
            print(f"Modificato: {md_file}")


def fix_frontmatter_colons(md_folder: str = "."):
    md_path = Path(md_folder)
    pattern = re.compile(r'^([A-Za-z0-9_-]+):\s*(.+)$')

    for file in md_path.rglob("*.md"):
        text = file.read_text(encoding="utf-8")
        lines = text.splitlines()

        first_fh = None
        second_fh = None

        for i, line in enumerate(lines):
            if line.strip() == "---":
                if first_fh is None:
                    first_fh = i
                else:
                    second_fh = i
                    break

        if first_fh is None or second_fh is None or second_fh <= first_fh:
            continue

        fm_lines = lines[first_fh + 1:second_fh]
        new_fm_lines = []
        changed_fm = False

        for line in fm_lines:
            m = pattern.match(line)
            if not m:
                new_fm_lines.append(line)
                continue

            key, value = m.groups()
            value = value.strip()

            if ":" in value and not (
                (value.startswith('"') and value.endswith('"')) or
                (value.startswith("'") and value.endswith("'"))
            ):
                value_escaped = value.replace('"', '\\"')
                new_line = f'{key}: "{value_escaped}"'
                new_fm_lines.append(new_line)
                changed_fm = True
            else:
                new_fm_lines.append(line)

        if not changed_fm:
            continue

        shutil.copy2(file, str(file) + ".bak")
        new_lines = lines[:first_fh + 1] + new_fm_lines + lines[second_fh:]
        new_text = "\n".join(new_lines) + "\n"
        file.write_text(new_text, encoding="utf-8")
        print(f"Corretto: {file}")

    

# Esempio di uso:
convert_bold_to_header("C:\\Users\\Cristiano\\Documents\\Obsidian\\D&D\\D&D\\z_GV\\Benefici" )
# fix_frontmatter_colons("C:\\Users\\Cristiano\\Documents\\Obsidian\\D&D\\D&D\\z_GV\\Incantesimi")