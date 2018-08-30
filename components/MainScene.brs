sub Show(args as Object)
  print "---Main Scene---"
  ' function called when the view is ready to Show
  m.grid = CreateObject("roSGNode", "GridView")
  ' m.grid.ObserveField("rowItemSelected", "OnGridItemSelected")
  'Setup the UI of the view

  m.grid.SetFields({
    style: "standard"
    posterShape: "16x9"
  })
  'This is the root content that describes how to populate rest of the rows

    content = CreateObject("roSGNode", "ContentNode")
    print "CONTENT FROM MAIN", content
    content.AddFields({
        HandlerConfigGrid: {
           name: "readAPI"
           ' fields: "items"
        }
    })
    ' print "content in main"; content.HandlerConfigGrid
    m.grid.content = content
    ' print "content grid"; m.grid.content
    ' m.grid.ObserveField("rowItemSelected","OnGridItemSelected")

    'Triggers a job to show the view

    ' content = CreateObject("roSGNode", "ContentNode")
    ' row = CreateObjecßid.row

    m.top.ComponentController.CallFunc("show", {
        view: m.grid
    })
end sub
