-- Navigation Bar --

-- Alerts!
DECLARE
  x number;
  y number;
  z number;
BEGIN
  select count(person_id) into x from P_PERSON JOIN P_PARENT_CHILD ON person_id = creator 
  	and pending = 1 and (parent_id = :P_ID or child_id = :P_ID) and person_id != :P_ID;

  select count(project_id) into y from P_Project where (manager_id is null or dept_id is null) 
  	and :P_TYPE = 'President';

  select count(person_id) into z from P_PERSON where (salary is null or bonus is null) 
  	and person_type != 'Person' AND :P_type = 'President' AND QUIT = 0 AND FIRED = 0;

  if (x > 0 or y > 0  or z > 0) and :P_ID != 0 then
  	return true;
  end if;

  return false;
END;

-- PROJECTS
BEGIN
   IF (:P_TYPE != 'Person') and :P_ID is not NULL THEN
       RETURN TRUE;
   END IF;
   RETURN FALSE;
END;

-- PRESIDENT'S EMPLOYEES
BEGIN
   IF :P_TYPE = 'President' and :P_ID is not NULL THEN
       RETURN TRUE;
   END IF;
   RETURN FALSE;
END;

-- MANAGER'S EMPLOYEES
BEGIN
   IF :P_TYPE = 'Manager' and :P_ID is not NULL THEN
       RETURN TRUE;
   END IF;
   RETURN FALSE;
END;

-- EMPLOYEE'S MANAGERS
begin
if :P_TYPE = 'Employee' and :P_ID is not null then
return true;
end if;

return false;

-- DEPARTMENTS
BEGIN
   IF :P_TYPE = 'President' and :P_ID is not null THEN
       RETURN TRUE;
   END IF;
   RETURN FALSE;
END;



-- ALERTS! --

-- PROJECTS NEED MANAGER DEPT
select "PROJECT_ID", 
"PROJECT_TITLE",
"PROJECT_TYPE",
"PROJECT_ACTIVE",
"END_DATE",
"EST_PERSON_HOURS",
"MANAGER_ID",
"DEPT_ID",
"MP_ID"
from "#OWNER#"."P_PROJECT" 
where manager_id is null or dept_id is null 
AND PROJECT_TYPE = 'Current' 

-- SET SALARY/BONUS
select "PERSON_ID", 
"PERSON_TYPE",
"FIRST_NAME",
"LAST_NAME",
"STREET_ADDRESS",
"CITY",
"STATE",
"ZIPCODE",
"PHONE",
"SALARY",
"BONUS",
"US_CITIZEN",
"SALARY_EXCEPTION",
"FIRED",
"QUIT",
"DEPT_ID",
"SPOUSE_ID"
from "#OWNER#"."P_PERSON" 
where (SALARY is null or BONUS is null) 
and person_type != 'Person' AND QUIT = 0 AND FIRED = 0

-- FAMILY
DECLARE
  x number;
BEGIN
  select count(person_id) into x from P_PERSON JOIN P_PARENT_CHILD 
  	ON person_id = creator and pending = 1 
  	and (parent_id = :P_ID or child_id = :P_ID) 
  	and person_id != :P_ID;

  if x > 0 then
   return true;
  end if;

  return false;
END;




-- PROJECTS --

-- ACTIVE PROJECTS
select P."PROJECT_ID", 
"PROJECT_TITLE",
"PROJECT_TYPE",
"PROJECT_ACTIVE",
"END_DATE",
"EST_PERSON_HOURS",
"MANAGER_ID",
"DEPT_ID",
"MP_ID",
'' as "Employees",
'' as "Sub Projects"
from "#OWNER#"."P_PROJECT" p
full join P_PROJECTS pp
on pp.project_id = p.project_id
where (:P_ID = P.MANAGER_ID or :P_ID = pp.person_id)
and project_active = 1 and project_type = 'Current';

-- NON ACTIVE PROJECTS
select P."PROJECT_ID", 
"PROJECT_TITLE",
"PROJECT_TYPE",
"PROJECT_ACTIVE",
"END_DATE",
"EST_PERSON_HOURS",
"MANAGER_ID",
"DEPT_ID",
"MP_ID",
'' as "Employees",
'' as "Sub Projects"
from "#OWNER#"."P_PROJECT" p
full join P_PROJECTS pp
on pp.project_id = p.project_id
where (:P_ID = P.MANAGER_ID or :P_ID = pp.person_id)
and project_active = 0 and project_type = 'Current';

-- PREVIOUS PROJECTS
select P."PROJECT_ID", 
"PROJECT_TITLE",
"PROJECT_TYPE",
"PROJECT_ACTIVE",
"END_DATE",
"EST_PERSON_HOURS",
"MANAGER_ID",
"DEPT_ID",
"MP_ID",
'' as "Employees",
'' as "Sub Projects"
from "#OWNER#"."P_PROJECT" p
full join P_PROJECTS pp
on pp.project_id = p.project_id
where (:P_TYPE = 'President' 
or :P_ID = P.MANAGER_ID or :P_ID = pp.person_id) 
and project_type != 'Current';





-- FAMILY --

-- SPOUSE
select "PERSON_ID", 
"PERSON_TYPE",
"FIRST_NAME",
"LAST_NAME",
"STREET_ADDRESS",
"CITY",
"STATE",
"ZIPCODE",
"PHONE",
"SALARY",
"BONUS",
"US_CITIZEN",
"SALARY_EXCEPTION",
"FIRED",
"QUIT",
"DEPT_ID",
"SPOUSE_ID"
from "#OWNER#"."P_PERSON" 
where spouse_id = :P_ID

-- PARENTS
select p."PERSON_ID", 
"PERSON_TYPE",
"FIRST_NAME",
"LAST_NAME",
"STREET_ADDRESS",
"CITY",
"STATE",
"ZIPCODE",
"PHONE",
"SALARY",
"BONUS",
"US_CITIZEN",
"SALARY_EXCEPTION",
"FIRED",
"QUIT",
"DEPT_ID",
"SPOUSE_ID",
pp.pending
from "#OWNER#"."P_PERSON" p
full join P_PARENT_CHILD pp 
on p.person_id = pp.PARENT_id 
WHERE PP.CHILD_ID = :P_ID

-- CHILDREN
select P."PERSON_ID", 
"PERSON_TYPE",
"FIRST_NAME",
"LAST_NAME",
"STREET_ADDRESS",
"CITY",
"STATE",
"ZIPCODE",
"PHONE",
"SALARY",
"BONUS",
"US_CITIZEN",
"SALARY_EXCEPTION",
"FIRED",
"QUIT",
"DEPT_ID",
"SPOUSE_ID",
pp.pending
from "#OWNER#"."P_PERSON" p
join P_Parent_Child pp
on pp.child_id = p.person_id
where pp.parent_id = :P_ID


-- EDIT PERSON

-- ITEMS
-- SELECT MANAGER EMPLOYEES
select distinct (last_name || ',   ' || first_name || '   ->   ' || person_id) as display_value, 
PERSON_ID as return_value from P_PERSON left JOIN P_MANAGER_EMPLOYEE ON person_id = employee_id 
where (manager_id is null or manager_id != :P32_PERSON_ID) and person_type = 'Employee'
order by 1

-- UNSELECT MANAGER EMPLOYEES
select distinct (last_name || ',   ' || first_name || '   ->   ' || person_id) as display_value, 
PERSON_ID as return_value from P_PERSON right JOIN P_MANAGER_EMPLOYEE ON person_id = employee_id 
where employee_id = :P32_PERSON_ID
order by 1

-- SELECT EMPLOYEE MANAGERS
select distinct (last_name || ',   ' || first_name || '   ->   ' || person_id) as display_value, 
PERSON_ID as return_value from P_PERSON where person_type = 'Manager' and person_id not in 
(select manager_id from P_Manager_Employee where employee_id = :P32_PERSON_ID)
order by 1

-- UNSELECT EMPLOYEE MANAGERS
select distinct (last_name || ',   ' || first_name || '   ->   ' || person_id) as display_value, 
PERSON_ID as return_value from P_PERSON left JOIN P_MANAGER_EMPLOYEE ON person_id = manager_id 
where employee_id = :P32_PERSON_ID
order by 1

-- ADD EMPLOYEES
declare
    tab apex_application_global.vc_arr2;
begin
    tab := apex_util.string_to_table (:P32_SELECT_MANAGER_EMPLOYEES);
    for i in 1..tab.count loop  
		INSERT INTO P_MANAGER_EMPLOYEE (ME_ID, MANAGER_ID, EMPLOYEE_ID)
			VALUES (1, :P32_PERSON_ID, tab(i));
    end loop;
end;


-- ADD MANAGERS
declare
    tab apex_application_global.vc_arr2;
begin
    tab := apex_util.string_to_table (:P32_SELECT_EMPLOYEE_MANAGERS);
    for i in 1..tab.count loop       
		INSERT INTO P_MANAGER_EMPLOYEE (ME_ID, MANAGER_ID, EMPLOYEE_ID)
			VALUES (1, tab(i), :P32_PERSON_ID);
    end loop;
end;

-- DELETE EMPLOYEES
declare
    tab apex_application_global.vc_arr2;
begin
    tab := apex_util.string_to_table (:P71_UNSELECT_MANAGER_EMPLOYEES);
    for i in 1..tab.count loop       
		DELETE FROM P_MANAGER_EMPLOYEE
			WHERE manager_id = :P32_PERSON_ID and employee_id = tab(i);
    end loop;
end;

-- DELETE MANAGERS
declare
    tab apex_application_global.vc_arr2;
begin
    tab := apex_util.string_to_table (:P32_UNSELECT_EMPLOYEE_MANAGERS);
    for i in 1..tab.count loop       
		DELETE FROM P_MANAGER_EMPLOYEE
			WHERE employee_id = :P32_PERSON_ID and manager_id = tab(i);
    end loop;
end;

-- FIRE/QUIT MANAGER
declare

begin
    if :P32_FIRED = 1 OR :P32_QUIT = 1 AND :P32_PERSON_TYPE = 'Manager' then
        UPDATE P_PROJECT
        SET MANAGER_ID = NULL
        WHERE MANAGER_ID = :P32_PERSON_ID;

        DELETE FROM P_Manager_Employee
        WHERE manager_id = :P32_PERSON_ID;
    end if;

    if  :P32_FIRED = 1 OR :P32_QUIT = 1 AND :P32_PERSON_TYPE = 'Employee' then
        DELETE FROM P_PROJECTS
        WHERE person_id = :P32_PERSON_ID;

        DELETE FROM P_Manager_Employee
        WHERE employee_id = :P32_PERSON_ID;
    end if;
end;

-- EDIT PROJECTS
-- FIND EMPLOYEES
select (FIRST_NAME || ' ' || LAST_NAME || ' -> ' || PERSON_ID) as display_value, PERSON_ID as return_value 
from P_PERSON where person_id not in (select p.person_id from P_Projects p 
where p.project_id = :P23_PROJECT_ID) 
and person_type = 'Employee';

-- ADD EMPLOYEES
declare
    tab apex_application_global.vc_arr2;
begin
    tab := apex_util.string_to_table (:P23_EMPLOYEES);
    for i in 1..tab.count loop
        insert into P_PROJECTS (PROJECTS_ID, PERSON_ID, PROJECT_ID)
        values (1, tab(i),  :P23_PROJECT_ID);
    end loop;
end;

-- FIND SUB PROJECTS
select (PROJECT_TITLE || ' -> ' || PROJECT_ID) as display_value, PROJECT_ID as return_value 
from P_PROJECT where project_id != :P23_PROJECT_ID and project_type = 'Current' 
and (mp_id is null or mp_id != :P23_PROJECT_ID)
order by 1

-- ADD SUB PROJECTS
declare
    tab apex_application_global.vc_arr2;
begin
    tab := apex_util.string_to_table (:P23_SUB_PROJECTS);
    for i in 1..tab.count loop   
		UPDATE P_PROJECT
		SET MP_ID = :P23_PROJECT_ID
		WHERE project_id = tab(i);
    end loop;
end;

-- REMOVE EMPLOYEES
select distinct (p.FIRST_NAME || ' ' || p.LAST_NAME || ' -> ' || p.PERSON_ID) as display_value, 
P.PERSON_ID as return_value 
from P_PERSON p join P_Projects pp on p.person_id = pp.person_id 
where pp.project_id = :P23_PROJECT_ID
order by 1

declare
    tab apex_application_global.vc_arr2;
begin
    tab := apex_util.string_to_table (:P23_REMOVE_EMPLOYEES);
    for i in 1..tab.count loop
		DELETE FROM P_Projects
		WHERE person_id = tab(i) and project_id = :P23_PROJECT_ID;
    end loop;
end;

-- REMOVE SUB PROJECTS
select (PROJECT_TITLE || ' -> ' || PROJECT_ID) as display_value, PROJECT_ID as return_value 
from P_PROJECT WHERE MP_ID = :P23_PROJECT_ID
order by 1

declare
    tab apex_application_global.vc_arr2;
begin
    tab := apex_util.string_to_table (:P23_REMOVE_SUB_PROJECTS);
    for i in 1..tab.count loop
		UPDATE P_Project
		SET mp_id = NULL
		WHERE project_id = tab(i);
    end loop;
end;

 -- TRANSFER EMPLOYEES
select (PROJECT_TITLE || ' -> ' || PROJECT_ID) as display_value, PROJECT_ID as return_value 
from P_PROJECT where project_id != :P23_PROJECT_ID
order by 1

declare
begin
	IF :P23_TRANSFER_EMPLOYEES IS NOT NULL THEN        
		UPDATE P_PROJECTS
		SET PROJECT_ID = :P23_TRANSFER_EMPLOYEES
		WHERE PROJECT_id = :P23_PROJECT_ID;
	END IF;
end;

-- TRANSFER SUB PROJECTS
select (PROJECT_TITLE || ' -> ' || PROJECT_ID) as display_value, PROJECT_ID as return_value 
from P_PROJECT where project_id != :P23_PROJECT_ID
order by 1

declare
begin
	IF :P23_TRANSFER_SUB_PROJECTS IS NOT NULL THEN      
		UPDATE P_PROJECT
		SET MP_ID = :P23_TRANSFER_SUB_PROJECTS
		WHERE MP_ID = :P23_PROJECT_ID AND PROJECT_ID != :P23_TRANSFER_SUB_PROJECTS;
	END IF;
end;



















