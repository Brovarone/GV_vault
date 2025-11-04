---
tags:
  - quest
alias:
  - Inserisci un nome breve/soprannome della Quest
tipo_quest: principale
stato: attiva
priorita: alta
datore_di_lavoro: "[[Baldric]]"
luogo_partenza: "[[Nome Luogo]]"
ricompensa: Descrivi qui la ricompensa (es. 500 mo, Spada +1)
scadenza_stimata: Tra X giorni o una data specifica
data_inizio: 2025-10-07
data_completamento:
status: In corso
scadenza:
location:
type:
class:
datore:
cazzo: 
singolo: 
---
# Quest: Senza nome


dataview si
```dataview
LIST file.folder from "Campagna - Sangue/Location"
```

No a volte si
```dataviewjs
const DQL = ` LIST FROM "Campagna - Sangue/Location" `; 
// dv.query() ritorna un oggetto risultato, non stampa direttamente 
const results = await dv.query(DQL); 
// Bisogna formattare e stampare i risultati 
if (results.successful) { 
	dv.paragraph(results.value.html); 
}
```
questa ok !
```dataviewjs
dv.list(dv.pages('"Campagna - Sangue/Location"').map(p => p.file.link));
```
NO, ora va !!!!!
```dataviewjs
// Uso dv.list() per stampare la collezione di link come una lista formattata
dv.list(
    dv.pages('')
        .filter(p => p.file.path.includes('Campagna - Sangue/Location'))
        .map(p => p.file.link)
);
```


> **Obiettivo Principale:** Consegnare il baule a un gruppo di Nani che si trovano oltre il passo montano.

| Valore                     | Proprietà               |     |
| :------------------------- | :---------------------- | --- |
|                            | **Datore di Lavoro**    |     |
| [[$= this.luogo_partenza]] | **Luogo di Partenza**   |     |
| **$= this.ricompensa**     | **Ricompensa Promessa** |     |
| **$= this.stato**          | **Stato Attuale**       |     |
| **$= this.priorita**       | **Priorità**            |     |

## Passo Passo (Sotto-obiettivi)
*Utilizza le checkboxes per segnare i progressi.*

### Fase 1: Investigazione
- [ ] 
- [ ] 

### Fase 2: Azione
- [ ] 
- [ ] 

### Fase 3: Conclusione
- [ ] Ritorna dal [[{{datore_di_lavoro}}]] per riscuotere la {{ricompensa}}.

---

## Note e Piste

* **Connessioni:** Questa quest potrebbe essere collegata a [[Storia - Rivalità tra Gilde]].
* **Ostacoli:** Un drago è stato avvistato vicino all'ultima posizione del Pugnale.
* **Risorse:** Ho bisogno di un veleno per addormentare i cani da guardia.

## Riassunto (A Fine Quest)
*Quando la quest è completata o fallita, inserisci qui un breve resoconto.*


