-- -----------------------------------------------------------------------------
-- MD5 ("111111") = 96e79218965eb72c92a549dd5a330112
-- 注册邀请顺序：Manager --> Sponsor --> Register
insert into userbase(username,password,fullname,type,emailaddress,invited_by) values ('qq','96e79218965eb72c92a549dd5a330112','Manager', 4,'nodto@qq.com',currval('userbase_id_seq'));
insert into userbase(username,password,fullname,type,emailaddress,invited_by) values ('sina','96e79218965eb72c92a549dd5a330112','Sponsor', 2,'nodto@sina.com',(select id from userbase where username = 'qq'));
insert into userbase(username,password,fullname,type,emailaddress,invited_by) values ('outlook','96e79218965eb72c92a549dd5a330112','Register',1,'nodto@outlook.com',(select id from userbase where username = 'sina'));

-- -----------------------------------------------------------------------------
-- MD5 ("password") = 5f4dcc3b5aa765d61d8327deb882cf99
-- MD5 ("register") = 9de4a97425678c5b1288aa70c1669a64
-- MD5 ("signin")   = cc0256df40cbc924af2b31aeccb869b0
insert into tokens(value,type,expiration_ts,send_to,created_by) values ('5f4dcc3b5aa765d61d8327deb882cf99','password',now() + interval '1 day' ,'nodto@outlook.com',(select id from userbase where username = 'outlook'));
insert into tokens(value,type,expiration_ts,send_to,created_by) values ('9de4a97425678c5b1288aa70c1669a64','register',now() + interval '7 day' ,'nodto@test',(select id from userbase where username = 'sina'));
insert into tokens(value,type,expiration_ts,send_to,created_by) values ('cc0256df40cbc924af2b31aeccb869b0','signin'  ,now() + interval '14 day','nodto@qq.com',(select id from userbase where username = 'qq'));
