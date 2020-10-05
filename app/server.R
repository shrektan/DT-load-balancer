function(input, output, session) {
  output$tbl <- DT::renderDT({
    iris
  }, server = TRUE)
  output$ip <- shiny::renderPrint({
    x <- system2("cat", c("/etc/hosts"), stdout = TRUE)
    cat(x, sep = '\n')
  })
}
