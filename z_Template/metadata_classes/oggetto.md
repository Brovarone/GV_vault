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
  - cD8p1e
  - fDvoBn
  - rqq1JQ
version: "2.27"
fields:
  - name: subtype
    type: Input
    options: {}
    path: ""
    id: cD8p1e
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
---
