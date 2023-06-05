CREATE TABLE DM_DEVICE_CERTIFICATE (
  ID                    NUMBER(10) NOT NULL,
  SERIAL_NUMBER         VARCHAR2(500) DEFAULT NULL,
  CERTIFICATE           BLOB DEFAULT NULL,
  TENANT_ID NUMBER(10) DEFAULT 0,
  USERNAME  VARCHAR2(500) DEFAULT NULL,
  PRIMARY KEY (ID)
)
/

-- Generate ID using sequence and trigger
CREATE SEQUENCE DM_DEVICE_CERTIFICATE_seq START WITH 1 INCREMENT BY 1 NOCACHE
/
CREATE OR REPLACE TRIGGER DM_DEVICE_CERTIFICATE_seq_tr
BEFORE INSERT ON DM_DEVICE_CERTIFICATE FOR EACH ROW
WHEN (NEW.ID IS NULL)
  BEGIN
    SELECT DM_DEVICE_CERTIFICATE_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
  END;
/