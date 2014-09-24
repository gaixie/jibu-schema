-- *****************************************************
-- Create comments

-- ------------------------------------------------------
COMMENT ON TABLE schema_changes IS 'Schema 版本变动';
COMMENT ON COLUMN schema_changes.id IS 'AUTO INCREMENT';
COMMENT ON COLUMN schema_changes.major IS '主版本号';
COMMENT ON COLUMN schema_changes.minor IS '次版本号';
COMMENT ON COLUMN schema_changes.revision IS '修订版本号';
COMMENT ON COLUMN schema_changes.hash IS 'Git 中 本次 commit 的 hash 码';
COMMENT ON COLUMN schema_changes.applied_ts IS 'Schema 修改时间';
