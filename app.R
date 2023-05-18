# Load Packages ----
library(shiny)
library(shinydashboard)
library(shinyBS)
library(shinyWidgets)
library(boastUtils)
library(ggplot2) # data visualization

# Load additional dependencies and setup functions
# source("global.R")

# Define UI for App ----
ui <- list(
  ## Create the app page ----
  dashboardPage(
    skin = "blue",
    ### Create the app header ----
    dashboardHeader(
      title = "Introducing Taryn McHugh", # You may use a shortened form of the title here
      titleWidth = 250,
      tags$li(class = "dropdown", actionLink("info", icon("info"))),
      tags$li(
        class = "dropdown",
        boastUtils::surveyLink(name = "Introducing_Taryn_McHugh")
      ),
      tags$li(
        class = "dropdown",
        tags$a(href = 'https://shinyapps.science.psu.edu/',
               icon("house")
        )
      )
    ),
    ### Create the sidebar/left navigation menu ----
    dashboardSidebar(
      width = 250,
      sidebarMenu(
        id = "pages",
        menuItem("Overview", tabName = "overview", icon = icon("gauge-high")),
        menuItem("Prerequisites", tabName = "prerequisites", icon = icon("book")),
        menuItem("Timeline", tabName = "timeline", icon = icon("wpexplorer")),
        menuItem("References", tabName = "references", icon = icon("leanpub"))
      ),
      tags$div(
        class = "sidebar-logo",
        boastUtils::sidebarFooter()
      )
    ),
    ### Create the content ----
    dashboardBody(
      tabItems(
        #### Set up the Overview Page ----
        tabItem(
          tabName = "overview",
          withMathJax(),
          h1("Introduction to Taryn McHugh"), # This should be the full name.
          p("Use this application to get to  know more about Taryn McHugh!"),
          h2("Instructions"),
          tags$ol(
            tags$li("Read facts about me using the Prerequisites Tab"),
            tags$li("See specific images that descirbe events that happened to me
                    in the Timeline Tab")
          ),
          ##### Go Button--location will depend on your goals----
          div(
            style = "text-align: center;",
            bsButton(
              inputId = "go",
              label = "Prerequisites",
              size = "large",
              icon = icon("book"),
            )
          ),
          ##### Create two lines of space
          br(),
          br(),
          h2("Acknowledgements"),
          p(
            "This version of the app was developed and coded by Taryn McHugh.",
            br(),
            br(),
            "Cite this app as:",
            br(),
            citeApp(),
            br(),
            br(),
            div(class = "updated", "Last Update: 05/17/2023 by TM.")
          )
        ),
        #### Set up the Prerequisites Page ----
        tabItem(
          tabName = "prerequisites",
          withMathJax(),
          h2("About me"),
          h3("Hobbies"),
          wellPanel(
            p("Sports: I have always tried to participate in sports to stay active,
            I usually wasn't any good though. When I was younger, I was on my 
            local softball team for two years, and I picked it back up for two 
            years in middle school where I played second and shortstop. In high 
            school, I was on my high schools tennis team from sophomore to senior 
            year."),
            p("Travel: One of my goals is to travel as much as I can while I am still 
            relatively young. One of my dream destinations is Europe, potentially 
            Italy or Greece. As of now, I have been to/through all the states on 
            the east coast and some western states like Hawaii, California, Alaska, 
            and a few more. This summer I am super excited because I will be 
            going to Costa Rica by myself. I am super excited for the independency
            and experiencing another culture."),
            p("Extra Curriculars: In high shcool I was heavily involved in extra 
            curriculars. I was on my schools Unified Sports Teams (track/field and
            bocce), Debate Team, Tennis Team, Exec Council, and Mini THON. In college, 
            I joined a sorority, Special Olympics, and THON."),
          ),

          h4('Home'),
          wellPanel(
            p("Home: When I was younger I lived in the south for the mostpart.
            Until I was in second grade, I lived in Loganville, GA. For third 
            grade I lived in Gadsten, AL. Currently I reside in Bucks County, PA."),
            p("Family: I have two older sisters. My eldest sisters name is Laura,
            she is 27 and lives in Leesburg, VA with her fiance. My other sisters
            name is Paige, she is 22 and is graduing from SJU in Philly this
            semester."),
            p("Pets: I have had various pets throughout my life including dogs, cats,
            turtles, fish, and bearded dragons. Currently, I have two dogs named 
            Ellie and Mariposa. Ellie is a black terrier mix and Mariposa is a white
            Pekingese mix."),
            plotOutput(
              outputId = "numSpeciesPlot",
              width = "100%",
              height = "400px"
            )
          )
        ),
        #### Set up an Timeline Page ----
        tabItem(
          tabName = "timeline",
          withMathJax(),
          h2("Visual Timeline"),
          p("Slide the bar to each age in my life to see images of key events in
            my life for that age."),
          fluidRow(
            column(
              width = 6,
              sliderInput(
                inputId = "age",
                label = "Age",
                min = 9,
                max = 18,
                step = 3,
                value = 3
              ),
              uiOutput('event'),
            )
          )
        ),
        #### Set up the References Page ----
        tabItem(
          tabName = "references",
          withMathJax(),
          h2("References"),
          p("You'll need to fill in this page with all of the appropriate
            references for your app."),
          p(
            class = "hangingindent",
            "Bailey, E. (2015). shinyBS: Twitter bootstrap components for shiny.
            (v0.61). [R package]. Available from
            https://CRAN.R-project.org/package=shinyBS"
          ),
          br(),
          br(),
          br(),
          boastUtils::copyrightInfo()
        )
      )
    )
  )
)

# Define server logic ----
server <- function(input, output, session) {
  
  ## Species Plot Rendering
  output$numSpeciesPlot <-renderPlot({
    ggplot(data = "pets.csv",
           mapping = aes(x = "", y = Number, fill=Pet.Type)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar("y", start = 0) +
      geom_text(aes(label = paste0(Number)), position = position_stack(vjust=0.5)) +
      theme(axis.text = element_blank()) + 
      labs(x = NULL,
           y = NULL,
           fill = 'Species')
  })
  
  
  ## Timeline Image ----
  output$event <- renderUI({
    if(input$age == "9"){
      list(      
        img(height = 300,
          width = 300,
          src = "age9.jpg",
          alt = "Image of a sunset in the neighborhood."),
      br(),
      p("When I was 9 I moved to Pennslyvania. This is a picture of a sunset 
        outside my house. "))
    } else if(input$age == "12"){
      list(
      img(height = 240,
          width = 330,
          src = "age12.jpg",
          alt = "Imagine of a wooden sign that says Welcome to Alaska and the Gateway
          to the Klondike."),
      br(),
      p("When I was 12 was when I travelled across the country for the first time. 
        We went on a cruise to visit various locaitons in Alaska and Canada."))
    } else if(input$age == "15") {
      list(
      img(height = 240,
          width = 300, 
          src = "age15.jpg",
          alt = "A collage of photos of Taryn when she was 15. It includes her 
          and her 2 frineds, her and she sister in a agraduation gown, and her 
          and her freinds in tennis uniforms."),
      br(),
      p("Here are some pictures from when I was 15. The left image is a picture 
        of me and my friends when we went to Ocean City, NJ together. My sister 
        also graduated high school (top right). Sophomore year was when I was 15,
        so that I when I joined the tennis team. It is a picture of me and my friends
        at a match (lower right)."))
    } else {
      list(
      img(height = 300,
          width = 300, 
          src = "age18.jpg",
          alt = "A collage of photos of Taryn when she was 18. There is an image 
          of her at her high school graudation, her posing for her first day of 
          college, and a botanical garden from when she went to Hawaii."),
      br(),
      p("A lot of exciting things happened when I was 18. I graduated high school
        (left). Over the summer, I went to Hawaii for the right time (upper right).
        Then started my first day of college at PSU (bottom right)."))
    }
  })
  

  ## Set up Info button ----
  observeEvent(
    eventExpr = input$info,
    handlerExpr = {
      sendSweetAlert(
        session = session,
        type = "info",
        title = "Information",
        text = "Select the Prerequisites Tab to learn facts about me. Then, select 
        the Timeline Tab to see pictures associated with the facts in the Prerequisites
        Tab."
      )
    }
  )
  ## Overview to  Button----
  observeEvent(
    eventExpr = input$go,
    handlerExpr = {
      updateTabItems(
        session = session,
        inputId = "pages",
        selected = "prerequisites"
      )
    }
  )
}


# Boast App Call ----
boastUtils::boastApp(ui = ui, server = server)