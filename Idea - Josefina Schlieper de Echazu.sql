#PRIMERO CREAMOS Y ACTIVAMOS EL SCHEMA: 

CREATE SCHEMA gestion_aeroportuaria;

USE gestion_aeroportuaria;

#SEGUNDO, CREAMOS LAS TABLAS CON SUS PRIMARY Y FOREIGN KEYS:

-- Table: Pasajeros
CREATE TABLE Pasajeros (
    PasajeroID int NOT NULL,
    Nombre text(30) NOT NULL,
    Apellido text(30) NOT NULL,
    Pasaporte int NOT NULL,
    Email varchar(50),
    Nacionalidad text(30),
    Fecha_nacimiento date,
    Tripulante boolean NOT NULL,
    TripulanteID int,
    CONSTRAINT PK_PasajeroID PRIMARY KEY (PasajeroID)
);

-- Table: Adicionales
CREATE TABLE Adicionales (
    AdicionalID int NOT NULL,
    PasajeroID int NOT NULL,
    Valijas_numero int,
    Valijas_peso int,
    Vegetariano boolean,
	Seguro_de_viaje boolean,
    CONSTRAINT PK_AdicionalID PRIMARY KEY (AdicionalID),
    CONSTRAINT FK_PasajeroID FOREIGN KEY (PasajeroID) REFERENCES Pasajeros(PasajeroID)
);

-- Table: Destino
CREATE TABLE Destino (
    DestinoID int NOT NULL,
    Codigo_aeropuerto text(3) NOT NULL,
    Ciudad text(25) NOT NULL,
    Pais text(25) NOT NULL,
    Nombre_aeropuerto text(50),
    Terminal int,
    Puerta varchar(4),
    CONSTRAINT PK_DestinoID PRIMARY KEY (DestinoID)
);

-- Table: Vuelo
CREATE TABLE Vuelo (
    VueloID varchar(6) NOT NULL,
    DestinoID int NOT NULL,
    FechaHora_salida datetime NOT NULL,
    FechaHora_llegada datetime NOT NULL,
    id_level int NOT NULL,
    id_class int NOT NULL,
    AerolineaID varchar(2) NOT NULL,
    Aeronave int,
    CONSTRAINT PK_VueloID PRIMARY KEY (VueloID),
    CONSTRAINT FK_DestinoID FOREIGN KEY (DestinoID) REFERENCES Destino(DestinoID),
    CONSTRAINT FK_AerolineaID FOREIGN KEY (AerolineaID) REFERENCES Aerolinea(AerolineaID)
);


-- Table: Reserva
CREATE TABLE Reserva (
    ReservaID int NOT NULL,
    PasajeroID int NOT NULL,
    VueloID varchar(6) NOT NULL,
    FechaHora_reserva datetime,
    Numero_asiento varchar(3),
    Precio_ticket int,
    AdicionalID int NOT NULL,
    CONSTRAINT PK_ResevaID PRIMARY KEY (ReservaID),
    CONSTRAINT FK_PasajeroID_Reserva FOREIGN KEY (PasajeroID) REFERENCES Pasajeros(PasajeroID),
    CONSTRAINT FK_VueloID FOREIGN KEY (VueloID) REFERENCES Vuelo(VueloID),
    CONSTRAINT FK_AdicionalID FOREIGN KEY (AdicionalID) REFERENCES Adicionales(AdicionalID)
);

-- Table: Tripulacion
CREATE TABLE Tripulacion (
    TripulanteID int NOT NULL,
    PasajeroID int NOT NULL,
    Puesto text(30),
    Aerolinea text(30),
    CONSTRAINT PK_TripulanteID PRIMARY KEY (TripulanteID),
    CONSTRAINT FK_PasajeroID_Tripulacion FOREIGN KEY (PasajeroID) REFERENCES Pasajeros(PasajeroID)
);

-- Table: Aerolinea
CREATE TABLE Aerolinea (
    AerolineaID varchar(2) NOT NULL,
    Aerolinea text(30),
    Email varchar(50),
    CONSTRAINT PK_AerolineaID PRIMARY KEY (AerolineaID)
);

-- Table: Feedback
CREATE TABLE Feedback (
    FeedbackID int NOT NULL,
    PasajeroID int NOT NULL,
    VueloID varchar(6) NOT NULL,
    Feedback text,
    Rating int,
    CONSTRAINT PK_FeedbackID PRIMARY KEY (FeedbackID),
	CONSTRAINT FK_PasajeroID_Feedback FOREIGN KEY (PasajeroID) REFERENCES Pasajeros(PasajeroID),
    CONSTRAINT FK_VueloID_Feedback FOREIGN KEY (VueloID) REFERENCES Vuelo(VueloID)
);
