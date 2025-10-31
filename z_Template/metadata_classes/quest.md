---
fields:
  - name: location
    type: MultiFile
    options:
      dvQueryString: dv.pages('"Campagna - Sangue/Location"')
    path: ""
    id: iB3wnA
  - name: datore
    type: File
    options:
      dvQueryString: dv.pages('"Campagna - Sangue/PNG"')
    path: ""
    id: BtC3dR
  - name: scadenza
    type: Input
    options: {}
    path: ""
    id: YLDJ9r
  - name: ricompensa
    type: Input
    options: {}
    path: ""
    id: bZuAHq
  - name: alias
    type: Input
    options: {}
    path: ""
    id: FlhF7c
  - name: stato
    type: Select
    options:
      sourceType: ValuesList
      valuesList:
        "1": Proposta
        "2": In corso
        "3": Sospesa
        "4": Completata
        "5": Annullata
    path: ""
    id: vvYL42
  - name: priorita
    type: Select
    options:
      sourceType: ValuesList
      valuesList:
        "1": Alta
        "2": Media
        "3": Bassa
    path: ""
    id: SID9zb
version: "2.42"
limit: 20
mapWithTag: false
icon: scroll-text
tagNames:
filesPaths:
  - Campagna - Sangue/Quest
bookmarksGroups:
excludes:
  - class
extends: general
savedViews: []
favoriteView:
fieldsOrder:
  - FlhF7c
  - BtC3dR
  - iB3wnA
  - bZuAHq
  - YLDJ9r
  - SID9zb
  - vvYL42
---
