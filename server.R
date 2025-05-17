##### stworzenie serwera aplikacji shiny
shinyServer(function(input, output) {
        
    output$produkty <- renderDataTable(
        load.produkty(input$rodzaj, input$material, input$kolor, input$wysokosc_obcasa, input$kolekcja, input$sezon),
        options = list(
            pageLength = 10,
            lengthChange = FALSE,
            searching = FALSE,
            info = FALSE
        )
    )
    output$klienci <- renderDataTable(
        load.klienci(input$imie, input$nazwisko),
        options = list(
            pageLength = 10,
            lengthChange = FALSE,
            searching = FALSE,
            info = FALSE
        )
    )
    output$zamowienia <- renderDataTable(
        load.zamowienia(input$id, input$status),
        options = list(
            pageLength = 10,
            lengthChange = FALSE,
            searching = FALSE,
            info = FALSE
        )
    )
    output$koszyki <- renderDataTable(
        load.koszyki(input$id_koszyki),
        options = list(
            pageLength = 10,
            lengthChange = FALSE,
            searching = FALSE,
            info = FALSE
        )
    )
    output$zwroty <- renderDataTable(
        load.zwroty(input$id_zwroty),
        options = list(
            pageLength = 10,
            lengthChange = FALSE,
            searching = FALSE,
            info = FALSE
        )
    )
    output$reklamacje <- renderDataTable(
        load.reklamacje(input$id_reklamacje),
        options = list(
            pageLength = 10,
            lengthChange = FALSE,
            searching = FALSE,
            info = FALSE
        )
    )
    
    observeEvent(input$dodaj.produkt,
                 add.produkt(input$nazwa_ed, input$cena_ed, input$dla_kogo_ed, input$rozmiar_ed,
                             input$rodzaj_ed, input$kolor_ed, input$kolekcja_ed, input$material_ed,
                             input$wysokosc_obcasa_ed, input$sezon_ed))
    
    observeEvent(input$aktualizuj.status.zwrotu,
                 update.status.zwrotu(input$decyzja, input$id_zwrotu))
    
    observeEvent(input$akt.status,
                 update.status.zamowienia(input$id_zam))
    
    observeEvent(input$usun.produkt,
                 delete.product(input$id_prod))
    
    observeEvent(input$akt.produkt,
                 update.product(input$id_prod_2, input$cena_zam))
})
