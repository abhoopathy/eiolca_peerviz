Getting Started
=======================
This readme is a work in progress.

Set up
-----------------------
1. Install [XAMPP](http://www.apachefriends.org/en/xampp.html)
2. Clone this repo into XAMPP htdocs directory, or create a
   symlink there using 'ln -s <source> <XAMPP_DIR/htdocs/dir>'

Configure SQL
-----------------------
3. Open XAMPP Control, and start Apache and MySQL.
4. Navigate to http://localhost/phpmyadmin/ .
5. Create a database called 'eiolca'.
6. Import the .sql file. Email
   [aneesh.bhoopathy@gmail.com](mailto:aneesh.bhoopathy@gmail.com) if
you need it. Maybe later we can version this. For now, it's 11MB's and
not worth it.
7. The php/json_all.php file includes a headers.php file with db
   connection info. This file is gitignored, also email Aneesh for that.

<!--
How it Works
=======================
Info about the architecture of the application

About the Project
=======================
Info about why this is being built
Add some text about the project here
-->
