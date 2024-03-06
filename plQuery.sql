
set global log_bin_trust_function_creators=1;

delimiter #
CREATE PROCEDURE unavailable_artworks()
BEGIN
    SELECT *
    FROM artworks
    WHERE available = FALSE;
END#
delimiter ;


delimiter #
CREATE PROCEDURE available_artworks()
BEGIN
    SELECT *
    FROM artworks
    WHERE available = TRUE;
END#
delimiter ;


delimiter #
create trigger at_insert
after insert on transactions
for each row
begin
declare x decimal(10,2);
set x = (select price from artworks where artwork_id=new.artwork_id);
update ngo
set donation = donation + x
where ngo_id=new.ngo_id;

update artworks 
set available=false
where artwork_id=new.artwork_id;

end#
delimiter ;


delimiter #
create procedure add_transaction(cid int, awid int, nid int)
begin

	if iscustomer_id_present(cid) and isartwork_id_present(awid) and isngo_id_present(nid) then
		insert into transactions(customer_id, ngo_id, artwork_id, transaction_date)
		values(cid,nid,awid, curdate());

	elseif not iscustomer_id_present(cid) then
		select 'customer id is not valid';

	elseif not isartwork_id_present(awid) then
		select 'artwork is not available';

	elseif not isngo_id_present(nid) then
		select 'ngo id is not valid';
	end if;
end#
delimiter ;


delimiter #
create function iscustomer_id_present(cust_id INT) 
RETURNS BOOLEAN
BEGIN
    DECLARE result BOOLEAN;

    IF  cust_id IN(SELECT customer_id FROM customers) THEN
        SET result = TRUE;
    ELSE
        SET result = FALSE;
    END IF;

    RETURN result;
END#
delimiter ;



delimiter #
create function isngo_id_present(ngoId INT) 
RETURNS BOOLEAN
BEGIN
    DECLARE result BOOLEAN;

    IF  ngoId IN(SELECT ngo_id FROM ngo) THEN
        SET result = TRUE;
    ELSE
        SET result = FALSE;
    END IF;

    RETURN result;
END#
delimiter ;



delimiter #
create function isartwork_id_present(art_id INT) 
RETURNS BOOLEAN
BEGIN
    DECLARE result BOOLEAN;

    IF  art_id IN(SELECT artwork_id FROM artworks WHERE available=1) THEN
        SET result = TRUE;
    ELSE
        SET result = FALSE;
    END IF;

    RETURN result;
END#
delimiter ;
