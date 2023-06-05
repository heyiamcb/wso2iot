IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[IDN_OAUTH_CONSUMER_APPS]') AND TYPE IN (N'U'))
  CREATE TABLE IDN_OAUTH_CONSUMER_APPS (
    ID               INTEGER IDENTITY,  
    CONSUMER_KEY     VARCHAR(512),
    CONSUMER_SECRET  VARCHAR(512),
    USERNAME         VARCHAR(255),
    TENANT_ID        INTEGER DEFAULT 0,
    USER_DOMAIN      VARCHAR(50),
    APP_NAME         VARCHAR(255),
    OAUTH_VERSION    VARCHAR(128),
    CALLBACK_URL     VARCHAR(1024),
    GRANT_TYPES      VARCHAR(1024),
    PRIMARY KEY (ID),
    UNIQUE (CONSUMER_KEY)
  );

IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[APM_SUBSCRIBER]') AND TYPE IN (N'U'))
  CREATE TABLE APM_SUBSCRIBER (
    SUBSCRIBER_ID   INTEGER IDENTITY,
    USER_ID         VARCHAR(50)  NOT NULL,
    TENANT_ID       INTEGER      NOT NULL,
    EMAIL_ADDRESS   VARCHAR(256) NULL,
    DATE_SUBSCRIBED DATETIME2(0) NOT NULL,
    PRIMARY KEY (SUBSCRIBER_ID),
    UNIQUE (TENANT_ID, USER_ID)
  );

IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[APM_APPLICATION]') AND TYPE IN (N'U'))
  CREATE TABLE APM_APPLICATION (
    APPLICATION_ID     INTEGER     IDENTITY,
    NAME               VARCHAR(100),
    SUBSCRIBER_ID      INTEGER,
    APPLICATION_TIER   VARCHAR(50) DEFAULT 'Unlimited',
    CALLBACK_URL       VARCHAR(512),
    DESCRIPTION        VARCHAR(512),
    APPLICATION_STATUS VARCHAR(50) DEFAULT 'APPROVED',
    FOREIGN KEY (SUBSCRIBER_ID) REFERENCES APM_SUBSCRIBER (SUBSCRIBER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (APPLICATION_ID),
    UNIQUE ( NAME, SUBSCRIBER_ID)
  );

IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[APM_BUSINESS_OWNER') AND TYPE IN (N'U'))
CREATE TABLE APM_BUSINESS_OWNER(
  OWNER_ID INTEGER  IDENTITY,
  OWNER_NAME VARCHAR(200) NOT NULL,
  OWNER_EMAIL VARCHAR(300) NOT NULL,
  OWNER_DESC VARCHAR(1500),
  OWNER_SITE VARCHAR(200),
  TENANT_ID INTEGER,
  PRIMARY KEY(OWNER_ID),
  UNIQUE (OWNER_NAME,OWNER_EMAIL,TENANT_ID)
);

IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[APM_BUSINESS_OWNER_PROPERTY') AND TYPE IN (N'U'))
CREATE TABLE APM_BUSINESS_OWNER_PROPERTY(
  OWNER_PROP_ID INTEGER IDENTITY,
  OWNER_ID INTEGER NOT NULL,
  NAME VARCHAR(200) NOT NULL,
  VALUE VARCHAR(300) NOT NULL,
  SHOW_IN_STORE BIT NOT NULL,
  PRIMARY KEY(OWNER_PROP_ID),
  FOREIGN KEY(OWNER_ID) REFERENCES APM_BUSINESS_OWNER(OWNER_ID)
);

IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[APM_APP]') AND TYPE IN (N'U'))
  CREATE TABLE APM_APP (
    APP_ID              INTEGER IDENTITY,
    APP_PROVIDER        VARCHAR(256),
    TENANT_ID           INTEGER,
    APP_NAME            VARCHAR(256),
    APP_VERSION         VARCHAR(30),
    CONTEXT             VARCHAR(256),
    TRACKING_CODE       VARCHAR(100),
    VISIBLE_ROLES       VARCHAR(500),
    UUID                VARCHAR(250) NOT NULL,
    SAML2_SSO_ISSUER    VARCHAR(500),
    LOG_OUT_URL         VARCHAR(500),
    APP_ALLOW_ANONYMOUS BIT          NULL,
    APP_ENDPOINT        VARCHAR(500),
    TREAT_AS_SITE       BIT NOT NULL,
    PRIMARY KEY (APP_ID),
    UNIQUE (APP_PROVIDER, APP_NAME, APP_VERSION, TRACKING_CODE, UUID)
);

IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[APM_POLICY_GROUP]') AND TYPE IN (N'U'))
  CREATE TABLE APM_POLICY_GROUP
  (
    POLICY_GRP_ID       INTEGER      IDENTITY,
    NAME                VARCHAR(256),
    AUTH_SCHEME         VARCHAR(50)   NULL,
    THROTTLING_TIER     VARCHAR(512) DEFAULT NULL,
    USER_ROLES          VARCHAR(512) DEFAULT NULL,
    URL_ALLOW_ANONYMOUS BIT          DEFAULT 0,
    DESCRIPTION         VARCHAR(1000) NULL,
    PRIMARY KEY (POLICY_GRP_ID)
  );

IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[APM_POLICY_GROUP_MAPPING]') AND TYPE IN (N'U'))
  CREATE TABLE APM_POLICY_GROUP_MAPPING
  (
    POLICY_GRP_ID INTEGER NOT NULL,
    APP_ID        INTEGER NOT NULL,
    FOREIGN KEY (APP_ID) REFERENCES APM_APP (APP_ID)
      ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (POLICY_GRP_ID) REFERENCES APM_POLICY_GROUP (POLICY_GRP_ID)
      ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (POLICY_GRP_ID, APP_ID)
  );

IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[APM_APP_URL_MAPPING]') AND TYPE IN (N'U'))
  CREATE TABLE APM_APP_URL_MAPPING (
    URL_MAPPING_ID  INTEGER IDENTITY,
    APP_ID          INTEGER      NOT NULL,
    HTTP_METHOD     VARCHAR(20)  NULL,
    URL_PATTERN     VARCHAR(512) NULL,
    SKIP_THROTTLING BIT     DEFAULT 0,
    POLICY_GRP_ID   INTEGER      NULL,
    FOREIGN KEY (APP_ID) REFERENCES APM_APP (APP_ID)
      ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (POLICY_GRP_ID) REFERENCES APM_POLICY_GROUP (POLICY_GRP_ID),
    PRIMARY KEY (URL_MAPPING_ID)
);

IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[APM_ENTITLEMENT_POLICY_PARTIAL]') AND TYPE IN (N'U'))
  CREATE TABLE APM_ENTITLEMENT_POLICY_PARTIAL (
    ENTITLEMENT_POLICY_PARTIAL_ID INTEGER       IDENTITY,
    NAME                          VARCHAR(256)  DEFAULT NULL,
    CONTENT                       VARCHAR(2048) DEFAULT NULL,
    SHARED                        BIT           DEFAULT 0,
    AUTHOR                        VARCHAR(256)  DEFAULT NULL,
    DESCRIPTION                   VARCHAR(1000) NULL,
    TENANT_ID                     INTEGER       NULL,
    PRIMARY KEY (ENTITLEMENT_POLICY_PARTIAL_ID)
 );

IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[APM_POLICY_GRP_PARTIAL_MAPPING]') AND TYPE IN (N'U'))
  CREATE TABLE APM_POLICY_GRP_PARTIAL_MAPPING (
    POLICY_GRP_ID     INTEGER NOT NULL,
    POLICY_PARTIAL_ID INTEGER NOT NULL,
    EFFECT            VARCHAR(50),
    POLICY_ID         VARCHAR(100) DEFAULT NULL,
    FOREIGN KEY (POLICY_GRP_ID) REFERENCES APM_POLICY_GROUP (POLICY_GRP_ID)
      ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (POLICY_PARTIAL_ID) REFERENCES APM_ENTITLEMENT_POLICY_PARTIAL (ENTITLEMENT_POLICY_PARTIAL_ID),
    PRIMARY KEY (POLICY_GRP_ID, POLICY_PARTIAL_ID)
  );

IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[APM_SUBSCRIPTION]') AND TYPE IN (N'U'))
  CREATE TABLE APM_SUBSCRIPTION (
    SUBSCRIPTION_ID   INTEGER IDENTITY,
    SUBSCRIPTION_TYPE VARCHAR(50),
    TIER_ID           VARCHAR(50),
    APP_ID            INTEGER,
    LAST_ACCESSED     DATETIME2(0) NULL,
    APPLICATION_ID    INTEGER,
    SUB_STATUS        VARCHAR(50),
    TRUSTED_IDP       VARCHAR(255) NULL,
    SUBSCRIPTION_TIME DATETIME2(0) NOT NULL,
    FOREIGN KEY (APPLICATION_ID) REFERENCES APM_APPLICATION (APPLICATION_ID)
      ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (APP_ID) REFERENCES APM_APP(APP_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (SUBSCRIPTION_ID),
    UNIQUE (APP_ID, APPLICATION_ID, SUBSCRIPTION_TYPE)
);

IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[APM_APP_LC_EVENT]') AND TYPE IN (N'U'))
  CREATE TABLE APM_APP_LC_EVENT (
    EVENT_ID       INTEGER IDENTITY,
    APP_ID         INTEGER      NOT NULL,
    PREVIOUS_STATE VARCHAR(50),
    NEW_STATE      VARCHAR(50)  NOT NULL,
    USER_ID        VARCHAR(50)  NOT NULL,
    TENANT_ID      INTEGER      NOT NULL,
    EVENT_DATE     DATETIME2(0) NOT NULL,
    FOREIGN KEY (APP_ID) REFERENCES APM_APP (APP_ID)
      ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (EVENT_ID)
);

IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[APM_TIER_PERMISSIONS]') AND TYPE IN (N'U'))
  CREATE TABLE APM_TIER_PERMISSIONS (
    TIER_PERMISSIONS_ID INTEGER IDENTITY,
    TIER                VARCHAR(50)  NOT NULL,
    PERMISSIONS_TYPE    VARCHAR(50)  NOT NULL,
    ROLES               VARCHAR(512) NOT NULL,
    TENANT_ID           INTEGER      NOT NULL,
    PRIMARY KEY (TIER_PERMISSIONS_ID)
  );

IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[APM_WORKFLOWS]') AND TYPE IN (N'U'))
  CREATE TABLE APM_WORKFLOWS (
    WF_ID                 INTEGER IDENTITY,
    WF_REFERENCE          VARCHAR(255) NOT NULL,
    WF_TYPE               VARCHAR(255) NOT NULL,
    WF_STATUS             VARCHAR(255) NOT NULL,
    WF_CREATED_TIME       DATETIME2(0),
    WF_UPDATED_TIME       DATETIME2(0),
    WF_STATUS_DESC        VARCHAR(1000),
    TENANT_ID             INTEGER,
    TENANT_DOMAIN         VARCHAR(255),
    WF_EXTERNAL_REFERENCE VARCHAR(255) NOT NULL,
    PRIMARY KEY (WF_ID),
    UNIQUE (WF_EXTERNAL_REFERENCE)
 );

IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[APM_API_CONSUMER_APPS]') AND TYPE IN (N'U'))
  CREATE TABLE APM_API_CONSUMER_APPS (
    ID                  INTEGER IDENTITY,
    SAML2_SSO_ISSUER    VARCHAR(500),
    APP_CONSUMER_KEY    VARCHAR(512),
    API_TOKEN_ENDPOINT  VARCHAR(1024),
    API_CONSUMER_KEY    VARCHAR(512),
    API_CONSUMER_SECRET VARCHAR(512),
    APP_NAME            VARCHAR(512),
    PRIMARY KEY (ID, APP_CONSUMER_KEY),
    FOREIGN KEY (APP_CONSUMER_KEY) REFERENCES IDN_OAUTH_CONSUMER_APPS (CONSUMER_KEY)
      ON UPDATE CASCADE ON DELETE CASCADE);

IF NOT EXISTS(SELECT * FROM sys.indexes WHERE name = 'IDX_APM_APP_UUID' AND object_id = OBJECT_ID('APM_APP'))
  CREATE INDEX IDX_APM_APP_UUID ON APM_APP (UUID);

IF NOT EXISTS(SELECT * FROM sys.indexes WHERE name = 'IDX_APM_SUBSCRIBER_USER_ID' AND object_id = OBJECT_ID('APM_SUBSCRIBER'))
  CREATE INDEX IDX_APM_SUBSCRIBER_USER_ID ON APM_SUBSCRIBER (USER_ID);

IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[APM_APP_HITS]') AND TYPE IN (N'U'))
  CREATE TABLE APM_APP_HITS (
    UUID      VARCHAR(250) NOT NULL,
    APP_NAME  VARCHAR(200) NOT NULL,
    VERSION   VARCHAR(50),
    CONTEXT   VARCHAR(256) NOT NULL,
    USER_ID   VARCHAR(50)  NOT NULL,
    TENANT_ID INTEGER,
    HIT_TIME  DATETIME2(0) NOT NULL,
    PRIMARY KEY (UUID, USER_ID, TENANT_ID, HIT_TIME)
  );

IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[APM_APP_JAVA_POLICY]') AND TYPE IN (N'U'))
  CREATE TABLE APM_APP_JAVA_POLICY
  (
    JAVA_POLICY_ID       INTEGER IDENTITY,
    DISPLAY_NAME         VARCHAR(100) NOT NULL,
    FULL_QUALIFI_NAME    VARCHAR(256) NOT NULL,
    DESCRIPTION          VARCHAR(2500),
    DISPLAY_ORDER_SEQ_NO INTEGER      NOT NULL,
    IS_MANDATORY         BIT     DEFAULT 0,
    POLICY_PROPERTIES    VARCHAR(512) NULL,
    IS_GLOBAL            BIT     DEFAULT 1,
    PRIMARY KEY (JAVA_POLICY_ID),
    UNIQUE (FULL_QUALIFI_NAME, DISPLAY_ORDER_SEQ_NO)
  );

IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[APM_APP_JAVA_POLICY_MAPPING]') AND TYPE IN (N'U'))
  CREATE TABLE APM_APP_JAVA_POLICY_MAPPING
  (
    JAVA_POLICY_ID INTEGER NOT NULL,
    APP_ID         INTEGER NOT NULL,
    PRIMARY KEY (JAVA_POLICY_ID, APP_ID),
    FOREIGN KEY (JAVA_POLICY_ID) REFERENCES APM_APP_JAVA_POLICY (JAVA_POLICY_ID)
      ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (APP_ID) REFERENCES APM_APP (APP_ID)
      ON UPDATE CASCADE ON DELETE CASCADE
  );

IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[APM_EXTERNAL_STORES]') AND TYPE IN (N'U'))
  CREATE TABLE APM_EXTERNAL_STORES (
    APP_STORE_ID INTEGER IDENTITY,
    APP_ID       INTEGER,
    STORE_ID     VARCHAR(255) NOT NULL,
    FOREIGN KEY (APP_ID) REFERENCES APM_APP (APP_ID)
      ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (APP_STORE_ID)
  );

IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[APM_APP_DEFAULT_VERSION]') AND TYPE IN (N'U'))
CREATE TABLE APM_APP_DEFAULT_VERSION(
    DEFAULT_VERSION_ID INTEGER IDENTITY,
    APP_NAME VARCHAR(256),
    APP_PROVIDER VARCHAR(256),
    DEFAULT_APP_VERSION VARCHAR(30),
    PUBLISHED_DEFAULT_APP_VERSION VARCHAR(30),
    TENANT_ID INTEGER,
PRIMARY KEY(DEFAULT_VERSION_ID)
);

IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[APM_FAVOURITE_APPS]') AND TYPE IN (N'U'))
CREATE TABLE APM_FAVOURITE_APPS (
   ID INTEGER  IDENTITY,
   USER_ID VARCHAR(50) NOT NULL,
   TENANT_ID INTEGER NOT NULL,
   APP_ID INTEGER NOT NULL,
   CREATED_TIME DATETIME2(0) NOT NULL,
   PRIMARY KEY (ID),
   FOREIGN KEY(APP_ID) REFERENCES APM_APP(APP_ID) ON DELETE CASCADE,
   UNIQUE (TENANT_ID,USER_ID,APP_ID)
);

IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[APM_STORE_FAVOURITE_PAGE]') AND TYPE IN (N'U'))
CREATE TABLE APM_STORE_FAVOURITE_PAGE (
   ID INTEGER IDENTITY,
   USER_ID VARCHAR(50) NOT NULL,
   TENANT_ID_OF_USER INTEGER NOT NULL,
   TENANT_ID_OF_STORE INTEGER NOT NULL,
   PRIMARY KEY (ID)
);

IF NOT EXISTS(SELECT *
              FROM SYS.OBJECTS
              WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[APM_ONE_TIME_DOWNLOAD_LINK]') AND TYPE IN (N'U'))
CREATE TABLE APM_ONE_TIME_DOWNLOAD_LINK(
     ID INTEGER IDENTITY,
     BINARY_FILE varchar(500) NOT NULL,
     UUID varchar(500) NOT NULL,
     IS_DOWNLOADED BIT DEFAULT 0,
     USERNAME VARCHAR(255),
     TENANT_ID INTEGER,
     TENANT_DOMAIN VARCHAR(255),
     CREATED_TIME  DATETIME2(0) NOT NULL,
     PRIMARY KEY (ID)
);

INSERT INTO APM_APP_JAVA_POLICY (DISPLAY_NAME, FULL_QUALIFI_NAME, DESCRIPTION, DISPLAY_ORDER_SEQ_NO, IS_MANDATORY, IS_GLOBAL)
VALUES
  ('Reverse Proxy Handler', 'org.wso2.carbon.appmgt.gateway.handlers.proxy.ReverseProxyHandler', '', 1, 1, 1);

INSERT INTO APM_APP_JAVA_POLICY (DISPLAY_NAME, FULL_QUALIFI_NAME, DESCRIPTION, DISPLAY_ORDER_SEQ_NO, IS_MANDATORY, IS_GLOBAL)
VALUES
  ('SAML2 Authentication Handler', 'org.wso2.carbon.appmgt.gateway.handlers.security.saml2.SAML2AuthenticationHandler',
   '', 2, 1, 1);

INSERT INTO APM_APP_JAVA_POLICY(DISPLAY_NAME, FULL_QUALIFI_NAME, DESCRIPTION, DISPLAY_ORDER_SEQ_NO,IS_MANDATORY,IS_GLOBAL)
VALUES ('Subscription Handler', 'org.wso2.carbon.appmgt.gateway.handlers.subscription.SubscriptionsHandler', '', 3,1,1);

INSERT INTO APM_APP_JAVA_POLICY(DISPLAY_NAME, FULL_QUALIFI_NAME, DESCRIPTION, DISPLAY_ORDER_SEQ_NO,IS_MANDATORY,IS_GLOBAL)
VALUES ('Authorization Handler', 'org.wso2.carbon.appmgt.gateway.handlers.security.entitlement.AuthorizationHandler','',4,1,1);

INSERT INTO APM_APP_JAVA_POLICY (DISPLAY_NAME, FULL_QUALIFI_NAME, DESCRIPTION, DISPLAY_ORDER_SEQ_NO, IS_MANDATORY, IS_GLOBAL)
VALUES ('Entitlement Handler', 'org.wso2.carbon.appmgt.gateway.handlers.security.entitlement.EntitlementHandler', '', 5,
        1, 1);

INSERT INTO APM_APP_JAVA_POLICY (DISPLAY_NAME, FULL_QUALIFI_NAME, DESCRIPTION, DISPLAY_ORDER_SEQ_NO, IS_MANDATORY, POLICY_PROPERTIES, IS_GLOBAL)
VALUES ('API Throttle Handler', 'org.wso2.carbon.appmgt.gateway.handlers.throttling.APIThrottleHandler', '', 6, 1,
        '{ "id": "A",  "policyKey": "gov:/appmgt/applicationdata/tiers.xml"}', 1);

INSERT INTO APM_APP_JAVA_POLICY (DISPLAY_NAME, FULL_QUALIFI_NAME, DESCRIPTION, DISPLAY_ORDER_SEQ_NO, IS_MANDATORY, IS_GLOBAL)
VALUES ('Publish Statistics:', 'org.wso2.carbon.appmgt.usage.publisher.APPMgtUsageHandler', '', 7, 0, 1);


CREATE INDEX IDX_SUB_APP_ID ON APM_SUBSCRIPTION (APPLICATION_ID, SUBSCRIPTION_ID);
