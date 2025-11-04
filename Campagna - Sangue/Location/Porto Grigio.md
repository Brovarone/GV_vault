---
fileClass: location
type: Location
poi:
parent:
tipo_location: Città
picture: ""
---

## Impressioni Generali
* 

## Punti di Interesse (POI)
| POI | Riferimento PNG/Note |
| :-- | :------------------- |
|     |                      |

## Eventi e Scoperte
*

### PNG
```dataviewjs
// Usa per debugging
//dv.header(4, "Valore Filtro Link: " + dv.current().file.name);
dv.table( ["Nome", "Razza", "Occupazione", "Organizzazione"], dv.pages('"Campagna - Sangue/PNG"')
	.where(f => f.type === "PNG")
	.where(f => {
		// 1. Controlla che 'location' esista 
		if (!f.location) return false; 
		// 2. Forziamo 'f.location' ad essere un array, anche se è un singolo link 
		const alocations = Array.isArray(f.location) ? f.location : [f.location]; 
		// 3. Applichiamo la logica 'some' solo sull'array 
		return alocations.some(link => link.path.includes(dv.current().file.name) );
	})
	.map(p =>  [p.file.link, p.razza, p.occupazione , p.organizzazione] )) ;

```

### Organizzazioni
```dataviewjs
//dv.list(dv.pages('"Campagna - Sangue/PNG"').map(p => p.file.link));
dv.table( ["Nome"], dv.pages('"Campagna - Sangue/Organizzazioni"')
	.where(f => f.type === "Organizzazione")
	.where(f => {
		// 1. Controlla che 'location' esista 
		if (!f.location) return false; 
		// 2. Forziamo 'f.location' ad essere un array, anche se è un singolo link 
		const alocations = Array.isArray(f.location) ? f.location : [f.location]; 
		// 3. Applichiamo la logica 'some' solo sull'array 
		return alocations.some(link => link.path.includes(dv.current().file.name) );
	})
	.map(p =>  [p.file.link] )) ;


```