# CS347 OptionF

### Package Installation Instructions

1. Download this repository as a zip or clone it using `git clone https://github.com/caelanevans/CS347_OptionF.git`
  * Unzip the project if necessary
1. Modify the InstallRestWrapperPackage.sql file to fit your group's header information. You will need to modify:
  * Line 94  (the user header)
  * Line 97  (the port number on the 'password', which should be your group's port number+1)
  * Line 103 (the model value)
  * Line 138 (the port number, which should just be your group's raw port number)
1. Upload the SQL file to APEX the same way you would upload a DDL file
1. Run the SQL file in APEX (again, the same way as a DDL file). This will "install" the package into your workspace.

#### Note

You may encounter 3 errors when installing the package for the first time. These are due to the fact that the installation script drops the package and 2 datatypes if they already exist in the workspace. You can ignore these errors.

### Steps to create and populate an LOV using the doLOV() function

1. Create or re-purpose an existing select list in a form.
1. To populate the select list, either use an SQL query, or populate based on a shared component. Either way, use the query template below.

#### Query templates

##### Single display value

````SQL
SELECT DISPLAY_VAL AS d,
       RETURN_VAL AS r
FROM TABLE(rwp.doLOV('class_name', '[display_column]', '[return_column]'))
````

##### Concatenated display value
````SQL
SELECT DISPLAY_VAL AS d,
       RETURN_VAL AS r
FROM TABLE(rwp.doLOV('class_name', '[display_column1], [display_column2]', '[return_column]'))
````

##### Using a "where" clause
````SQL
SELECT DISPLAY_VAL AS d,
       RETURN_VAL AS r
FROM TABLE(rwp.doLOV('class_name', '[display_column]', '[return_column]', 'where [some_column] = 1'))
````

### Example queries with Part 1 equivalents

(Note that your table names, class names, and column names may be different)

##### Example 1

Populate a select list with managers, displaying their last name (last_name column) to the user, and returning person_id to APEX

In SQL/Part 1:
````SQL
SELECT last_name AS d,
       person_id AS r
FROM Person
WHERE type='manager'
````

doLOV/OptionF equivalent:
````SQL
SELECT DISPLAY_VAL AS d,
       RETURN_VAL  AS r
FROM TABLE(rwp.doLOV('Manager', '[last_name]', '[person_id]'))
````

##### Example 2

Populate a select list with presidents, displaying "Employee ID - Last Name, First Name" to the user, and returning person_id to APEX

In SQL/Part1
````SQL
SELECT employee_id||' - '||last_name||', '||first_name AS d,
       person_id AS r
FROM Person
WHERE type='president'
````

doLOV/OptionF equivalent:
````SQL
SELECT DISPLAY_VAL AS d,
       RETURN_VAL AS r
FROM TABLE(rwp.doLOV('President', '[employee_id] - [last_name], [first_name]', '[person_id]'))
````
