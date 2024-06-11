CREATE TABLE Sucursal (
    id              SERIAL PRIMARY KEY,
    nombre          VARCHAR(50) UNIQUE,
    punto           VARCHAR(255),
    direccion       VARCHAR(255),
    estado          BOOLEAN
);

CREATE TABLE CanalVirtual (
    id              SERIAL PRIMARY KEY,
    canal           VARCHAR(255) NOT NULL,
    estado          BOOLEAN 
);

CREATE TABLE TipoTransaccion (
    id              SERIAL PRIMARY KEY,
    transaccion     INTEGER UNIQUE,
    horario         VARCHAR(15) NOT NULL,
    estado          BOOLEAN 
);

CREATE TABLE Catalogo (
    id              SERIAL PRIMARY KEY,
    tabla           VARCHAR(100) NOT NULL,
    descripcion     VARCHAR(100) NOT NULL,
    codigo          INTEGER,
    valor           VARCHAR(100),
    estado          BOOLEAN 
);

CREATE TABLE Empresa (
    id              SERIAL PRIMARY KEY,
    empresa         VARCHAR(100) NOT NULL,
    codigo_empresa  INTEGER UNIQUE,
    ruc             VARCHAR(13) NOT NULL UNIQUE,
    direccion       VARCHAR(255) NOT NULL,
    forma_pago      VARCHAR(5) NOT NULL,
    cuenta          VARCHAR(10) NOT NULL UNIQUE,
    rubro           VARCHAR(5) NOT NULL UNIQUE,
    estado          BOOLEAN
);

CREATE TABLE AsociarTrxEmpresa (
    id              SERIAL PRIMARY KEY,
    idEmpresa       INTEGER REFERENCES Empresa(id),
    idTransaccion   INTEGER REFERENCES TipoTransaccion(id),
    estado          BOOLEAN 
);

CREATE TABLE AsociarSucursal (
    id              SERIAL PRIMARY KEY,
    idEmpresa       INTEGER REFERENCES Empresa(id),
    idSucursal      INTEGER REFERENCES Sucursal(id),
    estado          BOOLEAN 
);

CREATE TABLE Pedido (
    id              SERIAL PRIMARY KEY,
    codigoPedido    INTEGER,
    fecha           DATE,
    idEmpresa       INTEGER REFERENCES Empresa(id),
    idSucursal      INTEGER REFERENCES Sucursal(id),
    total           NUMERIC(10, 2),
    estado          VARCHAR(20) 
);

CREATE TABLE PedidoProducto (
    id              SERIAL PRIMARY KEY,
    idPedido        INTEGER REFERENCES Pedido(id),
    idProducto      INTEGER REFERENCES Producto(id),
    cantidad        INTEGER,
    estado          BOOLEAN 
);

CREATE TABLE Promocion (
    id              SERIAL PRIMARY KEY,
    promo           VARCHAR(255) NOT NULL,
    vigencia        VARCHAR(255) NOT NULL,
    estado          BOOLEAN 
);

CREATE TABLE ControlRecaudacion (
    id              SERIAL PRIMARY KEY,
    tipoTransaccion INTEGER,
    clase           CHAR(1),
    fecha           DATE,
    hora            VARCHAR(25), 
    usuario         VARCHAR(25),
    rol             VARCHAR(20),
    isCorrecion     BOOLEAN,
    idCorrecion     INTEGER,
    referencia      VARCHAR(20),
    valorEfe        NUMERIC(10, 2),
    valorChq        NUMERIC(10, 2),
    valorDeb        NUMERIC(10, 2),
    cta_banco       VARCHAR(10),
    sucursal        INTEGER,
    causa           INTEGER,
    tipoCta         CHAR(1),
    tipoCanal       VARCHAR(5),
    nombreCliente   VARCHAR(50),
    campoAltUno     VARCHAR(255),
    campoAltDos     VARCHAR(255),
);

CREATE TABLE CuboCanalesMensual (
    id              SERIAL PRIMARY KEY,
    fecha           DATE,
    causa           INTEGER,
    empresa         VARCHAR(255),
    total           NUMERIC(10, 2),
    canal           VARCHAR(5),
    estado          BOOLEAN 
);

