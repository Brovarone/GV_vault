## PNG-Location

```dataviewjs  
// Otteniamo il nome del file dove viene eseguita la query (la nota Location)
const activeFile = app.workspace.getActiveFile(); 
const callerFileName = activeFile ? activeFile.basename : dv.current().file.name;
// Usa per debugging 
//dv.header(4, callerFileName);

dv.table( ["Nome", "Razza", "Occupazione", "Organizzazione"], dv.pages('"Campagna - Sangue/PNG"')
.where(f => f.type === "PNG")
.where(f => {
// 1. Controlla che 'location' esista 
if (!f.location) return false; 
// 2. Forziamo 'f.location' ad essere un array, anche se è un singolo link 
const alocations = Array.isArray(f.location) ? f.location : [f.location]; 
// 3. Applichiamo la logica 'some' solo sull'array 
return alocations.some(link => link.path.includes(callerFileName) );
})
.map(p =>  [p.file.link, p.razza, p.occupazione , p.organizzazione] )) ;

// ----- Conta le righe -----
const rows = alocation.lenght        // <-- numero di righe

setTimeout(() => {
    const calloutTitle = document.querySelector('.callout[data-callout="png"] .callout-title');
    if (calloutTitle) {
        calloutTitle.dataset.rows = rows;
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

dv.table( ["Nome", "Razza", "Occupazione", "Location"], dv.pages('"Campagna - Sangue/PNG"')
.where(f => f.type === "PNG")
.where(f => {
// 1. Controlla che 'location' esista 
if (!f.organizzazione) return false; 
// 2. Forziamo 'f.location' ad essere un array, anche se è un singolo link 
const aorganizzazione = Array.isArray(f.organizzazione) ? f.organizzazione : [f.organizzazione]; 
// 3. Applichiamo la logica 'some' solo sull'array 
return aorganizzazione.some(link => link.path.includes(callerFileName) );
})
.map(p =>  [p.file.link, p.razza, p.occupazione, p.location] )) ;

// ----- 1. Conta le righe -----
const rows = aorganizzazione.length;          // <-- numero di righe

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
            
dv.table( ["Nome"], dv.pages('"Campagna - Sangue/Organizzazioni"')
 	.where(f => f.type === "Organizzazione")
 	.where(f => {
 		// 1. Controlla che 'location' esista 
 		if (!f.location) return false; 
 		// 2. Forziamo 'f.location' ad essere un array, anche se è un singolo link 
 		const alocations = Array.isArray(f.location) ? f.location : [f.location]; 
 		// 3. Applichiamo la logica 'some' solo sull'array 
 		return alocations.some(link => link.path.includes(callerFileName) );
 	})
 	.map(p =>  [p.file.link] )) ;
 	
 // ----- 1. Conta le righe -----
const rows = alocations.length;          // <-- numero di righe

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
           
dv.table( ["Nome", "Tipo"], dv.pages('"Campagna - Sangue/Location"')
 	.where(f => f.type === "Location")
 	.where(f => {
 		// 1. Controlla che 'parent' esista 
 		if (!f.parent) return false; 
 		// 2. Forziamo 'f.parent' ad essere un array, anche se è un singolo link 
 		const aparent = Array.isArray(f.parent) ? f.parent : [f.parent]; 
 		// 3. Applichiamo la logica 'some' solo sull'array 
 		return aparent.some(link => link.path.includes(callerFileName) );
 	})
 	.map(p =>  [p.file.link, p.tipo_location] )) ;

// ----- Conta le righe -----
const rows = aparent.length;          // <-- numero di righe
    
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
