shiny::fluidPage(
  DT::DTOutput('tbl'),
  shiny::verbatimTextOutput('ip')
)
