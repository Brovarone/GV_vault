# Nome del file in cui hai salvato il blocco di testo con tutti i Talenti
# ASSICURATI DI INCOLLARE IL BLOCCO DI TESTO DEI TALENTI IN QUESTO SCRIPT DOVE INDICATO SOTTO,
# oppure cambia il valore di $InputFile al nome del file dove hai salvato i dati.
$TalentiBlocco = @"
--- FILE: Addestramento in un’arma esotica.md ---
---
name: Addestramento in un’arma esotica
type: Talento
group: Generali
level: 1
prerequisites: Addestramento in un’arma dello stesso gruppo
---

**Descrizione**
Acquisisce l’addestramento in un’arma esotica

--- FILE: Addestramento in un’armatura esotica.md ---
---
name: Addestramento in un’armatura esotica
type: Talento
group: Generali
level: 1
prerequisites: Addestramento in un’armatura dello stesso gruppo
---

**Descrizione**
Acquisisce l’addestramento in un’armatura esotica

--- FILE: Azione specializzata (azione).md ---
---
name: Azione specializzata (azione)
type: Talento
group: Generali
level: 1
prerequisites: Nessuno
actions: 1
---

**Descrizione**
L’azione selezionata avrà un costo in azioni ridotto di 1. Le azioni selezionabili sono: carica, sbilanciare, combattere a due armi, afferrare, disturbare, disarmare

--- FILE: Combattere alla cieca.md ---
---
name: Combattere alla cieca
type: Talento
group: Generali
level: 1
prerequisites: Nessuno
---

**Descrizione**
+2 al tiro per colpire in mischia quando il bersaglio è sotto l'effetto di occultamento o occultamento totale

--- FILE: Competenza in un’arma (arma).md ---
---
name: Competenza in un’arma (arma)
type: Talento
group: Generali
level: 1
prerequisites: Addestramento nell’arma
---

**Descrizione**
+1 al tiro per colpire quando utilizza l’arma selezionata

--- FILE: Punti ferita aggiuntivi.md ---
---
name: Punti ferita aggiuntivi
type: Talento
group: Generali
level: 1
prerequisites: Nessuno
---

**Descrizione**
Il personaggio ottiene 3 punti ferita

**Speciale**
Questo talento si può prendere più volte, anche durante lo stesso passaggio di livello.

--- FILE: Robustezza divina.md ---
---
name: Robustezza divina
type: Talento
group: Generali
level: 1
prerequisites: Nessuno
---

**Descrizione**
Aggiunge 5 punti al suo punteggio di soglia divina

--- FILE: Robustezza magica.md ---
---
name: Robustezza magica
type: Talento
group: Generali
level: 1
prerequisites: Nessuno
---

**Descrizione**
Aggiunge 5 punti al suo punteggio di soglia magica

--- FILE: Tiro ravvicinato.md ---
---
name: Tiro ravvicinato
type: Talento
group: Generali
level: 1
prerequisites: Nessuno
---

**Descrizione**
+1 al tiro per colpire a distanza quando il bersaglio si trova entro metà dell’incremento di gittata

--- FILE: Infarinatura 1.md ---
---
name: Infarinatura 1
type: Talento
group: Generali
level: 2
prerequisites: Nessuno
---

**Descrizione**
Acquisisce i rudimenti di un’altra classe: Guerriero: acquisisce un talento di livello 1. Mago: acquisisce un incantesimo di primo livello come capacità magica. Sacerdote: acquisisce una preghiera di primo livello come capacità divina. Vagabondo: acquisisce uno stile di livello 1

**Speciale**
Non è possibile acquistare questo talento se si possiedono livelli della classe selezionata o si sta eseguendo il passaggio di livello al primo livello di una classe.

--- FILE: Mantenere potere.md ---
---
name: Mantenere potere
type: Talento
group: Generali
level: 2
prerequisites: Nessuno
---

**Descrizione**
+4 alle prove di concentrazione per non perdere un potere in mantenimento

--- FILE: Seguace combattente.md ---
---
name: Seguace combattente
type: Talento
group: Generali
level: 2
prerequisites: Seguace animale
---

**Descrizione**
Il seguace animale guadagna un livello. Il seguace sarà in grado di combattere attivamente seguendo le direttive del suo padrone, può dare un compito al seguace con l’azione standard

--- FILE: Tiro lontano.md ---
---
name: Tiro lontano
type: Talento
group: Generali
level: 2
prerequisites: Nessuno
---

**Descrizione**
Riduce di 2 il malus causato dall’incremento di gittata

--- FILE: Resistenza al divino.md ---
---
name: Resistenza al divino
type: Talento
group: Generali
level: 3
prerequisites: Nessuno
---

**Descrizione**
+2 alle difese contro attacchi di origine divina

--- FILE: Resistenza al magico.md ---
---
name: Resistenza al magico
type: Talento
group: Generali
level: 3
prerequisites: Nessuno
---

**Descrizione**
+2 alle difese contro attacchi di origine magica

--- FILE: Seguace Animale in contatto.md ---
---
name: Seguace Animale in contatto
type: Talento
group: Generali
level: 3
prerequisites: Seguace animale potenziato
---

**Descrizione**
Il seguace animale guadagna un livello. riesce a creare un lieve legame telepatico con l’animale: percepisce distanza e direzione dell'animale, il suo stato di salute e l’emozione predominante che sta provando

--- FILE: Tiro in sella.md ---
---
name: Tiro in sella
type: Talento
group: Generali
level: 3
prerequisites: Combattere in sella
---

**Descrizione**
Dimezza le penalità al tiro per colpire in caso di attacco a distanza durante il combattimento in sella

--- FILE: Infarinatura 2.md ---
---
name: Infarinatura 2
type: Talento
group: Generali
level: 4
prerequisites: Infarinatura 1
---

**Descrizione**
Migliora i rudimenti della classe selezionata: Guerriero: acquisisce un talento di livello 2. Mago: acquisisce un incantesimo di secondo livello come capacità magica. Sacerdote: acquisisce una preghiera di secondo livello come capacità divina. Vagabondo: acquisisce uno stile di livello 1 di qualsiasi albero

**Speciale**
Non è possibile acquistare questo talento se si possiedono livelli della classe selezionata o si sta eseguendo il passaggio di livello al un primo livello di una classe.

--- FILE: Ingaggio migliorato.md ---
---
name: Ingaggio migliorato
type: Talento
group: Generali
level: 4
prerequisites: Nessuno
---

**Descrizione**
Incrementa il proprio valore di ingaggio di 1

--- FILE: Resistere ai critici.md ---
---
name: Resistere ai critici
type: Talento
group: Generali
level: 4
prerequisites: Nessuno
---

**Descrizione**
Il personaggio riduce di 1 la minaccia di critico degli avversari che lo attaccano

--- FILE: Riflessi fulminei.md ---
---
name: Riflessi fulminei
type: Talento
group: Generali
level: 4
prerequisites: Nessuno
---

**Descrizione**
+1 Riflessi

--- FILE: Tempra possente.md ---
---
name: Tempra possente
type: Talento
group: Generali
level: 4
prerequisites: Nessuno
---

**Descrizione**
+1 Tempra

--- FILE: Tiro in mischia.md ---
---
name: Tiro in mischia
type: Talento
group: Generali
level: 4
prerequisites: Nessuno
---

**Descrizione**
quando si effettua un attacco contro un bersaglio impegnato in mischia si può ignorare un malus di -2 dato dalla presenza di nemici del bersaglio adiacenti allo stesso.

**Speciale**
Vedi regolamento per i dettagli sull'attacco a distanza

--- FILE: Volontà di ferro.md ---
---
name: Volontà di ferro
type: Talento
group: Generali
level: 4
prerequisites: Nessuno
---

**Descrizione**
+1 Volontà

--- FILE: Carisma da intrattenitore.md ---
---
name: Carisma da intrattenitore
type: Talento
group: Generali
level: 5
prerequisites: Nessuno
---

**Descrizione**
+5 alle prove di Carisma

--- FILE: Costituzione possente.md ---
---
name: Costituzione possente
type: Talento
group: Generali
level: 5
prerequisites: Nessuno
---

**Descrizione**
+5 alle prove di Costituzione

--- FILE: Destrezza fulminea.md ---
---
name: Destrezza fulminea
type: Talento
group: Generali
level: 5
prerequisites: Nessuno
---

**Descrizione**
+5 alle prove di Destrezza

--- FILE: Forza brutale.md ---
---
name: Forza brutale
type: Talento
group: Generali
level: 5
prerequisites: Nessuno
---

**Descrizione**
+5 alle prove di Forza

--- FILE: Intelligenza superiore.md ---
---
name: Intelligenza superiore
type: Talento
group: Generali
level: 5
prerequisites: Nessuno
---

**Descrizione**
+5 alle prove di Intelligenza

--- FILE: Saggezza di ferro.md ---
---
name: Saggezza di ferro
type: Talento
group: Generali
level: 5
prerequisites: Nessuno
---

**Descrizione**
+5 alle prove di Saggezza

--- FILE: Seguace Animale migliorato.md ---
---
name: Seguace Animale migliorato
type: Talento
group: Generali
level: 5
prerequisites: Seguace animale potenziato
---

**Descrizione**
Il seguace animale guadagna un livello. Il seguace utilizza i punteggi Riflessi, Tempra e Volontà del personaggio anziché i propri se migliori

--- FILE: Infarinatura 3.md ---
---
name: Infarinatura 3
type: Talento
group: Generali
level: 6
prerequisites: Infarinatura 2
---

**Descrizione**
Migliora i rudimenti della classe selzionata: Guerriero: acquisisce un talento di livello 3. Mago: acquisisce un incantesimo di terzo livello come capacità magica. Sacerdote: acquisisce una preghiera di terzo livello come capacità divina. Vagabondo: acquisisce una diplina di livello 3 di qualsiasi albero e stile

**Speciale**
Non è possibile acquistare questo talento se si possiedono livelli della classe selezionata o si sta eseguendo il passaggio di livello al un primo livello di una classe.

--- FILE: Passo agile (Folletto).md ---
---
name: Passo agile
type: Talento
group: Folletto
level: 1
prerequisites: Nessuno
---

**Descrizione**
Riduce di 1 il rallentamento dovuto al terreno difficile di origine naturale

--- FILE: Armi dei folletti.md ---
---
name: Armi dei folletti
type: Talento
group: Folletto
level: 2
prerequisites: Nessuno
---

**Descrizione**
+1 ai danni con mazze e lance

--- FILE: Divincolarsi.md ---
---
name: Divincolarsi
type: Talento
group: Folletto
level: 2
prerequisites: Nessuno
---

**Descrizione**
+2 ai tiri salvezza per le condizioni di afferrato, rallentato, immobilizzato e paralizzato

--- FILE: Affrontare la natura.md ---
---
name: Affrontare la natura
type: Talento
group: Folletto
level: 3
prerequisites: Nessuno
---

**Descrizione**
+2 a tiri per colpire e danni contro animali e vegetali

--- FILE: Resilienza al divino (Folletto).md ---
---
name: Resilienza al divino
type: Talento
group: Folletto
level: 3
prerequisites: Nessuno
---

**Descrizione**
+2 alle difese contro attacchi di origine divina

--- FILE: Rimedi naturali.md ---
---
name: Rimedi naturali
type: Talento
group: Folletto
level: 4
prerequisites: Nessuno
---

**Descrizione**
+5 alle prove di Saggezza legate alla guarigione e aggiunge 4 punti ferita quando recupera punti ferita, quando assiste personaggi durante il riposo e quando esegue poteri di cura.

--- FILE: Sfuggire ai giganti.md ---
---
name: Sfuggire ai giganti
type: Talento
group: Folletto
level: 4
prerequisites: Nessuno
---

**Descrizione**
+2 alla CA e DR contro attacchi in mischia da creature di taglia Media o superiore

--- FILE: Dote umana.md ---
---
name: Dote umana
type: Talento
group: Umano
level: 2
prerequisites: Nessuno
---

**Descrizione**
Ottiene un talento di primo livello di qualsiasi razza

--- FILE: Attacco sconsiderato.md ---
---
name: Attacco sconsiderato
type: Talento
group: Guerriero
level: 1
prerequisites: Nessuno
actions: 1
---

**Descrizione**
Può applicare una penalità alle difese fino a un massimo del suo livello di classe (massimo 3), ottiene un bonus ai danni in mischia di uguale entità per un round

--- FILE: Competenza nell'elmo.md ---
---
name: Competenza nell'elmo
type: Talento
group: Guerriero
level: 1
prerequisites: Nessuno
---

**Descrizione**
Riduce di uno la minaccia di critico dell’attaccante

--- FILE: Concentrarsi sul nemico.md ---
---
name: Concentrarsi sul nemico
type: Talento
group: Guerriero
level: 1
prerequisites: Nessuno
actions: 1
---

**Descrizione**
+1 ai tiri per colpire contro un bersaglio per un round, -1 alle difese contro avversari diversi dal bersaglio

--- FILE: Addestramento nell'elmo.md ---
---
name: Addestramento nell'elmo
type: Talento
group: Guerriero
level: 7
prerequisites: Competenza nell'elmo
---

**Descrizione**
Riduce di 1 la minaccia di critico, ottiene riduzione del danno 3/totale quando subisce un critico

--- FILE: Attacco poderoso migliorato.md ---
---
name: Attacco poderoso migliorato
type: Talento
group: Guerriero
level: 7
prerequisites: Attacco poderoso
---

**Descrizione**
Raddoppia i danni ottenuti dall'azione di attacco poderoso

--- FILE: Carica specializzata.md ---
---
name: Carica specializzata
type: Talento
group: Guerriero
level: 7
prerequisites: Nessuno
---

**Descrizione**
Può eseguire azioni dopo una carica

--- FILE: Distrarre migliorato.md ---
---
name: Distrarre migliorato
type: Talento
group: Guerriero
level: 7
prerequisites: Distrarre
---

**Descrizione**
Può effettuare un attacco in mischia come reazione immediata se un nemico adiacente effettua un attacco che non ha come bersaglio il personaggio

--- FILE: Maestria nell’arma (arma).md ---
---
name: Maestria nell’arma (arma)
type: Talento
group: Guerriero
level: 7
prerequisites: Specializzazione nell’arma (arma)
---

**Descrizione**
+1 al tiro per colpire e danni con l’arma

--- FILE: Maestria nell’armatura (armatura).md ---
---
name: Maestria nell’armatura (armatura)
type: Talento
group: Guerriero
level: 7
prerequisites: Specializzazione nell’armatura (armatura)
---

**Descrizione**
+1 CA e riduzione del danno 1/totale quando indossa l’armatura

--- FILE: Sbilanciare superiore.md ---
---
name: Sbilanciare superiore
type: Talento
group: Guerriero
level: 7
prerequisites: Sbilanciare migliorato
---

**Descrizione**
Può effettuare un attacco come reazione immediata dopo che aver reso prono il bersaglio con l'azione di sbilanciare

--- FILE: Addestramento nelle reazioni.md ---
---
name: Addestramento nelle reazioni
type: Talento
group: Guerriero
level: 8
prerequisites: Nessuno
---

**Descrizione**
Quando il personaggio deve effettuare attacchi con azione immediata può applicare all'attacco base eventuali talenti con incremento azione 0.

**Speciale**
Gli attacchi su azioni immediate sono attacchi base.

--- FILE: Critico migliorato (arma).md ---
---
name: Critico migliorato (arma)
type: Talento
group: Guerriero
level: 8
prerequisites: Addestramento nelle armi (arma)
---

**Descrizione**
Aumenta la minaccia di critico di 1

--- FILE: Deviare frecce migliorato.md ---
---
name: Deviare frecce migliorato
type: Talento
group: Guerriero
level: 8
prerequisites: Deviare frecce
---

**Descrizione**
L'azione di deviare frecce diventa gratuita, è quindi possibile eseguirla quante volte si vuole ma non più di una volta per ogni quarantesimo

--- FILE: Incalzare superiore.md ---
---
name: Incalzare superiore
type: Talento
group: Guerriero
level: 9
prerequisites: Incalzare migliorato
---

**Descrizione**
quando esegue l’azione di incalzare può, come azione gratuita, eseguirne una seconda.

--- FILE: Portata con minaccia.md ---
---
name: Portata con minaccia
type: Talento
group: Guerriero
level: 9
prerequisites: Nessuno
---

**Descrizione**
Minaccia l'area alla portata dell'arma

--- FILE: Arte nell’arma (arma).md ---
---
name: Arte nell’arma (arma)
type: Talento
group: Guerriero
level: 10
prerequisites: Maestria nell’arma (arma)
---

**Descrizione**
+1 al tiro per colpire e danni con l’arma

--- FILE: Arte nell’armatura (armatura).md ---
---
name: Arte nell’armatura (armatura)
type: Talento
group: Guerriero
level: 10
prerequisites: Maestria nell’armatura (armatura)
---

**Descrizione**
+1 CA e riduzione del danno 1/totale quando indossa l’armatura

--- FILE: Piè veloce.md ---
---
name: Piè veloce
type: Talento
group: Vagabondo
level: 2
prerequisites: Correre
---

**Descrizione**
Può effettuare una curva di 45° mentre corre o carica

--- FILE: Rapidità.md ---
---
name: Rapidità
type: Talento
group: Vagabondo
level: 2
prerequisites: Nessuno
---

**Descrizione**
Può muoversi di un quadretto con un’azione minore

--- FILE: Schivare prodigioso.md ---
---
name: Schivare prodigioso
type: Talento
group: Vagabondo
level: 2
prerequisites: Nessuno
---

**Descrizione**
Immune alla condizione di colto alla sprovvista

--- FILE: Sete di sangue.md ---
---
name: Sete di sangue
type: Talento
group: Vagabondo
level: 2
prerequisites: Nessuno
---

**Descrizione**
+1 ai danni contro avversari sanguinanti

--- FILE: Anticipare.md ---
---
name: Anticipare
type: Talento
group: Vagabondo
level: 8
prerequisites: Nessuno
---

**Descrizione**
Utilizzando un'azione minore può anticipare permanentemente la propria iniziativa di 4 quarantesimi

--- FILE: Danno incrementato migliorato.md ---
---
name: Danno incrementato migliorato
type: Talento
group: Vagabondo
level: 8
prerequisites: Danno incrementato
---

**Descrizione**
Danno incrementato causa 2d4 danni invece di 1d4

--- FILE: Furtivo immobilizzante.md ---
---
name: Furtivo immobilizzante
type: Talento
group: Vagabondo
level: 8
prerequisites: Attacco furtivo
---

**Descrizione**
Può ridurre di 3d6 il danno del furtivo per rendere il bersaglio immobilizzato continuato (T)

--- FILE: Ispirazione (Bardo).md ---
---
name: Ispirazione
type: Talento
group: Bardo
level: 1
prerequisites: Nessuno
actions: 1
---

**Descrizione**
Azione minore: fornisce a un alleato entro 10 quadretti un dado aggiuntivo (d6) ai tiri per colpire, danni, difese, prove di abilità e salvezza per un round. Il dado aggiuntivo può essere lanciato dopo aver visto il risultato del d20. Il bardo può riassegnare il dado con una nuova azione minore a prescindere che questo sia stato utilizzato o meno.

--- FILE: Ispirazione rinvigorente.md ---
---
name: Ispirazione rinvigorente
type: Talento
group: Bardo
level: 2
prerequisites: Nessuno
---

**Descrizione**
Azione movimento: un alleato entro 10 ottiene 1d4 punti ferita temporanei

--- FILE: Musica difensiva.md ---
---
name: Musica difensiva
type: Talento
group: Bardo
level: 2
prerequisites: Nessuno
---

**Descrizione**
Quando esegue un Canto (incantesimi o talenti con Canto nel nome) ottiene +2 alle difese per un round

**Speciale**
[Da eliminare]

--- FILE: Forma animale grande.md ---
---
name: Forma animale grande
type: Talento
group: Druido
level: 4
prerequisites: Nessuno
---

**Descrizione**
Si trasforma in un animale di taglia grande

--- FILE: Gestire gli elementi.md ---
---
name: Gestire gli elementi
type: Talento
group: Druido
level: 4
prerequisites: Nessuno
---

**Descrizione**
+1 al tiro per colpire ed ai danni quando utilizza poteri con descrittore elementale

--- FILE: Potere in armatura migliorato.md ---
---
name: Potere in armatura migliorato
type: Talento
group: Magewar
level: 4
prerequisites: Potere in armatura
---

**Descrizione**
Riduce di altri 5 punti la penalità di armatura durante il lancio di poteri

--- FILE: Reazione arcana.md ---
---
name: Reazione arcana
type: Talento
group: Magewar
level: 4
prerequisites: Nessuno
---

**Descrizione**
Può utilizzare due reazioni immediate durante il round se entrambe sono incantesimi

--- FILE: Recupero migliorato.md ---
---
name: Recupero migliorato
type: Talento
group: Magewar
level: 4
prerequisites: Nessuno
---

**Descrizione**
Recupera fino a 3 poteri con recupero minore con una sola azione minore

--- FILE: Difesa arcana migliorata.md ---
---
name: Difesa arcana migliorata
type: Talento
group: Magewar
level: 5
prerequisites: Difesa arcana
---

**Descrizione**
Ottiene resistenza 2/totale, i danni assorbiti in questo modo consumano altrettanti punti di soglia magica

--- FILE: Mano fremente.md ---
---
name: Mano fremente
type: Talento
group: Monaco
level: 6
prerequisites: Nessuno
actions: 1
---

**Descrizione**
Può effettuare l’attacco in mischia contro DT invece che contro CA

--- FILE: Imposizione migliorata.md ---
---
name: Imposizione migliorata
type: Talento
group: Paladino
level: 6
prerequisites: Imposizione rapida
---

**Descrizione**
L'azione di imposizione delle mani è un'azione minore e il massimale è 18.

--- FILE: Simbolo sacro di difesa.md ---
---
name: Simbolo sacro di difesa
type: Talento
group: Paladino
level: 6
prerequisites: Simbolo sacro protettivo
---

**Descrizione**
Gli alleati entro 10 quadretti che vedono il simbolo sacro ottengono un'ulteriore resistenza 1/totale

--- FILE: Estasi divina.md ---
---
name: Estasi divina
type: Talento
group: Paladino
level: 7
prerequisites: Gloria divina
---

**Descrizione**
Il paladino è considerato sempre infervorato, ottiene 10 punti di soglia divina

--- FILE: Nemico prescelto.md ---
---
name: Nemico prescelto
type: Talento
group: Ranger
level: 1
prerequisites: Nessuno
---

**Descrizione**
Il personaggio può dedicare un turno dopo aver combattuto contro un nemico per guadagnare un bonus +1 al tiro per colpire, danni e difese nei confronti di tutti i nemici della stessa razza per un giorno.

--- FILE: Predatore.md ---
---
name: Predatore
type: Talento
group: Ranger
level: 1
prerequisites: Nessuno
---

**Descrizione**
+10 alle abilità legate al seguire tracce, procacciare cibo e sopravvivenza. +2 tiro per colpire e danni contro animali e vegetali.

--- FILE: Sinergia con il compagno (animale).md ---
---
name: Sinergia con il compagno (animale)
type: Talento
group: Ranger
level: 1
prerequisites: Seguace animale
---

**Descrizione**
Il seguace animale guadagna un livello. Il personaggio ed il suo seguace animale ottengono +1 al tiro per colpire se si trovano entro 3 quadretti
"@

$BeneficiBlocco = @"
--- FILE: Abile.md ---
---
name: Abile
type: Beneficio
group: Generali
---

**Descrizione**
Il personaggio ottiene un bonus +1 a tutte le caratteristiche

--- FILE: Addestramento in un'arma.md ---
---
name: Addestramento in un'arma
type: Beneficio
group: Generali
---

**Descrizione**
Acquisisce l'addestramento in un’arma semplice o da guerra

--- FILE: Addestramento in un'armatura.md ---
---
name: Addestramento in un'armatura
type: Beneficio
group: Generali
---

**Descrizione**
Acquisisce l’addestramento in un’armatura leggera o pesante

--- FILE: Addestramento in uno strumento.md ---
---
name: Addestramento in uno strumento
type: Beneficio
group: Generali
---

**Descrizione**
Acquisisce l’addestramento in uno strumento da mago

--- FILE: Affinità divina.md ---
---
name: Affinità divina
type: Beneficio
group: Generali
---

**Descrizione**
il personaggio aggiunge 2 punti al punteggio totale di soglia divina

--- FILE: Affinità magica.md ---
---
name: Affinità magica
type: Beneficio
group: Generali
---

**Descrizione**
il personaggio aggiunge 2 punti al punteggio totale di soglia magica

--- FILE: Aggrapparsi alla cavalcatura.md ---
---
name: Aggrapparsi alla cavalcatura
type: Beneficio
group: Generali
---

**Descrizione**
Può utilizzare un’interruzione immediata per negare eventuali movimenti forzati quando si trova sulla cavalcatura (non può negare movimenti forzati subiti dalla cavalcatura)

--- FILE: Arciere lesto.md ---
---
name: Arciere lesto
type: Beneficio
group: Generali
---

**Descrizione**
+2 al tiro per colpire a distanza contro bersagli colti alla sprovvista

--- FILE: Armaiolo.md ---
---
name: Armaiolo
type: Beneficio
group: Generali
---

**Descrizione**
+5 alla prova di Artigianato per la costruzione di armi e armature

--- FILE: Armi non convenzionali.md ---
---
name: Armi non convenzionali
type: Beneficio
group: Generali
---

**Descrizione**
Può utilizzare armi atipiche come sedie, bottiglie e sassi senza penalità al tiro per colpire (vedi armi e armature); riduce il malus di competenza nelle armi non addestrate a -2

--- FILE: Attacco secondario (livello).md ---
---
name: Attacco secondario (livello)
type: Beneficio
group: Generali
---

**Descrizione**
Il personaggio ottiene un bonus ad un tipo di attacco (fisico, magico, divino) che non ha selezionato come gratuito al passaggio di livello.

--- FILE: Atterraggio plastico.md ---
---
name: Atterraggio plastico
type: Beneficio
group: Generali
---

**Descrizione**
+5 alle prove di acrobazia in caso di caduta

--- FILE: Cacciatore.md ---
---
name: Cacciatore
type: Beneficio
group: Generali
---

**Descrizione**
+5 quando utilizza l'azione di procacciare cibo e di seguire piste

--- FILE: Carisma del cerbiatto.md ---
---
name: Carisma del cerbiatto
type: Beneficio
group: Generali
---

**Descrizione**
il personaggio ottiene un bonus +3 alle abilità di Carisma

--- FILE: Colpo debilitante.md ---
---
name: Colpo debilitante
type: Beneficio
group: Generali
---

**Descrizione**
il personaggio può causare danni debilitanti invece di danni normali senza la penalità di -2 al tiro per colpire

--- FILE: Colpo di reni.md ---
---
name: Colpo di reni
type: Beneficio
group: Generali
---

**Descrizione**
Può rialzarsi da prono con un'azione minore

--- FILE: Colpo d'occhio.md ---
---
name: Colpo d'occhio
type: Beneficio
group: Generali
---

**Descrizione**
+5 alle prove di Cercare per trovare porte segrete o passaggi nascosti

--- FILE: Combattere in sella.md ---
---
name: Combattere in sella
type: Beneficio
group: Generali
---

**Descrizione**
+5 alle prove di Destrezza per cavalcare relative al combattimento in sella

--- FILE: Costituzione del cinghiale.md ---
---
name: Costituzione del cinghiale
type: Beneficio
group: Generali
---

**Descrizione**
il personaggio ottiene un bonus +3 alle abilità di Costituzione

--- FILE: Destrezza della lince.md ---
---
name: Destrezza della lince
type: Beneficio
group: Generali
---

**Descrizione**
il personaggio ottiene un un bonus +3 alle abilità di Destrezza

--- FILE: Disturbare migliorato.md ---
---
name: Disturbare migliorato
type: Beneficio
group: Generali
---

**Descrizione**
+5 alla CD quando utilizza l'azione di disturbare

--- FILE: Esperto di incantesimi.md ---
---
name: Esperto di incantesimi
type: Beneficio
group: Generali
---

**Descrizione**
+5 quando deve identificare un potere arcano in fase di lancio, presente in un'area o infuso in uno stelo

--- FILE: Esperto di preghiere.md ---
---
name: Esperto di preghiere
type: Beneficio
group: Generali
---

**Descrizione**
+5 quando deve identificare un potere divino in fase di lancio, presente in un'area o infuso in una runa

--- FILE: Estrazione rapida.md ---
---
name: Estrazione rapida
type: Beneficio
group: Generali
---

**Descrizione**
Può estrarre una singola arma durante l'azione standard di attacco con essa. Questo talento permette inoltre l'estrazione di due armi (o arma e scudo) con una singola azione minore

--- FILE: Evitare trappole.md ---
---
name: Evitare trappole
type: Beneficio
group: Generali
---

**Descrizione**
+3 alle difese contro attacchi provenienti da trappole o congegni

--- FILE: Forza del toro.md ---
---
name: Forza del toro
type: Beneficio
group: Generali
---

**Descrizione**
il personaggio ottiene un un bonus +3 alle abilità di Forza

--- FILE: Intelligenza della volpe.md ---
---
name: Intelligenza della volpe
type: Beneficio
group: Generali
---

**Descrizione**
il personaggio ottiene un un bonus +3 alle abilità di Intelligenza

--- FILE: Linguaggio.md ---
---
name: Linguaggio
type: Beneficio
group: Generali
---

**Descrizione**
il personaggio acquisisce la conoscenza di una nuova lingua

--- FILE: Mantenere la concentrazione.md ---
---
name: Mantenere la concentrazione
type: Beneficio
group: Generali
---

**Descrizione**
+5 quando deve mantenere un potere in fase di lancio o durante il mantenimento

--- FILE: Razzista difensivo.md ---
---
name: Razzista difensivo
type: Beneficio
group: Generali
---

**Descrizione**
+2 alle difese contro una categoria a sceltra tra le seguenti:
melme, non morti, draghi, animali, costrutti, esterni.

--- FILE: Razzista offensivo.md ---
---
name: Razzista offensivo
type: Beneficio
group: Generali
---

**Descrizione**
+1 al tiro per colpire e ai danni contro una categoria a scelta tra le seguenti:
melme, non morti, draghi, animali, costrutti, esterni.

--- FILE: Resistenza al freddo.md ---
---
name: Resistenza al freddo
type: Beneficio
group: Generali
---

**Descrizione**
Ottiene resistenza 2/freddo

--- FILE: Resistenza al fulmine.md ---
---
name: Resistenza al fulmine
type: Beneficio
group: Generali
---

**Descrizione**
Ottiene resistenza 2/fulmine

--- FILE: Resistenza al fuoco.md ---
---
name: Resistenza al fuoco
type: Beneficio
group: Generali
---

**Descrizione**
Ottiene resistenza 2/fuoco

--- FILE: Resistenza al necrotico.md ---
---
name: Resistenza al necrotico
type: Beneficio
group: Generali
---

**Descrizione**
Ottiene resistenza 2/necrotico

--- FILE: Resistenza al sacro.md ---
---
name: Resistenza al sacro
type: Beneficio
group: Generali
---

**Descrizione**
Ottiene resistenza 2/sacro

--- FILE: Resistenza all'acido.md ---
---
name: Resistenza all'acido
type: Beneficio
group: Generali
---

**Descrizione**
Ottiene resistenza 2/acido

--- FILE: Riflessi agili.md ---
---
name: Riflessi agili
type: Beneficio
group: Generali
---

**Descrizione**
il personaggio ottiene un bonus +1 ai tiri salvezza su Riflessi

--- FILE: Rigenerazione innata.md ---
---
name: Rigenerazione innata
type: Beneficio
group: Generali
---

**Descrizione**
il personaggio recupera 4 punti ferita aggiuntivi durante la fase di riposo

--- FILE: Saggezza del gufo.md ---
---
name: Saggezza del gufo
type: Beneficio
group: Generali
---

**Descrizione**
il personaggio ottiene un bonus +3 alle abilità di Saggezza

--- FILE: Seguace animale (animale).md ---
---
name: Seguace animale (animale)
type: Beneficio
group: Generali
---

**Descrizione**
il personaggio crea con un animale domestico comune un legame affettivo. L'animale si muoverà autonomamente nelle vicinanze del personaggio, mantenendo nei confronti di altri un comportamento auto-conservativo. Tramite gesti e suoni, il personaggio può comunicare all'animale dei comandi che comportino l'uso di tutte le azioni che può compiere l'animale in quel round. Se animale e personaggio sono adiacenti, quest'ultimo godrà di un +2 a tutte le abilità che hanno in comune.Speciale: questo talento non prevede tempi di addestramento dell'animale solo se selezionato al momento della creazione del personaggio. Se selezionato in momenti successivi occorrerà un tempo variabile di addestramento. Tale periodo sarà quantificato a discrezione del DM sulla base di specie ed età dell'animale da addestrare. In caso di morte dell'animale il personaggio potrà ricercare un nuovo Seguace Animale, ma dovrà essere della stessa specie selezionata con il talento e dovrà affrontare i tempi di addestramento.A discrezione del DM possono essere selezionati animali comuni non domestici, se diffusi nell'ambiente del personaggio.È possibile selezionare questo beneficio più volte variando l'animale selezionato. Il livello del seguace non può essere superiore al livello del personaggio.

--- FILE: Sonno armato.md ---
---
name: Sonno armato
type: Beneficio
group: Generali
---

**Descrizione**
il personaggio può effettuare il riposo anche indossando l'armatura pesante senza considerare le conseguenze del riposo in armatura

--- FILE: Strumento arma.md ---
---
name: Strumento arma
type: Beneficio
group: Generali
---

**Descrizione**
Lo strumento musicale, lo strumento per canalizzare o il simbolo sacro possono acquisire le caratteristiche di un'arma a scelta del personaggio e in cui sia addestrato.

--- FILE: Superare il trauma.md ---
---
name: Superare il trauma
type: Beneficio
group: Generali
---

**Descrizione**
il personaggio che ritorna ad un punteggio di punti ferita positivo dopo essere stato in condizione di morente o stabile non sarà colto alla sprovvista

--- FILE: Tempra forte.md ---
---
name: Tempra forte
type: Beneficio
group: Generali
---

**Descrizione**
il personaggio ottiene un bonus +1 ai tiri salvezza su Tempra

--- FILE: Vigore.md ---
---
name: Vigore
type: Beneficio
group: Generali
---

**Descrizione**
Il personaggio ottiene un punto ferita

--- FILE: Volontà ferrea.md ---
---
name: Volontà ferrea
type: Beneficio
group: Generali
---

**Descrizione**
il personaggio ottiene un bonus +1 ai tiri salvezza su Volontà

--- FILE: Abilità di mano.md ---
---
name: Abilità di mano
type: Beneficio
group: Caratteristiche
---

**Descrizione**
il personaggio è in grado di scassinare, borseggiare ed effettuare trucchetti con le mani

**Scassinare**
- Serratura semplice: CD15
- Serratura complessa: CD25
- Serratura arcana: CD30

**Borseggiare**
- Borseggio standard: CD 20
- Non essere visti durante il borseggio: CD percezione del bersaglio

**Trucchetti**
- Trucchetto standard (es. gioco della moneta): CD10

--- FILE: Acrobazia.md ---
---
name: Acrobazia
type: Beneficio
group: Caratteristiche
---

**Descrizione**
il personaggio è in grado di ridurre il danno da caduta o a muoversi agilmente negli spazi pericolosi

**Ridurre la caduta**
- Riduzione dei danni: CD 10 + 5 per ogni d6 (ed CD 15, riduce 1d6)

**Manovra acrobatica**
- Semplice (ruota, salto mortale): CD 15

--- FILE: Arcano.md ---
---
name: Arcano
type: Beneficio
group: Caratteristiche
---

**Descrizione**
il personaggio è in grado di riconoscere gli incantesimi e conosce quanto più possibile relativamente alla magia

--- FILE: Artigianato (professione).md ---
---
name: Artigianato (professione)
type: Beneficio
group: Caratteristiche
---

**Descrizione**
il personaggio è abile in una professione artigiana

--- FILE: Cavalcare.md ---
---
name: Cavalcare
type: Beneficio
group: Caratteristiche
---

**Descrizione**
il personaggio è in grado di cavalcare con agilità

--- FILE: Cercare.md ---
---
name: Cercare
type: Beneficio
group: Caratteristiche
---

**Descrizione**
il personaggio è abile nel riconoscere nascondigli, porte segrete oppure nel ritrovare oggetti

--- FILE: Diplomazia.md ---
---
name: Diplomazia
type: Beneficio
group: Caratteristiche
---

**Descrizione**
il personaggio è in grado di usare l'arte della diplomazia

--- FILE: Furtività.md ---
---
name: Furtività
type: Beneficio
group: Caratteristiche
---

**Descrizione**
il personaggio è abile nel nascondersi e nel movimento silenzioso

--- FILE: Guarire.md ---
---
name: Guarire
type: Beneficio
group: Caratteristiche
---

**Descrizione**
il personaggio è in grado di portare primo soccorso e curare ferite superficiali

--- FILE: Intrattenere.md ---
---
name: Intrattenere
type: Beneficio
group: Caratteristiche
---

**Descrizione**
il personaggio è in grado di attirare e mantenere l'attenzione di chi lo osserva tramite il linguaggio o il corpo

--- FILE: Intuizione.md ---
---
name: Intuizione
type: Beneficio
group: Caratteristiche
---

**Descrizione**
il personaggio riconosce raggiri e illusioni

--- FILE: Mantenere concentrazione.md ---
---
name: Mantenere concentrazione
type: Beneficio
group: Caratteristiche
---

**Descrizione**
il personaggio è in gradi di mantenere la concentrazione durante il lancio o il mantenimento di poteri nonostante disturbi esterni

--- FILE: Natura.md ---
---
name: Natura
type: Beneficio
group: Caratteristiche
---

**Descrizione**
il personaggio conosce piante, animali e ambienti naturali

--- FILE: Nuotare.md ---
---
name: Nuotare
type: Beneficio
group: Caratteristiche
---

**Descrizione**
il personaggio è un abile nuotatore anche in condizioni estreme

--- FILE: Percezione.md ---
---
name: Percezione
type: Beneficio
group: Caratteristiche
---

**Descrizione**
il personaggio è addestrato nel sentire o vedere

--- FILE: Raggirare.md ---
---
name: Raggirare
type: Beneficio
group: Caratteristiche
---

**Descrizione**
il personaggio è in grado di raggirare il suo interlocutore

--- FILE: Religione.md ---
---
name: Religione
type: Beneficio
group: Caratteristiche
---

**Descrizione**
il personaggio conosce gli dei e le varie informazioni su dogmi e riti

--- FILE: Resistenza.md ---
---
name: Resistenza
type: Beneficio
group: Caratteristiche
---

**Descrizione**
il personaggio sopporta la fatica e l'attività fisica prolungata oltre ad avere una tempra molto forte

--- FILE: Scalare.md ---
---
name: Scalare
type: Beneficio
group: Caratteristiche
---

**Descrizione**
il personaggio è in grado di scalare pareti di ogni tipo

--- FILE: Sfondare.md ---
---
name: Sfondare
type: Beneficio
group: Caratteristiche
---

**Descrizione**
il personaggio è in grado di sfondare porte, ma anche di spezzare catene, sollevare carichi pesanti e altre prove di forza

--- FILE: Sopravvivenza.md ---
---
name: Sopravvivenza
type: Beneficio
group: Caratteristiche
---

**Descrizione**
il personaggio è in grado sopravvivere in condizioni estreme (caldo, freddo, assenza di cibo)

--- FILE: Storia.md ---
---
name: Storia
type: Beneficio
group: Caratteristiche
---

**Descrizione**
il personaggio conosce leggende, araldica, storia

--- FILE: Tattica.md ---
---
name: Tattica
type: Beneficio
group: Caratteristiche
---

**Descrizione**
il personaggio è conosce le strategie di combattimento e le manovre di battaglia
"@

# mio script
#$TalentiBlocco = $BeneficiBlocco

# Definisce il delimitatore usato per separare i file
$Delimiter = "--- FILE: "
$OutputDirectory = "Talenti_Markdown"
#$OutputDirectory = "Benefici_Markdown"

# Crea la directory di output se non esiste
if (-not (Test-Path $OutputDirectory -PathType Container)) {
    New-Item -Path $OutputDirectory -ItemType Directory | Out-Null
} else {
    # Opzionale: pulisce la cartella prima di creare i nuovi file
    Get-ChildItem -Path "$OutputDirectory\*.md" | Remove-Item -Force
}

# Divide il blocco di testo in singoli blocchi usando il delimitatore.
$TalentBlocks = $TalentiBlocco -split "$($Delimiter)" | Where-Object { $_ -ne "" }

# Processa ogni blocco di testo
$TalentBlocks | ForEach-Object {
    $Block = $_
    
    # Divide il blocco in singole righe
    $Lines = $Block -split "`r?`n"
    
    # La prima riga contiene il nome del file e il marcatore finale: [Nome].md ---
    $FirstLine = $Lines[0].Trim()
    
    # Continua solo se troviamo un nome di file valido
    if ($FirstLine -like "*.md ---") {
        # 1. Estrae il nome del file (es: Addestramento in un’arma esotica.md)
        $FileName = $FirstLine.Replace(".md ---", ".md")
        
        # 2. Rimuove la prima riga e un eventuale riga vuota subito dopo (gestione dei newline extra)
        # Select-Object -Skip 1 ignora la riga del nome del file.
        $ContentLines = $Lines | Select-Object -Skip 1

        # 3. Ricostruisce il contenuto, saltando le linee vuote iniziali ma mantenendo tutto il testo Markdown
        # Usa TrimStart per eliminare eventuali righe vuote o spazi bianchi all'inizio del contenuto finale.
        $Content = ($ContentLines -join "`n").TrimStart("`n", "`r", " ")

        # Scrive il contenuto nel file di destinazione, forzando la codifica UTF8
        $OutputPath = Join-Path $OutputDirectory $FileName
        
        # Controllo di sicurezza: scrive il contenuto solo se non è vuoto
        if ($Content -ne "") {
            $Content | Out-File -FilePath $OutputPath -Encoding UTF8
            Write-Host "Creato: $OutputPath"
        } else {
            Write-Host "ATTENZIONE: Il file $FileName è vuoto. Salto la creazione." -ForegroundColor Yellow
        }
    }
}

Write-Host "`nOperazione completata! Tutti i file Markdown sono stati creati nella cartella: $OutputDirectory"