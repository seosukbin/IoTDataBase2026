CREATE USER 'hugo76'@'%' IDENTIFIED BY 'my123456';

ALTER USER 'hugo76'@'%' IDENTIFIED BY 'MY123456';

GRANT ALL PRIVILEGES world. * TO 'hugo76'@'%';
GRANT ALL PRIVILEGES sakila. * TO 'hugo76'@'%';
GRANT ALL PRIVILEGES madangdb. * TO 'hugo76'@'%';

-- 권한 해제

REVOKE ALL PRIVILEGES ON madangdb. *FROM 'hugo76'@'%';