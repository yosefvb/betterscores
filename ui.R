# fancy shiny app

dataset <- bagrut_avg_comb_complete_rf


fluidPage(
  titlePanel("Better Scores"),
  h4("This app uses user inputs to predict the expected effect on a school's bagrut score"),
  h4("."),
  fluidRow(
    column(4, offset =0, wellPanel(
      h4(""),
      selectInput("control_label",
                "Choose school ID to analyze:",
                dataset$semel)),
      # sliderInput("control_num",
      #             "This controls values:",
      #             min = 1, max = 20, value = 15)
    # )),
    # 
    # column(3, wellPanel(
      # textInput("inText",  "Text input:", value = "start text"),
    wellPanel(
      h4("Adjust these values to view impact on school's average score"),
      h5(":"),
      numericInput("inNumber", "Money Spent Per Student:",
                   min = 1, max = 1000000, value = 5, step = 1000),
      # numericInput("inNumber2", "Number of Teachers:",
                   # min = 1, max = 20, value = 5, step = 1),
      # numericInput("inNumber3", "Average Teaching Time:",
                   # min = 1, max = 20, value = 5, step = 1),
      sliderInput("inSlider", "Slider input:",
      min = 0, max = 338, value = 10),
      sliderInput("inSlider2", "Average Teaching Time:",
      min = 2, max = 40, value = 15)
      # sliderInput("inSlider3", "Slider input 3:",
                  # min = 1, max = 20, value = c(5, 15)),
      
      # dateInput("inDate", "Date input:"),
      
      # dateRangeInput("inDateRange", "Date range input:")
    )),
    column(3,
           wellPanel(
           #   checkboxInput("inCheckbox", "Checkbox input",
           #                 value = FALSE),
           #   
           #   checkboxGroupInput("inCheckboxGroup",
           #                      "Checkbox group input:",
           #                      c("label 1" = "option1",
           #                        "label 2" = "option2")),
           #   
           #   radioButtons("inRadio", "Radio buttons:",
           #                c("label 1" = "option1",
           #                  "label 2" = "option2")),
           #   
           #   selectInput("inSelect", "Select input:",
           #               c("label 1" = "option1",
           #                 "label 2" = "option2")),
           #   selectInput("inSelect2", "Select input 2:",
           #               multiple = TRUE,
           #               c("label 1" = "option1",
           #                 "label 2" = "option2"))
           # ),
           tabsetPanel(id = "inTabset",
                       tabPanel("School Statistics", tableOutput("values")
           
    )))),
    
    column(3,
           wellPanel(
           #   checkboxInput("inCheckbox", "Checkbox input",
           #                 value = FALSE),
           #   
           #   checkboxGroupInput("inCheckboxGroup",
           #                      "Checkbox group input:",
           #                      c("label 1" = "option1",
           #                        "label 2" = "option2")),
           #   
           #   radioButtons("inRadio", "Radio buttons:",
           #                c("label 1" = "option1",
           #                  "label 2" = "option2")),
           #   
           #   selectInput("inSelect", "Select input:",
           #               c("label 1" = "option1",
           #                 "label 2" = "option2")),
           #   selectInput("inSelect2", "Select input 2:",
           #               multiple = TRUE,
           #               c("label 1" = "option1",
           #                 "label 2" = "option2"))
           # ),
           
           tabsetPanel(id = "inTabset",
                       tabPanel("Test Score", h3(textOutput("oldGrade")),h3(textOutput("newGrade")))
                       
                       # tabPanel("panel2", h2("This is the second panel."))
           ))
    )
  )
)