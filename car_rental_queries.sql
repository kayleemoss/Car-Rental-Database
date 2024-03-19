SELECT make as 'Make', model as 'Model', vehicle_year as 
'Year', color as 'Color', branch_ID as 'Location'
FROM vehicle
WHERE vehicle_status = 'Available';

SELECT make as 'Make', model as 'Model', vehicle_year as 
'Year', color as 'Color', branch_ID as 'Location'
FROM vehicle
WHERE vehicle_status = 'Booked';

SELECT customer.customer_fname as 'First Name', 
customer.customer_lname as 'Last Name', 
reservation.reservation_ID as 'Reservation ID', 
reservation.VIN as 'Vehicle ID'
FROM reservation
INNER JOIN customer ON reservation.license_no = 
customer.License_No
WHERE reservation_status = 'Completed';

SELECT customer.customer_fname as 'First Name', 
customer.customer_lname as 'Last Name', 
reservation.reservation_ID as 'Reservation ID', 
reservation.VIN as 'Vehicle ID'
FROM reservation
INNER JOIN customer ON reservation.license_no = 
customer.License_No
WHERE reservation_status = 'Reserved';

SELECT customer.customer_fname as 'First Name', 
customer.customer_lname as 'Last Name', 
reservation.reservation_ID as 'Reservation ID', 
reservation.VIN as 'Vehicle ID'
FROM reservation
INNER JOIN customer ON reservation.license_no = 
customer.License_No
WHERE customer.customer_fname = 'Michael' AND 
customer.customer_lname = 'Scott';

SELECT reservation.reservation_ID, product_ID, 
reservation.VIN
FROM reservation
INNER JOIN add_onto on reservation.reservation_ID = 
add_onto.reservation_ID;

SELECT vehicle.VIN as 'Vehichle ID', vehicle.vehicle_type 
as 'Vehicle Type', vehicle.vehicle_status as 'Status', 
vehicle.branch_ID as 'Branch'
FROM vehicle
ORDER BY vehicle_type;

SELECT vehicle.VIN as 'Vehichle ID', vehicle.vehicle_type 
as 'Vehicle Type', vehicle.vehicle_status as 'Status', 
vehicle.branch_ID as 'Branch'
FROM vehicle
WHERE vehicle_type = 'Luxury';

SELECT vehicle.vehicle_type, COUNT(*) as count FROM vehicle 
GROUP BY vehicle_type;

SELECT vehicle.vehicle_type, COUNT(vehicle.vehicle_status) 
as 'Number of Rentals' 
FROM vehicle
WHERE vehicle_status = 'Booked' 
GROUP BY vehicle_type;

SELECT rental_insurance.insurance_type as 'Insurance Type', 
rental_insurance.insurance_price as 'Insurance Price',
 rental_insurance.vehicle_type as 'Vehicle Type',
 insurance.bodily_coverage as 'Bodily Coverage',
 insurance.medical_coverage as 'Medical Coverage',
 insurance.collision_coverage as 'Collision Coverage'
FROM rental_insurance
JOIN insurance ON insurance.insurance_type = 
rental_insurance.insurance_type;

SELECT price_per_day, vehicle_type
From vehicle_type
ORDER BY price_per_day;


