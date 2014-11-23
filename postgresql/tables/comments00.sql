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

-- ------------------------------------------------------
COMMENT ON TABLE userbase IS '用户';
COMMENT ON COLUMN userbase.id IS 'AUTO INCREMENT';
COMMENT ON COLUMN userbase.username IS '用于登录的用户名';
COMMENT ON COLUMN userbase.password IS '用于登录的用户密码';
COMMENT ON COLUMN userbase.fullname IS '用于显示的全名，不设置默认为用户名';
COMMENT ON COLUMN userbase.type IS '用户的类型，1: 注册用户，2: 高级用户，4: 管理员。';
COMMENT ON COLUMN userbase.emailaddress IS '用户的电子邮件地址';
COMMENT ON COLUMN userbase.registered_ts IS '用户注册时间';
COMMENT ON COLUMN userbase.invited_by IS '注册用户的邀请用户';
COMMENT ON COLUMN userbase.enabled IS '用户的状态, TRUE 有效, FALSE 无效, 禁止登录';

-- ------------------------------------------------------
COMMENT ON TABLE tokens IS '令牌';
COMMENT ON COLUMN tokens.id IS 'AUTO INCREMENT';
COMMENT ON COLUMN tokens.value IS '令牌值，用于通过系统认证';
COMMENT ON COLUMN tokens.type IS '令牌类型，如 password 表示该令牌只用于密码找回';
COMMENT ON COLUMN tokens.expiration_ts IS '令牌的过期时间';
COMMENT ON COLUMN tokens.send_to IS '令牌被发送到哪个邮箱，如密码找回，就发送到创建令牌的用户自己的邮箱。';
COMMENT ON COLUMN tokens.created_by IS '创建此令牌的用户';
