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
