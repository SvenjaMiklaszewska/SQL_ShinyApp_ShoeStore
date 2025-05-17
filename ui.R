library(shiny)
source(file='functions.r')


shinyUI(fluidPage(
    
    titlePanel("Sklep obuwniczy"),
    mainPanel(
        tabsetPanel(
            tabPanel('Produkty',
                     fluidRow(
                       column(4,
                              selectInput(inputId='rodzaj',
                                          label='Rodzaj',
                                          choices=c(" - ", load.rodzaje()))
                              ),
                       column(4,
                              selectInput(inputId='material',
                                          label='Material',
                                          choices=c(" - ", load.material()))
                              ),
                       column(4,
                              selectInput(inputId='kolor',
                                          label='Kolor',
                                          choices=c(" - ", load.kolor()))
                              ),
                       column(4,
                              selectInput(inputId='wysokosc_obcasa',
                                          label='Wysokosc obcasa',
                                          choices=c(" - ", load.wysokosc_obcasa()))
                              ),
                       column(4,
                              selectInput(inputId='kolekcja',
                                          label='Kolekcja',
                                          choices=c(" - ", load.kolekcja()))
                              ),
                       column(4,
                             selectInput(inputId='sezon',
                                         label='Sezon',
                                         choices=c(" - ", load.sezon()))
                             ),
                       dataTableOutput('produkty')
            )),
            tabPanel('Klienci',
                     fluidRow(
                       column(4,
                              selectInput(inputId='imie',
                                          label='Imie',
                                          choices=c(" - ", load.imie_klienta()))
                       ),
                       column(4,
                              selectInput(inputId='nazwisko',
                                          label='Nazwisko',
                                          choices=c(" - ", load.nazwisko_klienta()))
                       ),
                       dataTableOutput('klienci')
                     )
            ),
            tabPanel('Zamowienia',
                     fluidRow(
                       column(4,
                              selectInput(inputId='id',
                                          label='ID klienta',
                                          choices=c(" - ", load.id.klientow.zamowienia()))
                       ),
                       column(4,
                              selectInput(inputId='status',
                                          label='Status',
                                          choices=c(" - ", load.statusy()))
                       ),
                       dataTableOutput('zamowienia'),
                       h3("Aktualizuj status zamowienia"),
                       column(4,
                              selectInput(inputId='id_zam',
                                          label='ID zamowienia',
                                          choices=load.id.zam())
                       ),
                       br(),
                       column(4,
                              actionButton(inputId='akt.status',
                                           label='Zaktualizuj status zamowienia'))
                       )
                     ),
            tabPanel('Koszyki',
                     fluidRow(
                       column(4,
                              selectInput(inputId='id_koszyki',
                                          label='ID klienta',
                                          choices=c(" - ", load.id.klientow.koszyki()))
                       ),
                       dataTableOutput('koszyki')
                     )
            ),
            tabPanel('Zwroty',
                     fluidRow(
                       column(4,
                              selectInput(inputId='id_zwroty',
                                          label='ID zamowienia',
                                          choices=c(" - ", load.id.zam.do.zwr()))
                       ),
                       dataTableOutput('zwroty'),
                       h3("Aktualizuj zwrot"),
                       column(4,
                              selectInput(inputId='id_zwrotu',
                                          label='ID zwrotu',
                                          choices=load.id.zwrotu())
                       ),
                       column(4,
                              selectInput(inputId='decyzja',
                                          label='Decyzja',
                                          choices=c("Rozpatrzone pozytywnie", "Rozpatrzone negatywnie"))
                       ),
                       br(),
                       column(5,
                              actionButton(inputId='aktualizuj.status.zwrotu',
                                           label='Zaktualizuj status zwrotu'))
                      )
            ),
            tabPanel('Reklamacje',
                     fluidRow(
                       column(4,
                              selectInput(inputId='id_reklamacje',
                                          label='ID zamowienia',
                                          choices=c(" - ", load.id.zam.do.rekl()))
                       ),
                       dataTableOutput('reklamacje')
                     )
            ),
            tabPanel('Edycja',
                     tabsetPanel(
                         tabPanel("Dodawanie produktow",
                                  fluidRow(
                                      column(4,
                                             textInput(inputId='nazwa_ed',
                                                       label='Nazwa produktu')
                                      ),
                                      column(4,
                                             selectInput(inputId='dla_kogo_ed',
                                                         label='Dla kogo',
                                                         choices=load.dla_kogo())
                                      ),
                                      column(4,
                                             selectInput(inputId='rozmiar_ed',
                                                         label='Rozmiar',
                                                         choices=load.rozmiary())
                                      ),
                                      column(4,
                                             selectInput(inputId='rodzaj_ed',
                                                         label='Rodzaj',
                                                         choices=load.rodzaje())
                                      ),
                                      column(4,
                                             selectInput(inputId='kolor_ed',
                                                         label='Kolor',
                                                         choices=load.kolor())
                                      ),
                                      column(4,
                                             selectInput(inputId='kolekcja_ed',
                                                         label='Kolekcja',
                                                         choices=load.kolekcja())
                                      ),
                                      column(4,
                                             selectInput(inputId='material_ed',
                                                         label='Material',
                                                         choices=load.material())
                                      ),
                                      column(4,
                                             selectInput(inputId='wysokosc_obcasa_ed',
                                                         label='Wysokosc obcasa',
                                                         choices=load.wysokosc_obcasa())
                                      ),
                                      column(4,
                                             selectInput(inputId='sezon_ed',
                                                         label='Sezon',
                                                         choices=load.sezon())
                                      ),
                                      column(4,
                                             sliderInput(inputId='cena_ed',
                                                         label='Cena',
                                                         min=0,max=1000,value=500)
                                      ),
                                      br(),
                                      br(),
                                      column(4,
                                             actionButton(inputId='dodaj.produkt',
                                                          label='Dodaj produkt')
                                      )
                                  )),
                         tabPanel("Usuwanie produktow",
                                  fluidRow(
                                      column(4,
                                             selectInput(inputId='id_prod',
                                                         label='ID produktu',
                                                         choices=load.id.produktow())
                                      ),
                                      br(),
                                      column(4,
                                             actionButton(inputId='usun.produkt',
                                                          label='Usun produkt')
                                      )
                                  )),
                         tabPanel("Aktualizowanie produktow",
                                  fluidRow(
                                      column(4,
                                             selectInput(inputId='id_prod_2',
                                                         label='ID produktu',
                                                         choices=load.id.produktow())
                                      ),
                                      column(4,
                                             sliderInput(inputId='cena_zam',
                                                         label='Cena',
                                                         min=0,max=1000,value=500)
                                      ),
                                      br(),
                                      column(4,
                                             actionButton(inputId='akt.produkt',
                                                          label='Zaktualizuj cene produktu')
                                      )
                                  ))
                     )
            )
        )
    )
))

