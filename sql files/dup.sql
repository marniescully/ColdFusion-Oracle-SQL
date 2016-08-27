drop procedure is_dup_emp;

create or replace procedure is_dup_emp

/* parameters */

(
	NUM_LOS		in TBEMP.NUM_LOS%TYPE,
	EMAIL 		in TBEMP.EMAIL%TYPE,
	DUPLICATE 	out BOOLEAN
)
is 

/* variables */

count_email integer;		/* count the number of times an employee in tbemp has that email  */

count_num_los integer;	/* count the number of times an employee in tbemp has times that num_los  */

begin

SELECT count(*) INTO count_email
FROM TBEMP
WHERE tbemp.email = EMAIL;

SELECT count(*) INTO count_num_los
FROM TBEMP
WHERE tbemp.num_los = NUM_LOS;

if ((count_email >0) or (count_num_los > 0)) then
 DUPLICATE := true;
 else
 DUPLICATE:= false;
 end if;

 end;
 /

