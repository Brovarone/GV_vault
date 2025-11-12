## PNG

```dataviewjs  
// Otteniamo il nome del file dove viene eseguita la query (la nota Location)
const activeFile = app.workspace.getActiveFile(); 
const callerFileName = activeFile ? activeFile.basename : dv.current().file.name;
// Usa per debugging 
//dv.header(4, callerFileName);

// ----- 1. Conta le righe -----
const rows = dv.pages('"Campagna - Sangue/PNG"')
               .where(f => f.type === "PNG")
               .where(f => {
                   if (!f.location) return false;
                   const loc = Array.isArray(f.location) ? f.location : [f.location];
                   return loc.some(l => l.path.includes(callerFileName));
               })
               .length;          // <-- numero di righe

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


// ----- 3. Salva il conteggio in un elemento nascosto -----
dv.span(`<span class="dv-count" style="display:none;">${rows}</span>`);


// ----- 4. Dopo il rendering, copia il valore nel titolo del callout -----
setTimeout(() => {
    const countEl = document.querySelector('.dv-count');
    if (!countEl) return;

    const calloutTitle = document.querySelector('.callout[data-callout="png"] .callout-title');
    if (calloutTitle) {
        calloutTitle.dataset.rows = countEl.textContent;   // mette l'attributo data-rows. Si puo' usare anche row
    }
}, 100);

``` 
^query-png

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
```
^query-sublocation