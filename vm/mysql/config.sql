create database scm;
drop user root@localhost;
flush privileges;
create user root@localhost identified by "root";
drop user scm@localhost;
flush privileges;
create user 'scm'@'localhost' identified by 'password';
grant all privileges on *.* to 'scm'@localhost;
