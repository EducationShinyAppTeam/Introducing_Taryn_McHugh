# Load Packages ----
library(shiny)
library(shinydashboard)
library(shinyBS)
library(shinyWidgets)
library(boastUtils)

# Load additional dependencies and setup functions----
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
          ##### Go Button--location will depend on your goals
          div(
            style = "text-align: center;",
            bsButton(
              inputId = "go1",
              label = "GO!",
              size = "large",
              icon = icon("bolt"),
              style = "default"
            )
          ),
          ##### Create two lines of space
          br(),
          br(),
          h2("Acknowledgements"),
          p(
            "This version of the app was developed and coded by Neil J.
            Hatfield  and Robert P. Carey, III.",
            br(),
            "We would like to extend a special thanks to the Shiny Program
            Students.",
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
        #### Set up background page----
        tabItem(
          tabName = "background",
          withMathJax(),
          h2("About me"),
          h4("Hobbies"),
          p("Sports: Athletisim has defiently never been something I excelled in,
            but I have always tried to do sports to stay active. When I was younger,
            I was on my local softball team for two years. I stoppped because I 
            moved around too much, but I picked it back up for 2 years in middle
            school. I was shortstop, second base, and tried pitching. In high 
            school, I was on my high schools tennis team from sophomore to senior 
            year."),
          p("Travel: One of my goals in line is to travel as much as I can while 
            I am still relatively young. I have not left the country (besdies Canada),
            but I am hoping to go to Europe soon. As of now, I have been to/through
            all the states on the east coast and some western states like Hawaii, 
            California, Alaska, and a few more. This summer I am super excited 
            because I will be going to Costa Rica by myself and I am suepr excited
            for the growth oppurtunity and have a fist person experince in a different
            culture."),
          p("Extra Curriculars: In high shcool I was heavily involded in extra 
            curricualrs. I was on my schools Unified Sports Teams (track/field and
            bocce), Debate Team, Tennis Team, Exec Council, and Mini THON. In college, 
            I joined a sorority, Special Olympics, and THON."),
          h3('Home'),
          p("Home: I have lived in various places. Until I was in second grade,
            I lived in Loganville, GA. For third grade I lived in Gadsten, AL. 
            Currently I reside in Bucks County, PA."),
          p("Family: I have two older sisters. My eldest sisters name is Laura,
            she is 27 and lives in Leesburg, VA with her fiance. My other sisters
            name is Paige, she is 22 and is graduing from SJU in Philly this
            semester."),
          p("Pets: I have had various pets throughout my life including dogs, cats,
            turtles, fish, and bearded dragons. Currently, I have two dogs named 
            Ellie and Mariposa. Ellie is a black terrier mix and Mariposa is a white
            Pekinese mix."),
        ),
        #### Set up the Timeline page ----
        tabItem(
          tabName = "timeline",
          withMathJax(),
          h2("Explore the Concept"),
          p("This page should include something for the user to do, the more
            active and engaging, the better. The purpose of this page is to help
            the user build a productive understanding of the concept your app
            is dedicated to."),
          p("Common elements include graphs, sliders, buttons, etc."),
          p("The following comes from the NHST Caveats App:"),
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

  ## Set up Info button ----
  observeEvent(
    eventExpr = input$info,
    handlerExpr = {
      sendSweetAlert(
        session = session,
        type = "info",
        title = "Information",
        text = "This App Template will help you get started building your own app"
      )
    }
  )


}

# Boast App Call ----
boastUtils::boastApp(ui = ui, server = server)
