library(shiny)
function(input, output, session) {
  output$tbl <- DT::renderDT({
    # Sys.sleep(10)
    iris
  })
}
