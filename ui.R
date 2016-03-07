# ubbiR_delfi_tm shiny app ui
list(
  tags$head(tags$meta(name = "viewport", 
                      content = "width=device-width, initial-scale=1")),
  includeCSS(file.path("www", "ubbiR_delfi_tm.css")),
  useShinyjs(),
  uiOutput("Delfi_all_ui")
)