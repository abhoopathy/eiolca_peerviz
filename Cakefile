{exec} = require 'child_process'

task 'build', 'build the source dir', ->
    exec 'node r.js -o source/scripts/app.build.js', (err, stdout, stderr) ->
        console.log err
        throw err if err
        console.log stdout + stderr

task 'deploy', 'deploy to pmw', ->
    exec 'scp -r build/* hsm@pmw.org:/usr/users/hsm/eiolca/www/peerviz', (err, stdout, stderr) ->
        throw err if err
        console.log stdout + stderr
