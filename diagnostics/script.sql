--diagnostics

use dentist;

--reword pro_supply
select	pro_name 'Procedure',
		supply_name 'Supply'
	from pro_supply
	join supply on(supply_id = ps_supply_id)
	join pro on(pro_id = ps_pro_id);

/* first statment for denormalization
select	patient_id 'Patient ID',
		patient_first 'First',
		patient_last 'Last',
		patient_address 'Address',
		patient_city 'City',
		patient_state 'State',
		patient_zip 'Zip',
		patient_phone 'Phone',
		patient_ssn 'SSN',
		patient_dob 'DOB',
		patient_gender 'Gender',
		visit_id 'Visit ID',
		visit_date 'Visit Date',
		pro_name 'Procedure',
		pro_charge 'Charge',
		supply_name 'Supply Used'
	from patient, visit, pro_supply
	join supply on(supply_id = ps_supply_id)
	join pro on(pro_id = ps_pro_id)
	where	patient_id = visit_patient_id and
			pro_id = visit_pro_id;
*/

--denormalization statement, should yield 27 rows
select *
	from patient --start patient
	join visit on(visit_patient_id = patient_id) --link patient to visit
	join pro on(pro_id = visit_pro_id) --link visit to pro
	join pro_supply on(ps_pro_id = pro_id) --link pro to pro_supply
	join supply on(supply_id = ps_supply_id); --link pro_supply to supply