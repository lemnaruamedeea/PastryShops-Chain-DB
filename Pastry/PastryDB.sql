--- DROP

--- STERGERE TABEL ANGAJATI_COFETARII
ALTER TABLE ANGAJATI_COFETARII
    DROP CONSTRAINT ANGAJATI_COFETARII_ID_Angajat_FK
    DROP CONSTRAINT ANGAJATI_COFETARII_ID_Cofetarie_FK;
DROP TABLE ANGAJATI_COFETARII;

--- STERGERE PRODUSE_COFETARII
ALTER TABLE PRODUSE_COFETARII
    DROP CONSTRAINT PRODUSE_COFETARII_ID_Produs_FK
    DROP CONSTRAINT PRODUSE_COFETARII_ID_Cofetarie_FK;
DROP TABLE PRODUSE_COFETARII;

--- STERGERE TABEL INGREDIENTE_PRODUSE
ALTER TABLE INGREDIENTE_PRODUSE
    DROP CONSTRAINT INGREDIENTE_PRODUSE_ID_Ingredient_FK
    DROP CONSTRAINT INGREDIENTE_PRODUSE_ID_Produs_FK;
DROP TABLE INGREDIENTE_PRODUSE;

--- STERGERE TABEL ANGAJATI
ALTER TABLE ANGAJATI
    DROP CONSTRAINT ANGAJATI_ID_Job_FK
    DROP CONSTRAINT ANGAJATI_ID_Masina_FK;
DROP TABLE ANGAJATI;

--- STERGERE TABEL COFETARII
ALTER TABLE COFETARII
    DROP CONSTRAINT COFETARII_ID_Locatie_FK;
DROP TABLE COFETARII;

--- STERGERE TABEL PRODUSE
DROP TABLE PRODUSE;

--- STERGERE TABEL INGREDIENTE
DROP TABLE INGREDIENTE;

--- STERGERE TABEL JOBURI
DROP TABLE JOBURI;

--- STERGERE TABEL MASINI
DROP TABLE MASINI;

--- STERGERE TABEL LOCATII
DROP TABLE LOCATII;


-- CREAREA TABELELOR

--- CREAREA TABELULUI LOCATII
CREATE TABLE LOCATII(
    ID_Locatie NUMBER(5,0)
        CONSTRAINT LOCATII_ID_Locatie_PK PRIMARY KEY,
    Judet VARCHAR2(30 BYTE)
        CONSTRAINT LOCATII_Judet_NN NOT NULL,
    Oras VARCHAR2(30 BYTE)
        CONSTRAINT LOCATII_Oras_NN NOT NULL,
    Strada VARCHAR2(40 BYTE)
        CONSTRAINT LOCATII_Strada_NN NOT NULL
);


--- CREAREA TABELULUI JOBURI
CREATE TABLE JOBURI(
    ID_Job NUMBER(5,0)
        CONSTRAINT JOBURI_ID_Job_PK PRIMARY KEY,
    Titlu VARCHAR2(30 BYTE)
        CONSTRAINT JOBURI_Titlu_NN NOT NULL,
    Salariu NUMBER(8, 2)
        CONSTRAINT JOBURI_Salariu_NN NOT NULL
);


--- CREAREA TABELULUI MASINI
CREATE TABLE MASINI(
    ID_Masina VARCHAR2(10 BYTE)
        CONSTRAINT MASINI_ID_Masina_PK PRIMARY KEY,
    Marca VARCHAR2(30 BYTE)
        CONSTRAINT MASINI_Marca_NN NOT NULL,
    Culoare VARCHAR2(30 BYTE)
        CONSTRAINT MASINI_Culoare_NN NOT NULL
);


--- CREAREA TABELULUI COFETARII
CREATE TABLE COFETARII(
    ID_Cofetarie NUMBER(5,0)
        CONSTRAINT COFETARII_ID_Cofetarie_PK PRIMARY KEY,
    Nume VARCHAR2(30 BYTE)
        CONSTRAINT COFETARII_Nume_NN NOT NULL,
    Ora_Deschidere VARCHAR2(10 BYTE)
        CONSTRAINT COFETARII_Ora_Deschidere_NN NOT NULL,
    Ora_Inchidere VARCHAR2(10 BYTE)
        CONSTRAINT COFETARII_Ora_Inchidere_NN NOT NULL,
    ID_Locatie NUMBER(5,0)
        CONSTRAINT COFETARII_ID_Locatie_FK REFERENCES LOCATII (ID_Locatie) 
        ON DELETE CASCADE
        CONSTRAINT COFETARII_ID_Locatie_NN NOT NULL
);


--- CREAREA TABELULUI ANGAJATI
CREATE TABLE ANGAJATI(
    ID_Angajat NUMBER(5,0)
        CONSTRAINT ANGAJATI_ID_Angajat_PK PRIMARY KEY,
    Nume VARCHAR2(30 BYTE)
        CONSTRAINT ANGAJATI_Nume_NN NOT NULL,
    Prenume VARCHAR2(30 BYTE)
        CONSTRAINT ANGAJATI_Prenume_NN NOT NULL,
    Nr_Tel VARCHAR2(15 BYTE)
        CONSTRAINT ANGAJATI_Nr_Tel_NN NOT NULL
        CONSTRAINT ANGAJATI_Nr_Tel_U UNIQUE,
    Email VARCHAR2(30 BYTE)
        CONSTRAINT ANGAJATI_Email_NN NOT NULL
        CONSTRAINT ANGAJATI_Email_U UNIQUE,
    ID_Job NUMBER(5,0)
        CONSTRAINT ANGAJATI_ID_Job_FK REFERENCES JOBURI (ID_Job) 
        ON DELETE CASCADE
        CONSTRAINT ANGAJATI_ID_Job_NN NOT NULL,
    ID_Masina VARCHAR2(10 BYTE) DEFAULT NULL
        CONSTRAINT ANGAJATI_ID_Masina_FK REFERENCES MASINI (ID_Masina) 
        ON DELETE SET NULL
);


--- CREAREA TABELULUI ANGAJATI_COFETARII
CREATE TABLE ANGAJATI_COFETARII(
    ID_AngCof NUMBER(5,0)
        CONSTRAINT ANGAJATI_COFETARII_ID_AngCof_PK PRIMARY KEY,
    ID_Angajat NUMBER(5,0)
        CONSTRAINT ANGAJATI_COFETARII_ID_Angajat_FK REFERENCES ANGAJATI (ID_Angajat)
        ON DELETE SET NULL,
    ID_Cofetarie NUMBER(5,0)
        CONSTRAINT ANGAJATI_COFETARII_ID_Cofetarie_FK REFERENCES COFETARII (ID_Cofetarie)
        ON DELETE CASCADE
        CONSTRAINT ANGAJATI_COFETARII_ID_Cofetarie_NN NOT NULL,
    Data_Ang DATE
        CONSTRAINT ANGAJATI_COFETARII_Data_Ang_NN NOT NULL
);


--- CREAREA TABELULUI PRODUSE
CREATE TABLE PRODUSE(
    ID_Produs NUMBER(5,0)
        CONSTRAINT PRODUSE_ID_Produs_PK PRIMARY KEY,
    Denumire VARCHAR2(30 BYTE)
        CONSTRAINT PRODUSE_Denumire_NN NOT NULL
        CONSTRAINT PRODUSE_Denumire_U UNIQUE,
    Pret VARCHAR2(15 BYTE)
        CONSTRAINT PRODUSE_Pret_NN NOT NULL,
    Timp_Preparare VARCHAR2(20 BYTE)
        CONSTRAINT PRODUSE_Timp_Preparare_NN NOT NULL
);


--- CREAREA TABELULUI PRODUSE_COFETARII
CREATE TABLE PRODUSE_COFETARII(
    ID_ProdCof NUMBER(5,0)
        CONSTRAINT PRODUSE_COFETARII_ID_ProdCof_PK PRIMARY KEY,
    ID_Produs NUMBER(5,0)
        CONSTRAINT PRODUSE_COFETARII_ID_Produs_FK REFERENCES PRODUSE(ID_Produs) 
        ON DELETE SET NULL,
    ID_Cofetarie NUMBER(5,0)
        CONSTRAINT PRODUSE_COFETARII_ID_Cofetarie_FK REFERENCES COFETARII(ID_Cofetarie)
        ON DELETE CASCADE
        CONSTRAINT PRODUSE_COFETARII_ID_Cofetarie_NN NOT NULL,
    Nr_Prod_Zi NUMBER(3,0)
        CONSTRAINT PRODUSE_COFETARII_Nr_Prod_Zi_NN NOT NULL
);


--- CREAREA TABELULUI INGREDIENTE
CREATE TABLE INGREDIENTE(
    ID_Ingredient NUMBER(5,0)
        CONSTRAINT INGREDIENTE_ID_Ingredient_PK PRIMARY KEY,
    Denumire VARCHAR2(30 BYTE)
        CONSTRAINT INGREDIENTE_Denumire_NN NOT NULL,
    Proteine_100g NUMBER(5,2)
        CONSTRAINT INGREDIENTE_Proteine_100g_NN NOT NULL,
    Calorii_100g NUMBER(5,2)
        CONSTRAINT INGREDIENTE_Calorii_100g_NN NOT NULL
);


--- CREAREA TABELULUI INGREDIENTE_PRODUSE
CREATE TABLE INGREDIENTE_PRODUSE(
    ID_IngrProd NUMBER(5,0)
        CONSTRAINT INGREDIENTE_PRODUSE_ID_IngrProd_PK PRIMARY KEY,
    ID_Ingredient NUMBER(5,0)
        CONSTRAINT INGREDIENTE_PRODUSE_ID_Ingredient_FK REFERENCES INGREDIENTE(ID_Ingredient)
        ON DELETE CASCADE
        CONSTRAINT INGREDIENTE_PRODUSE_ID_Ingredient_NN NOT NULL,
    ID_Produs NUMBER(5,0)
        CONSTRAINT INGREDIENTE_PRODUSE_ID_Produs_FK REFERENCES PRODUSE(ID_Produs)
        ON DELETE SET NULL,
    INGREDIENTE_PRODUSE_Cant_Ingr_NN VARCHAR2(10 BYTE)
        CONSTRAINT INGREDIENTE_PRODUSE_Cant_Ingr_NN NOT NULL
        
);


----- POPULAREA TABELELOR


--- LOCATII

INSERT INTO LOCATII VALUES (1, 'Gorj', 'Targu-Jiu', 'Strada Victoriei, nr.219');
INSERT INTO LOCATII VALUES (2, 'Dolj', 'Craiova', 'Aleea 1 Mai, nr.52');
INSERT INTO LOCATII VALUES (3, 'Brasov', 'Brasov', 'Strada Bisericii Romane, nr.21');
INSERT INTO LOCATII VALUES (4, 'Cluj', 'Cluj-Napoca', 'Bulevardul Constantin Brancusi, nr.70');
INSERT INTO LOCATII VALUES (5, 'Timis', 'Timisoara', 'Piata Traian, nr.105');
INSERT INTO LOCATII VALUES (6, 'Valcea', 'Ramnicu Valcea', 'Strada Paraul Hotului, nr.25');
INSERT INTO LOCATII VALUES (7, 'Vaslui', 'Vaslui', 'Bulevardul Primaverii, nr.203');

--- COFETARII

INSERT INTO COFETARII VALUES(1, 'Tip Top M.S.', '12:00', '23:00', 3);
INSERT INTO COFETARII VALUES(2, 'Tip Top 2', '12:00', '20:00', 7);
INSERT INTO COFETARII VALUES(3, 'Tip Top Top', '13:00', '22:00', 1);
INSERT INTO COFETARII VALUES(4, 'Tip Top', '10:00', '23:00', 2);
INSERT INTO COFETARII VALUES(5, 'Tip Top', '12:00', '19:00', 5);

--- JOBURI

INSERT INTO JOBURI VALUES (1, 'Cofetar', 7000);
INSERT INTO JOBURI VALUES (2, 'Patiser', 6000);
INSERT INTO JOBURI VALUES (3, 'Vanvator', 4000);
INSERT INTO JOBURI VALUES (4, 'Brutar', 6500);
INSERT INTO JOBURI VALUES (5, 'Decorator', 5000);
INSERT INTO JOBURI VALUES (6, 'Livrator', 3500);

--- MASINI

INSERT INTO MASINI VALUES ('GJ 23 RFD', 'Dacia', 'Rosie');
INSERT INTO MASINI VALUES ('DJ 53 SFH', 'Mercedes-Benz', 'Negru');
INSERT INTO MASINI VALUES ('B 432 FVD', 'Renault', 'Alb');
INSERT INTO MASINI VALUES ('IF 23 EGF', 'Ford', 'Negru');

--- ANGAJATI

INSERT INTO ANGAJATI VALUES (1, 'Popescu', 'Alin', '0746384243', 'popescualin@gmail.ro', 5, 'GJ 23 RFD');
INSERT INTO ANGAJATI VALUES (2, 'Mircescu', 'Mihai', '+40735294528', 'mircescumihai@yahoo.ro', 3, NULL);
INSERT INTO ANGAJATI VALUES (3, 'Alinus', 'Maria', '0736683956', 'alinusmaria@gmail.com', 6, 'DJ 53 SFH');
INSERT INTO ANGAJATI VALUES (4, 'Pasare', 'Alina', '+40784265358', 'pasarealina@yahoo.ro', 4, 'IF 23 EGF');
INSERT INTO ANGAJATI VALUES (5, 'Lemnaru', 'David', '+40796526348', 'lemnarudavid@gmail.com', 1, 'DJ 53 SFH');
INSERT INTO ANGAJATI VALUES (6, 'Maioga', 'Cristina', '0759741233', 'maiogacristina@yahoo.ro', 2, NULL);
INSERT INTO ANGAJATI VALUES (7, 'Mirea', 'Aristid', '0755555855', 'mireaaristid@gmail.ro', 1, 'GJ 23 RFD');
INSERT INTO ANGAJATI VALUES (8, 'Anton', 'Ion', '+40763515524', 'antonion@yahoo.com', 3, 'IF 23 EGF');

--- ANGAJATI_COFETARII

INSERT INTO ANGAJATI_COFETARII VALUES (1, 1, 2, '30-Sep-2000');
INSERT INTO ANGAJATI_COFETARII VALUES (2, 5, 5, '22-Sep-2022');
INSERT INTO ANGAJATI_COFETARII VALUES (3, 4, 3, '23-Aug-2012');
INSERT INTO ANGAJATI_COFETARII VALUES (4, 3, 4, '15-May-2002');
INSERT INTO ANGAJATI_COFETARII VALUES (5, 2, 1, '1-Jan-2015');

--- INGREDIENTE

INSERT INTO INGREDIENTE VALUES (1, 'Ou de gaina', 175, 155);
INSERT INTO INGREDIENTE VALUES (2, 'Laptea de vaca', 54.2, 50);
INSERT INTO INGREDIENTE VALUES (3, 'Faina', 1.3, 364);
INSERT INTO INGREDIENTE VALUES (4, 'Ou de prepelita', 275, 158);
INSERT INTO INGREDIENTE VALUES (5, 'Cacao', 500, 227.5);

--- PRODUSE

INSERT INTO PRODUSE VALUES (1, 'Tiramisu', '15 lei', '3:45:23');
INSERT INTO PRODUSE VALUES (2, 'Indiana', '10 lei', '1:32:34');
INSERT INTO PRODUSE VALUES (3, 'Croissant', '3 lei', '00:12:42');
INSERT INTO PRODUSE VALUES (4, 'Ecler', '7 lei', '00:45:00');
INSERT INTO PRODUSE VALUES (5, 'Tort de ciocolata', '25.5 lei', '2:34:43');

--- INGREDIENTE_PRODUSE

INSERT INTO INGREDIENTE_PRODUSE VALUES (1, 1, 2, '100g');
INSERT INTO INGREDIENTE_PRODUSE VALUES (2, 1, 3, '500g');
INSERT INTO INGREDIENTE_PRODUSE VALUES (3, 2, 4, '24g');
INSERT INTO INGREDIENTE_PRODUSE VALUES (4, 2, 5, '753g');
INSERT INTO INGREDIENTE_PRODUSE VALUES (5, 3, 3, '633g');
INSERT INTO INGREDIENTE_PRODUSE VALUES (6, 3, 2, '734g');
INSERT INTO INGREDIENTE_PRODUSE VALUES (7, 4, 5, '110g');
INSERT INTO INGREDIENTE_PRODUSE VALUES (8, 4, 1, '34g');
INSERT INTO INGREDIENTE_PRODUSE VALUES (9, 5, 2, '53g');
INSERT INTO INGREDIENTE_PRODUSE VALUES (10, 5, 1, '12g');

--- PRODUSE_COFETARII

INSERT INTO PRODUSE_COFETARII VALUES (1, 2, 3, 20);
INSERT INTO PRODUSE_COFETARII VALUES (2, 1, 3, 25);
INSERT INTO PRODUSE_COFETARII VALUES (3, 3, 2, 30);
INSERT INTO PRODUSE_COFETARII VALUES (4, 4, 2, 20);
INSERT INTO PRODUSE_COFETARII VALUES (5, 1, 1, 20);
INSERT INTO PRODUSE_COFETARII VALUES (6, 5, 1, 30);
INSERT INTO PRODUSE_COFETARII VALUES (7, 5, 4, 50);
INSERT INTO PRODUSE_COFETARII VALUES (8, 2, 5, 45);


COMMIT;