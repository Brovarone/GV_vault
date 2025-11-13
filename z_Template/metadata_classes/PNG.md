---
limit: 20
mapWithTag: false
icon: users-round
tagNames:
filesPaths:
  - Campagna - Sangue/PNG
bookmarksGroups:
excludes:
extends: general
savedViews: []
favoriteView:
fieldsOrder:
  - dJHnn6
  - X36euY
  - UN3fIb
  - rgJ2L6
  - gGbmst
  - baathx
  - mAdGIJ
  - oQlCZI
  - qNvg20
  - FPlw0U
  - eIWxUc
  - b7Pb07
version: "2.168"
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
  - name: relazione_con_pg
    type: Select
    options:
      sourceType: ValuesList
      valuesList:
        "1": Amichevole
        "2": Neutrale
        "3": Ostile
    path: ""
    id: oQlCZI
  - name: relazione_con_party
    type: Select
    options:
      sourceType: ValuesList
      valuesList:
        "1": Amichevole
        "2": Neutrale
        "3": Ostile
    path: ""
    id: mAdGIJ
  - name: sesso
    type: Select
    options:
      sourceType: ValuesList
      valuesList:
        "1": Maschio
        "2": Femmina
    path: ""
    id: gGbmst
  - name: occupazione
    type: Input
    options: {}
    path: ""
    id: rgJ2L6
  - name: location
    type: MultiFile
    options:
      dvQueryString: dv.pages('"Campagna - Sangue/Location"')
      customRendering: page.file.name
    path: ""
    id: UN3fIb
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
  - name: relazione
    type: MultiFile
    options:
      dvQueryString: dv.pages('"Campagna - Sangue/PNG"')
    path: ""
    id: baathx
---
![[]]