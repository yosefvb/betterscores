dataset <- bagrut_avg_comb_complete_rf

function(input, output, clientData, session) {
  
  observe({
    # We'll use these multiple times, so use short var names for
    # convenience.
    c_label <- input$control_label
    c_num <- input$control_num
    
    school <- dataset[dataset$semel == c_label,]

    
    
    # Text =====================================================
    # Change both the label and the text
    # updateTextInput(session, "inText",
    #                 label = paste("New", c_label),
    #                 value = paste("New text", c_num)
    # )
    
    # Number ===================================================
    
    #teachers
    teachers <- as.numeric(school)[27]
    #budget
    budget <- round(as.numeric(school)[25],2)
    #teaching time
    time <- as.numeric(school)[26]
    #test grade
    grade <- round(as.numeric(school)[2],2)
    
    output$values <- renderTable(
      t(school), rownames = TRUE, colnames = FALSE
    )
    
    # Change the value
    updateNumericInput(session, "inNumber", value = budget) 
    
    # Change the label, value, min, and max
    updateNumericInput(session, "inNumber2",
                       label = paste("Money Spent Per Student:"), #, c_label
                       value = teachers, min = 1, max = 1000000, step = 1000)

    updateNumericInput(session, "inNumber3",
                       label = paste("Average Teaching Time Per Day:"), #, c_label
                       value = time, min = 1, max = 40, step = 1)
    
    # Slider input =============================================
    # Only label and value can be set for slider
    updateSliderInput(session, "inSlider",
                      label = paste("Number of Teachers:"),
                      value = teachers)
    
    # Slider range input =======================================
    # For sliders that pick out a range, pass in a vector of 2
    # values.
    updateSliderInput(session, "inSlider2",
                      value = time)
    
    # An NA means to not change that value (the low or high one)
    updateSliderInput(session, "inSlider3",
                      value = c(NA, c_num+2))
    
    
    output$oldGrade  <- renderText({
      paste("The current test score average is", grade)
    })
    
    output$newGrade  <- renderText({
      paste("The new test score average is predicted to be", grade)
    })
    
    
    # Date input ===============================================
    # Only label and value can be set for date input
    # updateDateInput(session, "inDate",
    #                 label = paste("Date", c_label),
    #                 value = paste("2013-04-", c_num, sep=""))
    # 
    # 
    # # Date range input =========================================
    # # Only label and value can be set for date range input
    # updateDateRangeInput(session, "inDateRange",
    #                      label = paste("Date range", c_label),
    #                      start = paste("2013-01-", c_num, sep=""),
    #                      end = paste("2013-12-", c_num, sep=""),
    #                      min = paste("2001-01-", c_num, sep=""),
    #                      max = paste("2030-12-", c_num, sep="")
    # )
    # 
    # # # Checkbox ===============================================
    # updateCheckboxInput(session, "inCheckbox",value = c_num %% 2)
    
    
    # # Checkbox group ===========================================
    # # Create a list of new options, where the name of the items
    # # is something like 'option label x A', and the values are
    # # 'option-x-A'.
    # cb_options <- list()
    # cb_options[[paste("option label", c_num, "A")]] <-
    #   paste0("option-", c_num, "-A")
    # cb_options[[paste("option label", c_num, "B")]] <-
    #   paste0("option-", c_num, "-B")
    # 
    # # Set the label, choices, and selected item
    # updateCheckboxGroupInput(session, "inCheckboxGroup",
    #                          label = paste("checkboxgroup", c_label),
    #                          choices = cb_options,
    #                          selected = paste0("option-", c_num, "-A")
    # )
    # 
    # # Radio group ==============================================
    # # Create a list of new options, where the name of the items
    # # is something like 'option label x A', and the values are
    # # 'option-x-A'.
    # r_options <- list()
    # r_options[[paste("option label", c_num, "A")]] <-
    #   paste0("option-", c_num, "-A")
    # r_options[[paste("option label", c_num, "B")]] <-
    #   paste0("option-", c_num, "-B")
    # 
    # # Set the label, choices, and selected item
    # updateRadioButtons(session, "inRadio",
    #                    label = paste("Radio", c_label),
    #                    choices = r_options,
    #                    selected = paste0("option-", c_num, "-A")
    # )
    # 
    
    # Select input =============================================
    # Create a list of new options, where the name of the items
    # is something like 'option label x A', and the values are
    # 'option-x-A'.
    s_options <- list()
    s_options[[paste("option label", c_num, "A")]] <-
      paste0("option-", c_num, "-A")
    s_options[[paste("option label", c_num, "B")]] <-
      paste0("option-", c_num, "-B")
    
    # Change values for input$inSelect
    updateSelectInput(session, "inSelect",
                      choices = s_options,
                      selected = paste0("option-", c_num, "-A")
    )
    
    
    # Can also set the label and select an item (or more than
    # one if it's a multi-select)
    updateSelectInput(session, "inSelect2",
                      label = paste("Select label", c_label),
                      choices = s_options,
                      selected = paste0("option-", c_num, "-B")
    )
    
    
    # Tabset input =============================================
    # Change the selected tab.
    # The tabsetPanel must have been created with an 'id' argument
    # if (c_num %% 2) {
    #   updateTabsetPanel(session, "inTabset", selected = "panel2")
    # } else {
    #   updateTabsetPanel(session, "inTabset", selected = "panel1")
    # }
  })
}