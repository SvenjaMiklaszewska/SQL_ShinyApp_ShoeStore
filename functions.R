library("RPostgres")

##### polaczenie z baza danych
open.my.connection <- function() {
  con <- dbConnect(RPostgres::Postgres(),dbname = 'projekt', 
                   host = 'localhost',
                   port = 5432, 
                   user = '...',
                   password = '...')
  return (con)
}

close.my.connection <- function(con) {
  dbDisconnect(con)
}


##### funkcje pomocnicze

# Produkty
load.rodzaje <- function() {
  query = "SELECT nazwa FROM rodzaje"
  con = open.my.connection()
  res = dbSendQuery(con,query)
  rodzaje = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(rodzaje)
}

load.material <- function() {
  query = "SELECT nazwa FROM material"
  con = open.my.connection()
  res = dbSendQuery(con,query)
  material = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(material)
}

load.kolor <- function() {
  query = "SELECT nazwa FROM kolor"
  con = open.my.connection()
  res = dbSendQuery(con,query)
  kolor = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(kolor)
}

load.wysokosc_obcasa <- function() {
  query = "SELECT wysokosc FROM wysokosc_obcasa"
  con = open.my.connection()
  res = dbSendQuery(con,query)
  wysokosc = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(wysokosc)
}

load.kolekcja <- function() {
  query = "SELECT nazwa FROM kolekcja"
  con = open.my.connection()
  res = dbSendQuery(con,query)
  kolekcja = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(kolekcja)
}

load.sezon <- function() {
  query = "SELECT nazwa FROM sezon"
  con = open.my.connection()
  res = dbSendQuery(con,query)
  sezon = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(sezon)
}

load.produkty <- function(rodzaj, material, kolor, wysokosc_obcasa, kolekcja, sezon){
  s <- "SELECT * FROM produkty WHERE "
  i <- c()
  if(rodzaj != " - "){
    i <- c(i, paste0(" rodzaj = '", rodzaj, "' "))
  }
  if(material != " - "){
    i <- c(i, paste0(" material = '", material, "' "))
  }
  if(kolor != " - "){
    i <- c(i, paste0(" kolor = '", kolor, "' "))
  }
  if(wysokosc_obcasa != " - "){
    i <- c(i, paste0(" wysokosc_obcasa = '", wysokosc_obcasa, "' "))
  }
  if(kolekcja != " - "){
    i <- c(i, paste0(" kolekcja = '", kolekcja, "' "))
  }
  if(sezon != " - "){
    i <- c(i, paste0(" sezon = '", sezon, "' "))
  }
  if(length(i) == 0){
    query <- "SELECT * FROM produkty"
  }
  if(length(i) == 1){
    query <- paste0(s, i[1])
  }
  if(length(i) > 1){
    s <- paste0(s, i[1])
    for(j in i[2:length(i)]){
      s <- paste0(s, "AND", j)
    }
    query <- s
  }
  con = open.my.connection()
  res = dbSendQuery(con,query)
  produkty = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(produkty)
}

# Klienci
load.imie_klienta <- function() {
  query = "SELECT imie FROM klienci"
  con = open.my.connection()
  res = dbSendQuery(con,query)
  klienci = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(klienci)
}

load.nazwisko_klienta <- function() {
  query = "SELECT nazwisko FROM klienci"
  con = open.my.connection()
  res = dbSendQuery(con,query)
  klienci = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(klienci)
}

load.klienci <- function(imie, nazwisko) {
  s <- "SELECT * FROM klienci WHERE "
  i <- c()
  if(imie != " - "){
    i <- c(i, paste0(" imie = '", imie, "' "))
  }
  if(nazwisko != " - "){
    i <- c(i, paste0(" nazwisko = '", nazwisko, "' "))
  }
  
  if(length(i) == 0){
    query <- "SELECT * FROM klienci"
  }
  if(length(i) == 1){
    query <- paste0(s, i[1])
  }
  if(length(i) == 2){
    s <- paste0(s, i[1], " AND ", i[2])
    query <- s
  }
  con = open.my.connection()
  res = dbSendQuery(con,query)
  klienci = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(klienci)
}

# Zamówienia
load.id.klientow.zamowienia <- function(){
  query = "SELECT id_klienta FROM status_paczki"
  con = open.my.connection()
  res = dbSendQuery(con,query)
  id = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(id)
}

load.statusy <- function(){
  query = "SELECT status_zamowienia FROM status_paczki"
  con = open.my.connection()
  res = dbSendQuery(con,query)
  status = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(status)
}

load.zamowienia <- function(id, status){
  s <- "SELECT * FROM status_paczki WHERE "
  i <- c()
  if(id != " - "){
    i <- c(i, paste0(" id_klienta = '", id, "' "))
  }
  if(status != " - "){
    i <- c(i, paste0(" status_zamowienia = '", status, "' "))
  }
  
  if(length(i) == 0){
    query <- "SELECT * FROM status_paczki"
  }
  if(length(i) == 1){
    query <- paste0(s, i[1])
  }
  if(length(i) == 2){
    s <- paste0(s, i[1], " AND ", i[2])
    query <- s
  }
  con = open.my.connection()
  res = dbSendQuery(con,query)
  z = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(z)
}

load.id.zam <- function(){
  query = "SELECT id_zamowienia FROM zamowienia"
  con = open.my.connection()
  res = dbSendQuery(con,query)
  id = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(id)
}

update.status.zamowienia <- function(id){
  query = paste0("SELECT aktualizuj_status_zam(",id,")")
  con = open.my.connection()
  res = dbSendQuery(con,query)
  id = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(id)
}


# Koszyki
load.koszyki <- function(id) {
  if(id == " - "){
    query <- "SELECT * FROM zawartosc_koszyka_view"
  }
  if(id != " - "){
    query <- paste0("SELECT * FROM zawartosc_koszyka_view WHERE id_klienta = '", id, "'")
  }
  con = open.my.connection()
  res = dbSendQuery(con,query)
  koszyki = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(koszyki)
}

load.id.klientow.koszyki <- function(){
  query = "SELECT id_klienta FROM zawartosc_koszyka_view"
  con = open.my.connection()
  res = dbSendQuery(con,query)
  id = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(id)
}


# Zwroty
load.id.zam.do.zwr <- function(){
  query = "SELECT id_zamowienia FROM status_zwrotow"
  con = open.my.connection()
  res = dbSendQuery(con,query)
  id = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(id)
}

load.zwroty <- function(id) {
  if(id == " - "){
    query = "SELECT * FROM status_zwrotow"
  } else{
    query = paste0("SELECT * FROM status_zwrotow WHERE id_zamowienia = '", id, "'")
  }
  con = open.my.connection()
  res = dbSendQuery(con,query)
  zwr = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(zwr)
}

load.id.zwrotu <- function(){
  query = "SELECT id_zwrotu FROM zwroty"
  con = open.my.connection()
  res = dbSendQuery(con,query)
  id = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(id)
}

update.status.zwrotu <- function(decyzja, id) {
  if(decyzja == "Rozpatrzone pozytywnie"){
    i <- 1
  }
  if(decyzja == "Rozpatrzone negatywnie"){
    i <- 0
  }
  query = paste0("SELECT aktualizuj_status_zwrotu(",i,",'",id,"')")
  con = open.my.connection()
  dbSendQuery(con,query)
  close.my.connection(con)
}

# Reklamacje
load.id.zam.do.rekl <- function(){
  query = "SELECT id_zamowienia FROM reklamacje_view"
  con = open.my.connection()
  res = dbSendQuery(con,query)
  id = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(id)
}

load.reklamacje <- function(id) {
  if(id == " - "){
    query = "SELECT * FROM reklamacje_view"
  } else{
    query = paste0("SELECT * FROM reklamacje_view WHERE id_zamowienia = '", id, "'")
  }
  con = open.my.connection()
  res = dbSendQuery(con,query)
  rekl = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(rekl)
}



# Edycja
load.dla_kogo <- function(){
  query = "SELECT DISTINCT dla_kogo FROM produkty"
  con = open.my.connection()
  res = dbSendQuery(con,query)
  nazwa = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(nazwa)
}

load.rozmiary <- function(){
  query = "SELECT rozmiar FROM rozmiar"
  con = open.my.connection()
  res = dbSendQuery(con,query)
  r = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(r)
}

add.produkt <- function(nazwa, cena, dla_kogo, rozmiar,
                        rodzaj, kolor, kolekcja, material,
                        wysokosc_obcasa, sezon) {
  cena = cena - 0.01
  query = paste0("SELECT dodaj_produkt('",nazwa,"',",cena,",'",dla_kogo,"',",rozmiar,",'",rodzaj,"','",kolor,"','",kolekcja,"','",material,"',",wysokosc_obcasa,",'",sezon,"')")
  con = open.my.connection()
  dbSendQuery(con,query)
  close.my.connection(con)
}

load.id.produktow <- function(){
  query = "SELECT id_produktu FROM produkty ORDER BY id_produktu"
  con = open.my.connection()
  res = dbSendQuery(con,query)
  r = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(r)
}

delete.product <- function(id){
  query = paste0("DELETE FROM produkty WHERE id_produktu = ", id)
  con = open.my.connection()
  res = dbSendQuery(con,query)
  r = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(r)
}

update.product <- function(id, cena){
  cena <- cena - 0.01
  query = paste0("UPDATE produkty set cena =", cena, " WHERE id_produktu = ", id)
  con = open.my.connection()
  res = dbSendQuery(con,query)
  r = dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(r)
}
