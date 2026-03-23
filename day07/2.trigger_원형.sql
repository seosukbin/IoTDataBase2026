-- 트리거 원본

delimiter $$

CREATE TRIGGER trg_afterinsertbook
 AFTER INSERT ON Book FOR EACH ROW  
 BEGIN 
	 INSERT INTO Book_log(bookid_l,bookname_l,publisher_l,price_l,dml_type)
	 -- new.컬럼명은 새로 들어온 데이터, old.컬럼명은 이전값(update,delete)
	 
	 VALUES (NEW.bookid, NEW.bookname, NEW.publisher, NEW.price,'INSERT');
 END;
$$
DELIMITER $$;

 
 -- ALT + X로 전체 실행

DELIMITER $$

CREATE TRIGGER trg_AfterUpdateBook
AFTER UPDATE ON Book
FOR EACH ROW
BEGIN
    INSERT INTO Book_log
        (bookid_l, bookname_l, publisher_l, price_l, dml_type)
    VALUES
        (NEW.bookid, NEW.bookname, NEW.publisher, NEW.price, 'UPDATE');
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_AfterDeleteBook
AFTER DELETE ON Book
FOR EACH ROW
BEGIN
    INSERT INTO Book_log
        (bookid_l, bookname_l, publisher_l, price_l, dml_type)
    VALUES
        (OLD.bookid, OLD.bookname, OLD.publisher, OLD.price, 'DELETE');
END
$$
DELIMITER $$;

