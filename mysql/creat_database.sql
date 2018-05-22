CREATE DATABASE IF NOT EXISTS `demodb` DEFAULT CHARACTER SET gbk COLLATE gbk_chinese_ci;
grant usage,select on `demodb`.* to 'demodbcxwh'@'%' identified by 'demodbcxwh';
GRANT ALL PRIVILEGES on `demodb`.* to 'demodbadmin'@'%' identified by 'demodbadmin';
grant usage,select,insert,update,delete on `demodb`.* to 'demodbuser'@'%' identified by 'demodbadmin';