---
razza: Nano
classe1: Bardo
classe1_max: 2
classe2: Vagabondo
classe2_max: 2
classe3: Mago
classe3_max: 1
path_talenti: z_GV/Talenti
---

## 🎲 Talenti Sbloccati per il tuo Multiclasse

>[!SUMMARY]+ Elenco Talenti
>```dataviewjs
>// 1. Lettura dinamica del Path dal frontmatter (dv.current().path_talenti)
>const path = dv.current().path_talenti;
>
>// 2. Definizione dei parametri del multiclasse
>const max_livello_totale = dv.current().classe1_max + dv.current().classe2_max + dv.current().classe3_max;
>const classe1 = dv.current().classe1;
>const max_classe1 = dv.current().classe1_max;
>const classe2 = dv.current().classe2;
>const max_classe2 = dv.current().classe2_max;
>const classe3 = dv.current().classe3;
>const max_classe3 = dv.current().classe3_max;
>const razza = dv.current().razza;
>
>// 3. Esecuzione della query: filtra in base al path e alla logica multiclasse
>const risultati = dv.pages(`"${path}"`)
>    .where(p => p.type === "Talento")
>    .where(p => 
>        (
>            // Talenti Generali o di Razza: livello totale di personaggio
>            (p.class === "Generali" || p.class === razza) && p.level <= max_livello_totale
>        ) || (
>            // Classe 1: livello massimo di Classe 1
>            p.class === classe1 && p.level <= max_classe1
>        ) || (
>            // Classe 2: livello massimo di Classe 2
>            p.class === classe2 && p.level <= max_classe2
>        ) || (
>            // Classe 3: livello massimo di Classe 3
>            p.class === classe3 && p.level <= max_classe3
>        )
>    )
>    .sort(p => p.class, 'asc')
>    .sort(p => p.level, 'asc')
>    .sort(p => p.file.name, 'asc');
>
>// 4. Visualizzazione dei risultati in una tabella
>dv.table(
>    ["Nome", "Classe", "Livello", "Albero/Stile", "Prerequisiti"], 
>    risultati.map(p => [
>        p.file.link, 
>        p.class,
>        p.level,
>        p.group_name,
>        p.prerequisites
>    ])
>);
>```


> `LIST` 
>  `FROM ""`
> `WHERE` 
>  `type = "Talento"`
>   `AND (`
>	    `(`
>            `(class = "Generali" or class = this.razza)`
>            `AND level <= (this.classe1_max + this.classe2_max + this.classe3_max )`
>        `)`
>        `OR`
>        `(`
>            `class = this.classe1` 
>            `AND level <= this.classe1_max`
>        `)` 
>        `OR` 
>        `(`
>            `class = this.classe2` 
>            `AND level <= this.classe2_max`
>        `)` 
>        `OR` 
>        `(`
>            `class = this.classe3` 
>            `AND level <= this.classe3_max`
>        `)`
>    `)`
>`SORT class ASC, level ASC, file.name ASC`
```

>[!TIP]
> ciao 2

>[!infobox]
> ciao

>[!INFO]
> ciao

