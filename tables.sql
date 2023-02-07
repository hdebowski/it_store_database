BEGIN TRANSACTION;

DROP TABLE IF EXISTS klienci;
DROP TABLE IF EXISTS zamowienia;
DROP TABLE IF EXISTS produkty;
DROP TABLE IF EXISTS kategorie;
DROP TABLE IF EXISTS producenci;
DROP TABLE IF EXISTS wysylka;
DROP TABLE IF EXISTS kosz_zamowienia;

DROP VIEW IF EXISTS sprzedane_procesory;
DROP VIEW IF EXISTS brakujace_produkty;
DROP VIEW IF EXISTS statystyki_zamowien;
DROP VIEW IF EXISTS zamowienia_do_spakowania;
DROP VIEW IF EXISTS zamowienia_miasta;

-- TWORZENIE TABELI klienci
CREATE TABLE klienci(id_klienta INTEGER PRIMARY KEY, imie TEXT NOT NULL, nazwisko TEXT NOT NULL, plec TEXT CHECK (plec IN ('Mężczyzna', 'Kobieta')), telefon TEXT, email TEXT NOT NULL, adres TEXT NOT NULL, miejscowosc TEXT NOT NULL, kod_pocztowy TEXT NOT NULL);

-- DODAWANIE DANYCH klienci
INSERT INTO klienci VALUES (1, 'Hubert', 'Dębowski', 'Mężczyzna', '777-777-777', 'hdebowski@student.agh.edu.pl', 'Tokarskiego 6', 'Kraków', '30-065');
INSERT INTO klienci VALUES (2, 'Hubert', 'Borowski', 'Mężczyzna', '666-666-666', 'boroboro@student.agh.edu.pl', 'Osiedle Ogrodowe 188', 'Kraków', '30-065');
INSERT INTO klienci VALUES (3, 'Martyna', 'Świercz', 'Kobieta', '111-222-333', 'swierszcz@student.agh.edu.pl', 'Tokarskiego 6', 'Kraków', '30-065');
INSERT INTO klienci VALUES (4, 'Weronika', 'Budzisz', 'Kobieta', '321-321-321', 'wbudziszzz@student.agh.edu.pl', 'Tokarskiego 6', 'Kraków', '30-065');
INSERT INTO klienci VALUES (5, 'Michał', 'Ziemniak', 'Mężczyzna', '997-997-997', 'starostaziemniak@student.agh.edu.pl', 'Targowa 8A', 'Krościenko', '34-450');


-- TWORZENIE TABELI kategorie;
CREATE TABLE kategorie(id_kategorii INTEGER PRIMARY KEY, nazwa TEXT NOT NULL, opis TEXT);

-- DODAWANIE DANYCH
INSERT INTO kategorie VALUES (1, 'klawiatury', 'Klawiatury mechaniczne oraz membranowe.');
INSERT INTO kategorie VALUES (2, 'karty graficzne', 'Karty graficzne to niezbędne części aby cieszyć się świetnie wyglądającymi grami oraz płynnie działającymi programami.');
INSERT INTO kategorie VALUES (3, 'procesory', 'Mocne jednostki obliczeniowe są niezbędne dla prosefjonalistów, graczy oraz niedzielnego użytkownika komputera. To ona zapewnia płynność działania sprzętu');
INSERT INTO kategorie VALUES (4, 'myszki', 'Myszki do użytku biurowego oraz dla graczy.');
INSERT INTO kategorie VALUES (5, 'słuchawki', 'Nauszne, douszne, bezprzewodowe');

-- TWORZENIE TABELI producenci;
CREATE TABLE producenci(id_producenta INTEGER PRIMARY KEY, nazwa TEXT NOT NULL, email TEXT, strona_internetowa TEXT);

-- DODAWANIE DANYCH
INSERT INTO producenci VALUES (1, 'RAZER', 'pomoc@razer.com.pl', 'razer.com.pl');
INSERT INTO producenci VALUES (2, 'Samsung', 'info@samung.pl', 'samsung.pl');
INSERT INTO producenci VALUES (3, 'Intel', 'help@intel.com', 'intel.com');
INSERT INTO producenci VALUES (4, 'AMD', 'pomoc@amd.com.pl', 'amd.com.pl');
INSERT INTO producenci VALUES (5, 'Nvidia', 'konakt@nvidia.com', 'razer.com.pl');

-- TWORZENIE TABELI produkty;
CREATE TABLE produkty(id_produktu INTEGER PRIMARY KEY, nazwa TEXT NOT NULL, id_kategorii INTEGER, opis TEXT, cena DOUBLE NOT NULL, ilosc INTEGER NOT NULL, id_producenta INTEGER, FOREIGN KEY(id_kategorii) REFERENCES kategorie(id_kategorii), FOREIGN KEY(id_producenta) REFERENCES producenci(id_producenta));

-- DODAWANIE DANYCH
INSERT INTO produkty VALUES (1, 'Razer Prokeyboard 33333PRO', 1, 'Klawiatura mechaniczna, najszybsze przełączyniki na rynku. 8 kolorów diód LED.', 499.99, 300, 1);
INSERT INTO produkty VALUES (2, 'Samsung headphones basic 2.0', 5, 'Douszne słuchawki przewodowe Samsung',39.99 , 422, 2);
INSERT INTO produkty VALUES (3, 'AMD Ryzen 7300', 3, 'Potężny procesor przeznaczony dla profesjonalistów', 1499.99, 1000, 4);
INSERT INTO produkty VALUES (4, 'Nvidia GeForce GTX 1060', 2, 'Karta graficzna klasy średniej. Połączenie dobrej ceny oraz wydajności pozwalającej uruchomić wszystkie najnowsze gry.', 99.99, 20,5);
INSERT INTO produkty VALUES (5, 'RAZER headphones PRO bt', 1, 'Słuchawski bezprzewodowe dla graczy', 259.99, 100, 1);
INSERT INTO produkty VALUES (6, 'Intel i5 10105K', 3, 'Mocny, uniwersalny procesor.', 1300, 100, 3);
INSERT INTO produkty VALUES (7, 'Samsung office mouse classic', 4, 'Klasyczna myszka biurowa.', 59, 100, 2);
INSERT INTO produkty VALUES (8, 'AMD Radeon RX 6700', 2, 'Jedna z najmocniejszych kart graficznych', 6000, 1, 4);
INSERT INTO produkty VALUES (9, 'Razer Falcon laser mouse', 4, 'Myszka dla graczy. 8 przycisków sterowalnych.', 299.99, 2, 1);
INSERT INTO produkty VALUES (10, 'Intel i7 8600K', 3, 'Jeden z najmocniejszych procesorów 8 generecji Intela.', 800, 200, 3);

-- TWORZENIE TABELI wysylka;
CREATE TABLE wysylka(id_wysylka INTEGER PRIMARY KEY, id_zamowienia INTEGER, adres_wysylki TEXT, miejscowosc TEXT, kod_pocztowy TEXT, rodzaj TEXT CHECK (rodzaj IN ('paczkomat', 'poczta polska', 'kurier UPS')));

-- DODAWANIE DANYCH
INSERT INTO wysylka VALUES (1, 1, 'Tokarskiego 10', 'Kraków', '30-065', 'paczkomat');
INSERT INTO wysylka VALUES (2, 2, 'Tokarskiego 10', 'Kraków', '30-065', 'poczta polska');
INSERT INTO wysylka VALUES (3, 3, 'Tokarskiego 10', 'Kraków', '30-065', 'kurier UPS');
INSERT INTO wysylka VALUES (4, 4, 'Tokarskiego 10', 'Kraków', '30-065', 'paczkomat');
INSERT INTO wysylka VALUES (5, 5, 'Tokarskiego 10', 'Kraków', '30-065', 'paczkomat');
INSERT INTO wysylka VALUES (6, 6, 'Tokarskiego 10', 'Kraków', '30-065', 'poczta polska');
INSERT INTO wysylka VALUES (7, 7, 'Targowa 12', 'Krościenko', '34-450', 'paczkomat');
INSERT INTO wysylka VALUES (8, 8, 'Tokarskiego 10', 'Kraków', '30-065', 'paczkomat');
INSERT INTO wysylka VALUES (9, 9, 'Tokarskiego 10', 'Kraków', '30-065', 'paczkomat');
INSERT INTO wysylka VALUES (10, 10, 'Tokarskiego 10', 'Kraków', '30-065', 'poczta polska');
INSERT INTO wysylka VALUES (11, 11, 'Tokarskiego 10', 'Kraków', '30-065', 'paczkomat');
INSERT INTO wysylka VALUES (12, 12, 'Tokarskiego 10', 'Kraków', '30-065', 'kurier UPS');
INSERT INTO wysylka VALUES (13, 13, 'Targowa 8A', 'Krościenko', '34-450', 'poczta polska');
INSERT INTO wysylka VALUES (14, 14, 'Targowa 12', 'Krościenko', '34-450', 'paczkomat');
INSERT INTO wysylka VALUES (15, 15, 'Targowa 8A', 'Krościenko', '34-450', 'kurier UPS');

-- TWORZENIE TABELI zamowienia
CREATE TABLE zamowienia(id_zamowienia INTEGER PRIMARY KEY, id_klienta INTEGER, id_produktu INTEGER, platnosc TEXT CHECK(platnosc IN ('przelew online', 'blik','przelew tradycyjny', 'karta platnicza')), id_wysylka INTEGER, FOREIGN KEY(id_klienta) REFERENCES klienci(id_klienta),FOREIGN KEY(id_produktu) REFERENCES produkty(id_produktu), FOREIGN KEY(id_wysylka) REFERENCES wysylka(id_wysylka));

-- DODAWANIE DANYCH
INSERT INTO zamowienia VALUES (1, 1, 2, 'blik', 1);
INSERT INTO zamowienia VALUES (2, 2,  4, 'karta platnicza', 2);
INSERT INTO zamowienia VALUES (3, 3, 3, 'przelew online', 3);
INSERT INTO zamowienia VALUES (4, 4, 3, 'przelew online', 4);
INSERT INTO zamowienia VALUES (5, 3, 8, 'blik', 5);
INSERT INTO zamowienia VALUES (6, 3, 7, 'przelew online', 6);
INSERT INTO zamowienia VALUES (7, 5, 10, 'blik', 7);
INSERT INTO zamowienia VALUES (8, 1, 2, 'przelew tradycyjny', 8);
INSERT INTO zamowienia VALUES (9, 4, 2, 'przelew online', 9);
INSERT INTO zamowienia VALUES (10, 1, 9, 'blik', 10);
INSERT INTO zamowienia VALUES (11, 2, 2, 'przelew online', 11);
INSERT INTO zamowienia VALUES (12, 1, 7, 'blik', 12);
INSERT INTO zamowienia VALUES (13, 5, 5, 'karta platnicza', 13);
INSERT INTO zamowienia VALUES (14, 5, 3, 'blik', 14);
INSERT INTO zamowienia VALUES (15, 5, 2, 'przelew tradycyjny', 15);

-- ZAPYTANIA DO BAZY DANYCH


-- WIDOK ilość sprzedanych procesorów !!! git
CREATE VIEW sprzedane_procesory AS SELECT count(*) AS 'ilosc sprzedanych procesorow' FROM produkty NATURAL JOIN zamowienia WHERE id_produktu = 3;

-- PRODUKTY Z ZEROWYM STANEM MAGAZYNOWYM LUB 3 SZTUKI !!! GIT
CREATE VIEW brakujace_produkty AS SELECT * FROM produkty WHERE ilosc < 3;

-- JOIN dla magazynu do spakowania paczki
CREATE VIEW zamowienia_do_spakowania AS SELECT * FROM zamowienia JOIN wysylka ON zamowienia.id_wysylka = wysylka.id_wysylka;

-- statystyki zamowien
CREATE VIEW statystyki_zamowien AS SELECT avg(cena) AS 'srednia cena wszystkich zamowien', sum(cena) AS 'suma wszystkich zamowien', min(cena) AS 'najtańsze zamowienie', max(cena) AS 'najdroższe zamówienie' FROM zamowienia NATURAL JOIN produkty;

-- info z jakich miast sa zamowienia
CREATE VIEW zamowienia_miasta AS SELECT miejscowosc, count(miejscowosc) AS 'ilosc zamowien' FROM zamowienia JOIN klienci ON zamowienia.id_klienta = klienci.id_klienta GROUP BY miejscowosc;COMMIT;


-- trigger "Recycle Bin" dla usuniętych elementów
CREATE TABLE kosz_zamowienia AS SELECT * FROM zamowienia;
DELETE FROM kosz_zamowienia;  

CREATE TRIGGER kopia_usunietych_zamowien DELETE ON zamowienia
BEGIN
INSERT INTO kosz_zamowienia VALUES (old.id_zamowienia, old.id_klienta, old.id_produktu, old.platnosc, old.id_wysylka);
END;

