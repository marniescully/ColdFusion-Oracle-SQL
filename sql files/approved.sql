drop procedure approved;

create or replace procedure approved

/* parameters */

(
	NUM_LOS			in TBEMP.NUM_LOS%TYPE,
	DAY_REQ 		in TBDAY_REQ.DAY_REQ%TYPE,
	APPROVED 		out BOOLEAN
)

is 

/* variables */

emp_dept_id varchar2(10);/* dept_id of requester */

emp_shift_id char(1); /* shift_id of requester */

quota_num integer; /* number of employees that can be out */
num_out_count integer;/* number of employees that scheduled out */


begin

SELECT dept_id 
	INTO emp_dept_id
	FROM TBEMP 
	WHERE TBEMP.NUM_LOS = NUM_LOS;

SELECT shift_id 
	INTO emp_shift_id
	FROM TBEMP 
	WHERE TBEMP.NUM_LOS = NUM_LOS;

SELECT num_emp_out 
	INTO quota_num
	FROM tbdept_shift 
	WHERE tbdept_shift.dept_id= emp_dept_id
	and tbdept_shift.shift_id = emp_shift_id;




SELECT Count(tbemp_day_req.num_los) INTO num_out_count
		FROM tbdept_shift INNER JOIN 
		tbemp_day_req INNER JOIN tbemp ON 
		tbemp_day_req.num_los = tbemp.num_los ON 
		tbdept_shift.shift_id = tbemp.shift_id AND
		tbdept_shift.dept_id = tbemp.dept_id
		GROUP BY tbemp.dept_id, tbemp.shift_id, 
				tbemp_day_req.day_req
		HAVING tbemp.dept_id = emp_dept_id AND 
			tbemp.shift_id =emp_shift_id AND 
			tbemp_day_req.day_req = DAY_REQ;


if (num_out_count < quota_num) then 
	APPROVED := true;
else
	APPROVED := false;
end if;

end;

/





