---
limit: 20
mapWithTag: false
icon: amphora
tagNames:
filesPaths:
  - Campagna - Sangue/Oggetti
bookmarksGroups:
excludes:
extends:
savedViews: []
favoriteView:
fieldsOrder:
  - dFi2vH
  - PzzvX0
  - fDvoBn
  - rqq1JQ
version: "2.35"
fields:
  - name: collegamenti
    type: MultiFile
    options:
      dvQueryString: dv.pages('"Campagna - Sangue/PG" or "Campagna - Sangue/PNG"')
      customRendering: page.file.name
      customSorting: "a.folder < b.folder ? 1: -1"
    path: ""
    id: fDvoBn
  - name: location
    type: File
    options:
      dvQueryString: dv.pages('"Campagna - Sangue/Location"')
    path: ""
    id: rqq1JQ
  - name: alias
    type: Multi
    options:
      sourceType: ValuesList
      valuesList: {}
    path: ""
    id: dFi2vH
  - name: subtype
    type: Multi
    options:
      sourceType: ValuesList
      valuesList: {}
    path: ""
    id: PzzvX0
---
