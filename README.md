# Getting Started
This readme is a work in progress.

## Set up

1. Install [XAMPP](http://www.apachefriends.org/en/xampp.html)

2. Clone this repo somewhere.
        git clone https://abhoopathy@bitbucket.org/abhoopathy/eiolca_collegeviz.git

3. Create a symlink of the source directory in the XAMPP htdocs using

        ln -s PATH_TO_REPO/source/ XAMPP_DIR/htdocs/collegeviz

    (On mac, the XAMPP path is /Applications/XAMPP/htdocs/. On windows, I believe it's in the root of your main drive.)

4. Open XAMPP Control, and start Apache and MySQL.

5. Navigate to [http://localhost/collegeviz/](http://localhost/collegeviz/). the index page should be
   displayed .

## Configure SQL

1. Open XAMPP Control, and start Apache and MySQL.

2. Navigate to [http://localhost/phpmyadmin/](http://localhost/phpmyadmin/) .

3. Create a database called 'eiolca'.

4. Import the .sql file. Email
[aneesh.bhoopathy@gmail.com](mailto:aneesh.bhoopathy@gmail.com) if
you need it. Maybe later we can version this. For now, it's 11MB's and
not worth it.

5. The php/json_all.php file includes a headers.php file with db
connection info. This file is gitignored because it contains
passwords. If you don't have it, also email Aneesh for that.

6. Navigate to [http://localhost/collegeviz/php/json_all.php](http://localhost/collegeviz/php/json_all.php) to make
   sure that works.

## To Add
Info about the app's architecture, building, and deploying

//## How it Works
//Info about the architecture of the application
//
//## Building
//Info about building the app
//
//## Building
//Info about the architecture of the application
//
//## About the Project
//Info about why this is being built
//Add some text about the project here
