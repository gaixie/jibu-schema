-- *****************************************************
-- 创建与业务无关的基础表及索引

-- ------------------------------------------------------
CREATE TABLE schema_changes (
    id                     serial NOT NULL PRIMARY KEY,
    major                  smallint NOT NULL,
    minor                  smallint NOT NULL,
    revision               smallint NOT NULL,
    hash                   varchar(64) NOT NULL UNIQUE,
    applied_ts             timestamp with time zone NOT NULL DEFAULT now(),
    UNIQUE ( major,minor,revision )
);

-- ------------------------------------------------------
CREATE TABLE userbase (
    id                     serial NOT NULL PRIMARY KEY,
    username               varchar(64) NOT NULL UNIQUE,
    password               varchar(64) NOT NULL,
    fullname               varchar(64) NOT NULL,
    type                   smallint DEFAULT 1 NOT NULL,
    emailaddress           varchar(64) NOT NULL UNIQUE,
    registered_ts          timestamp with time zone NOT NULL DEFAULT now(),
    invited_by             integer NOT NULL REFERENCES userbase (id),
    enabled                boolean DEFAULT true NOT NULL
);

-- ------------------------------------------------------
CREATE TABLE tokens (
    id                     serial NOT NULL PRIMARY KEY,
    value                  varchar(64) NOT NULL UNIQUE,
    type                   varchar(16) NOT NULL,
    expiration_ts          timestamp with time zone NOT NULL,
    send_to                varchar(64) NOT NULL,
    created_by             integer NOT NULL REFERENCES userbase (id)
);
