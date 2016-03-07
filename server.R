shinyServer(function(input, output, session) {

# loading UI
for (file in list.files("ui")) {
  source(file.path("ui", file), local = TRUE)
}

# loading reactives
for (file in list.files("reactives")) {
  source(file.path("reactives", file), local = TRUE)
}


})