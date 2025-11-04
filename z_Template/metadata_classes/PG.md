---
limit: 20
mapWithTag: false
icon: user-round
tagNames:
filesPaths:
  - Campagna - Sangue/PG
bookmarksGroups:
excludes:
extends: general
savedViews: []
favoriteView:
fieldsOrder:
  - bBmCfv
  - dJHnn6
  - X36euY
  - gGbmst
  - GWm4kT
  - qNvg20
  - FPlw0U
  - eIWxUc
  - aHDT4P
  - b7Pb07
version: "2.177"
fields:
  - name: razza
    type: Select
    options:
      sourceType: ValuesListNotePath
      valuesList: {}
      valuesListNotePath: z_Template/metadata_classes/metadata_list/list_of_razze.md
    path: ""
    id: b7Pb07
  - name: alias
    type: Input
    options: {}
    path: ""
    id: eIWxUc
  - name: condizione
    type: Select
    options:
      sourceType: ValuesList
      valuesList:
        "1": Vivo
        "2": Morto
    path: ""
    id: FPlw0U
  - name: relazione
    type: Input
    options: {}
    path: ""
    id: GWm4kT
  - name: sesso
    type: Select
    options:
      sourceType: ValuesList
      valuesList:
        "1": Maschio
        "2": Femmina
    path: ""
    id: gGbmst
  - name: classe_sociale
    type: Input
    options: {}
    path: ""
    id: X36euY
  - name: picture
    type: Media
    options:
      embed: false
      folders:
        - Campagna - Sangue/Media
      display: card
      thumbnailSize: "100"
    path: ""
    id: dJHnn6
  - name: organizzazione
    type: MultiFile
    options:
      dvQueryString: dv.pages('"Campagna - Sangue/Organizzazioni"')
    path: ""
    id: qNvg20
  - name: class
    type: Multi
    options:
      sourceType: ValuesListNotePath
      valuesList: {}
      valuesListNotePath: z_Template/metadata_classes/metadata_list/list_of_classi.md
    path: ""
    id: aHDT4P
  - name: giocatore
    type: Input
    options: {}
    path: ""
    id: bBmCfv
---
