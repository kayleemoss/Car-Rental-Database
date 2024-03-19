DELIMITER //
CREATE TRIGGER UpdateVehicle
AFTER UPDATE ON Reservation
FOR EACH ROW
BEGIN
IF NEW.reservation_status = 'Completed'
THEN UPDATE `Vehicle` set
`vehicle_status` = 'Available';
END IF;
END//