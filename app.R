# Load Packages ----
library(shiny)
library(shinydashboard)
library(shinyBS)
library(shinyWidgets)
library(boastUtils)

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
        boastUtils::surveyLink(name = "App_Template")
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
        menuItem("Background", tabName = "background", icon = icon("book")),
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
          h1("Introducion to Taryn McHugh"), # This should be the full name.
          p("Use this application to get to  know more about Taryn McHugh!"),
          h2("Instructions"),
          tags$ol(
            tags$li("Read facts about me using the Background Tab"),
            tags$li("See specific images that descirbe events that happened to me
                    in the Timeline Tab")
          ),
          ##### Go Button--location will depend on your goals----
          div(
            style = "text-align: center;",
            bsButton(
              inputId = "go",
              label = "Background",
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
        #### Set up the Background Page ----
        tabItem(
          tabName = "background",
          withMathJax(),
          h2("About me"),
          h3("Hobbies"),
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
          h4('Home'),
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
          tags$figure(
            align = 'center',
            tags$img(
              src = 'pets.png',
              width = 600,
              alt = 'Pie chart of how many of a species I have had and what species.'
            ),
            tags$figcaption("Number of pets I've had by Species")
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
              width = 4,
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
  
  ## Timeline Image ----
  output$event <- renderUI({
    if(input$age == "9"){
      img(height = 300,
          width = 300,
          src = "age9.jpg")
      br()
      p("jkvrek")
    } else if(input$age == "12"){
      img(height = 240,
          width = 330,
          src = "age12.jpg")
    } else if(input$age == "15") {
      img(height = 240,
          width = 300, 
          src = "age15.jpg")
    } else {
      img(height = 300,
          width = 300, 
          src = "age18.jpg")
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
        text = "Select the Background Tab to learn facts about me. Then, select 
        the Timeline Tab to see pictures associated with the facts in the Background
        Tab."
      )
    }
  )
  ## Overview to Background Button----
  observeEvent(
    eventExpr = input$go,
    handlerExpr = {
      updateTabItems(
        session = session,
        inputId = "pages",
        selected = "background"
      )
    }
  )
}


# Boast App Call ----
boastUtils::boastApp(ui = ui, server = server)