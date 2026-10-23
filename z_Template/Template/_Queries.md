## PNG-Location

```dataviewjs  
// Otteniamo il nome del file dove viene eseguita la query (la nota Location)
const activeFile = app.workspace.getActiveFile(); 
const callerFileName = activeFile ? activeFile.basename : dv.current().file.name;
// Usa per debugging 
//dv.header(4, callerFileName);

// 2. Eseguiamo la query e salviamo i dati in una variabile 'data'
const data = dv.pages('"Campagna - Sangue/PNG"')
    .where(f => f.type === "PNG")
    .where(f => {
        if (!f.location) return false; 
        const alocations = Array.isArray(f.location) ? f.location : [f.location]; 
        return alocations.some(link => link.path.includes(callerFileName));
    });

// 3. Generiamo la tabella usando i dati mappati
dv.table(
    ["Nome", "Razza", "Occupazione", "Organizzazione"], 
    data.map(p => [p.file.link, p.razza, p.occupazione, p.organizzazione])
);

// 4. Conta le righe correttamente dai dati filtrati
const rowCount = data.length; 

// 5. Aggiorna il titolo del callout
setTimeout(() => {
    const calloutTitle = document.querySelector('.callout[data-callout="png"] .callout-title');
    if (calloutTitle) {
        calloutTitle.dataset.rows = rowCount;
    }
}, 100);

``` 
^query-png-location

## PNG-organizzazioni
```dataviewjs  
// Otteniamo il nome del file dove viene eseguita la query (la nota Location)
const activeFile = app.workspace.getActiveFile(); 
const callerFileName = activeFile ? activeFile.basename : dv.current().file.name;
// Usa per debugging 
//dv.header(4, callerFileName);

// 2. Filtriamo le pagine e salviamo il risultato in una variabile 'results'
const results = dv.pages('"Campagna - Sangue/PNG"')
    .where(f => f.type === "PNG")
    .where(f => {
        // Controllo esistenza organizzazione
        if (!f.organizzazione) return false; 
        // Normalizzazione in array (per gestire link singoli o multipli)
        const organizzazioni = Array.isArray(f.organizzazione) ? f.organizzazione : [f.organizzazione]; 
        // Controllo se il file corrente è incluso tra le organizzazioni
        return organizzazioni.some(link => link.path.includes(callerFileName));
    });

// 3. Mostriamo la tabella usando i risultati filtrati
dv.table(
    ["Nome", "Razza", "Occupazione", "Location"], 
    results.map(p => [p.file.link, p.razza, p.occupazione, p.location])
);

// 4. Contiamo le righe direttamente dalla variabile 'results'
const rows = results.length;

// 5. Iniettiamo il numero nel titolo del callout
setTimeout(() => {
    const calloutTitle = document.querySelector('.callout[data-callout="png"] .callout-title');
    if (calloutTitle) {
        calloutTitle.dataset.rows = rows;
    }
}, 100);
``` 
^query-png-organizzazioni

## Organizzazioni
 
```dataviewjs
// Otteniamo il nome del file dove viene eseguita la query (la nota Location)
const activeFile = app.workspace.getActiveFile(); 
const callerFileName = activeFile ? activeFile.basename : dv.current().file.name;
// Usa per debugging 
//dv.header(4, callerFileName);
            
// 2. Eseguiamo la query e salviamo il risultato in 'organizzazioni'
const organizzazioni = dv.pages('"Campagna - Sangue/Organizzazioni"')
    .where(f => f.type === "Organizzazione")
    .where(f => {
        // Controlla che 'location' esista 
        if (!f.location) return false; 
        // Forza 'f.location' ad essere un array
        const alocations = Array.isArray(f.location) ? f.location : [f.location]; 
        // Verifica la corrispondenza col file chiamante
        return alocations.some(link => link.path.includes(callerFileName));
    });

// 3. Generiamo la tabella
dv.table(["Nome"], organizzazioni.map(p => [p.file.link]));

// 4. Conta le righe dai risultati della query
const rows = organizzazioni.length; 

// 5. Aggiorna il titolo del callout
setTimeout(() => {
    const calloutTitle = document.querySelector('.callout[data-callout="organizzazioni"] .callout-title');
    if (calloutTitle) {
        calloutTitle.dataset.rows = rows;
    }
}, 100);
```
^query-organizzazioni

## Sub Location

```dataviewjs
// Otteniamo il nome del file dove viene eseguita la query (la nota Location)
const activeFile = app.workspace.getActiveFile(); 
const callerFileName = activeFile ? activeFile.basename : dv.current().file.name;
// Usa per debugging 
//dv.header(4, callerFileName);
           
// 2. Eseguiamo la query e salviamo il risultato in 'locations'
const locations = dv.pages('"Campagna - Sangue/Location"')
    .where(f => f.type === "Location")
    .where(f => {
        // Controlla che 'parent' esista 
        if (!f.parent) return false; 
        // Forza 'f.parent' ad essere un array
        const aparents = Array.isArray(f.parent) ? f.parent : [f.parent]; 
        // Verifica la corrispondenza col file chiamante
        return aparents.some(link => link.path.includes(callerFileName));
    });

// 3. Generiamo la tabella
dv.table(["Nome", "Tipo"], locations.map(p => [p.file.link, p.tipo_location]));

// 4. Conta le righe dai risultati salvati
const rows = locations.length; 

// 5. Aggiorna il titolo del callout (selettore: sublocation)
setTimeout(() => {
    const calloutTitle = document.querySelector('.callout[data-callout="sublocation"] .callout-title');
    if (calloutTitle) {
        calloutTitle.dataset.rows = rows;
    }
}, 100);
```
^query-sublocation

## Appare in 
```dataviewjs
// Query DataviewJS: Trova TUTTE le note che hanno un link in entrata
// verso la nota corrente, senza l'uso di una proprietà specifica
// Questa logica si basa sul campo implicito 'file.inlinks' di Dataview.

// 1. Ottiene il percorso della nota corrente per il confronto.
const activeFile = app.workspace.getActiveFile(); 
const callerFilePath = activeFile ? activeFile.path : dv.current().file.path;

// 2. Definisce la cartella di origine per la ricerca.
// Puoi lasciare "" (virgolette vuote) per cercare nell'intera vault.
const sourceFolder = "Campagna - Sangue";

// 3. Esegue la query.
const results = dv.pages(`"${sourceFolder}"`)
    .where(f => {
        // Controlliamo i link IN USCITA della nota candidata 'f'
        // e vediamo se l'URL di destinazione è la nota corrente.
        const outlinks = f.file.outlinks;
        // Se non ci sono link in uscita, non può linkare la nota corrente.
        if (!outlinks || outlinks.length === 0) return false;  

        // La logica: verifica se almeno un link in uscita di 'f' punta alla nota corrente.
        return outlinks.some(link => link.path === callerFilePath);
    })

    // 4. Mappa il risultato per visualizzare solo le informazioni del file e la cartella.
    .map(p => {
        // Estrai il percorso completo della cartella (es. "Campagna - Sangue/Location")
        const fullFolder = p.file.folder;
        // Dividi il percorso e prendi l'ultimo elemento ("Location")
        const folderParts = fullFolder.split('/');
        const specificFolder = folderParts[folderParts.length - 1]; 

        return [
            p.file.link,         // 1. Link alla nota che punta qui
            specificFolder
        ];
    });  

// 5. Visualizza i risultati in una tabella, aggiornando l'intestazione.
dv.table(
    ["Nota", "Cartella"],
    results
);

// ----- Conta le righe -----
const rows = results.length;          // <-- numero di righe
   
setTimeout(() => {
    const calloutTitle = document.querySelector('.callout[data-callout="apparein"] .callout-title');
    if (calloutTitle) {
        calloutTitle.dataset.rows = rows;
    }
}, 100);
```
^query-apparein
