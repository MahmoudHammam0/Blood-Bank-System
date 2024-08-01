CREATE DATABASE IF NOT EXISTS cbb_db;
CREATE USER IF NOT EXISTS 'cbb_user'@'localhost' IDENTIFIED BY 'cbb_pwd';
GRANT ALL PRIVILEGES ON cbb_db.* TO 'cbb_user'@'localhost';
GRANT SELECT ON performance_schema.* TO 'cbb_user'@'localhost';
