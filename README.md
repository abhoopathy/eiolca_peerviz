This readme is a work in progress.

# About the Project

## Purpose
Why are we making this? Who?

## General Architecture
Info about the architecture of the application

# Getting Started

## Development Environment

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

1. Open XAMPP Control. Start Apache and MySQL.

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

## Cross Origin Requests
If you're using chrome, and the website doesn't work, check developer console. It's likely due to the error 'Cross origin requests
are only supported for HTTP.' Start chrome with the flags

    --new --args -allow-file-access-from-files

Or if you're on mac, you can use this to make an alias:

    alias chromeDev="open '/Applications/Google Chrome.app' --new --args -allow-file-access-from-files"


## Less Compilation
You have options here:
### LiveReload ($9)
 I use [LiveReload](http://livereload.com/). It watches a folder for
*.less file saves, compiles them to css, and reloads the browser via a
browser plugin. I find this tremendously heplful. However, it is $9.
(There is also [less.app](http://incident57.com/less/) which claims to
do the same thing for free.)

### Less-watcher (free)
If you would rather not use LiveReload, you can watch and compile less
files using [less-watcher](https://github.com/Doist/less-watcher).

    sudo npm install less-watcher
    less-watcher -p "" -d css/

# Deploying
Info about the app's architecture, building, and deploying

## Building
Info about building the app, minifying js, etc.

## Deplying
Info about Deploying

