-- -----------------------------------------------------------------------------
-- MD5 ("111111") = 96e79218965eb72c92a549dd5a330112
-- 注册邀请顺序：Manager --> Sponsor --> Register
insert into userbase(username,password,fullname,type,emailaddress,invited_by) values ('test1@gaixie.org','96e79218965eb72c92a549dd5a330112','Manager', 4,'test1@gaixie.org',currval('userbase_id_seq'));
insert into userbase(username,password,fullname,type,emailaddress,invited_by) values ('test2@gaixie.org','96e79218965eb72c92a549dd5a330112','Sponsor', 2,'test2@gaixie.org',(select id from userbase where username = 'test1@gaixie.org'));
insert into userbase(username,password,fullname,type,emailaddress,invited_by) values ('test3@gaixie.org','96e79218965eb72c92a549dd5a330112','Register',1,'test3@gaixie.org',(select id from userbase where username = 'test2@gaixie.org'));

-- -----------------------------------------------------------------------------
-- MD5 ("password") = 5f4dcc3b5aa765d61d8327deb882cf99
-- MD5 ("register") = 9de4a97425678c5b1288aa70c1669a64
insert into tokens(value,type,expiration_ts,send_to,created_by) values ('5f4dcc3b5aa765d61d8327deb882cf99','password',now() + interval '1 day','test3@gaixie.org',(select id from userbase where username = 'test3@gaixie.org'));
insert into tokens(value,type,expiration_ts,send_to,created_by) values ('9de4a97425678c5b1288aa70c1669a64','register',now() + interval '7 day','test5@gaixie.org',(select id from userbase where username = 'test2@gaixie.org'));
