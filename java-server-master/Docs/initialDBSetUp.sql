DROP TABLE STAFF;
DROP TABLE CLIENTES;
DROP TABLE COMPANIAS;
DROP TABLE FUNCIONES;

CREATE TABLE STAFF
(
  ID_MIEMBRO NUMBER CONSTRAINT STAFF_ID_NN NOT NULL,
  DOC_ID_MIEMBRO VARCHAR2(255 BYTE) CONSTRAINT STAFF_DOC_ID_NN NOT NULL,
  NOMBRE_MIEMBRO VARCHAR2(255 BYTE) CONSTRAINT STAFF_NOMBRE_NN NOT NULL,
  PASSWORD_MIEMBRO VARCHAR2(255 BYTE) CONSTRAINT STAFF_PASSWORD_NN NOT NULL,
  EMAIL_MIEMBRO VARCHAR2(255 BYTE),
  ROL_MIEMBRO VARCHAR2(255 BYTE) CONSTRAINT STAFF_ROL_NN NOT NULL,
  CONSTRAINT STAFF_PK PRIMARY KEY (ID_MIEMBRO),
  CONSTRAINT STAFF_DOC_ID_UN UNIQUE (DOC_ID_MIEMBRO),
  CONSTRAINT STAFF_ROL_IN CHECK (ROL_MIEMBRO IN ('administrador', 'operario'))
);

CREATE TABLE CLIENTES
(
  ID_CLIENTE NUMBER CONSTRAINT CLIENTES_ID_NN NOT NULL,
  DOC_ID_CLIENTE VARCHAR2(255 BYTE) CONSTRAINT CLIENTES_DOC_ID_NN NOT NULL,
  NOMBRE_CLIENTE VARCHAR2(255 BYTE) CONSTRAINT CLIENTES_NOMBRE_NN NOT NULL,
  PASSWORD_CLIENTE VARCHAR2(255 BYTE) CONSTRAINT CLIENTES_PASSWORD_NN NOT NULL,
  EMAIL_CLIENTE VARCHAR2(255 BYTE) CONSTRAINT CLIENTES_EMAIL_NN NOT NULL,
  ADDRESS_CLIENTE VARCHAR2(255 BYTE),
  CONSTRAINT CLIENTES_PK PRIMARY KEY (ID_CLIENTE),
  CONSTRAINT CLIENTES_DOC_ID_UN UNIQUE (DOC_ID_CLIENTE)
);

CREATE TABLE COMPANIAS
(
  ID_COMPANIA NUMBER CONSTRAINT COMPANIAS_ID_NN NOT NULL,
  NIT_COMPANIA VARCHAR2(255 BYTE) CONSTRAINT COMPANIAS_NIT_NN NOT NULL,
  NOMBRE_COMPANIA VARCHAR2(255 BYTE) CONSTRAINT COMPANIAS_NOMBRE_NN NOT NULL,
  REPRESENTANTE_COMPANIA VARCHAR2(255 BYTE) CONSTRAINT COMPANIA_REPRESENTANTE_NN NOT NULL,
  PAIS_COMPANIA VARCHAR2(255 BYTE) CONSTRAINT COMPANIAS_PAIS_NN NOT NULL,
  WEB_COMPANIA VARCHAR2(255 BYTE),
  PASSWORD_COMPANIA VARCHAR2(255 BYTE) CONSTRAINT COMPANIAS_PASSWORD_NN NOT NULL,
  LLEGADA_COMPANIA DATE CONSTRAINT COMPANIAS_LLEGADA_NN NOT NULL,
  SALIDA_COMPANIA DATE CONSTRAINT COMPANIAS_SALIDA_NN NOT NULL,
  CONSTRAINT COMPANIAS_PK PRIMARY KEY (ID_COMPANIA),
  CONSTRAINT COMPANIAS_NIT_UN UNIQUE (NIT_COMPANIA),
  CONSTRAINT COMPANIAS_SALIDA_CK CHECK (SALIDA_COMPANIA >= LLEGADA_COMPANIA)
);



CREATE TABLE FUNCIONES 
(
  ID NUMBER CONSTRAINT FUNCIONES_ID_NN NOT NULL, 
  ID_ESPECTACULO NUMBER CONSTRAINT FUNCIONES_ID_ESPECTACULO_NN NOT NULL,
  DIA_REALIZACION DATE CONSTRAINT FUNCIONES_DATE_NN NOT NULL, 
  CONSTRAINT FUNCIONES_PK PRIMARY KEY (ID, ID_ESPECTACULO)
  USING INDEX (CREATE UNIQUE INDEX TABLE1_PK ON FUNCIONES (ID ASC)) ENABLE 
);

CREATE OR REPLACE TRIGGER COMPANIAS_LLEGADA_CK
  BEFORE INSERT OR UPDATE ON COMPANIAS
  FOR EACH ROW
BEGIN
  IF(:NEW.LLEGADA_COMPANIA >= SYSDATE)
  THEN
    RAISE_APPLICATION_ERROR(-20001, 'Date LLEGADA_COMPANIA must be earlier than or equal to the current date.');
  END IF;
END;

COMMIT;