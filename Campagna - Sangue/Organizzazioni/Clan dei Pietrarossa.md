---
fileClass:
type: Organizzazione
location: "[[Kaz Dum]]"
---
Padroni del mare 
### Membri
```dataviewjs
// Usa per debugging
//dv.header(4, "Valore Filtro Link: " + dv.current().file.name);
dv.table( ["Nome", "Razza", "Occupazione"], dv.pages('"Campagna - Sangue/PNG"')
	.where(f => f.type === "PNG")
	.where(f => {
		// 1. Controlla che 'location' esista 
		if (!f.organizzazione) return false; 
		// 2. Forziamo 'f.location' ad essere un array, anche se è un singolo link 
		const aorganizzazioni = Array.isArray(f.organizzazione) ? f.organizzazione : [f.organizzazione]; 
		// 3. Applichiamo la logica 'some' solo sull'array 
		return aorganizzazioni.some(link => link.path.includes(dv.current().file.name) );
	})
	.map(p =>  [p.file.link, p.razza, p.occupazione ] )) ;

```