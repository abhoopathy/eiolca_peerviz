{exec} = require 'child_process'

task 'build', 'build the source dir', ->
    exec 'node r.js -o source/scripts/app.build.js', (err, stdout, stderr) ->
        throw err if err
        console.log stdout + stderr

task 'deploy', 'deploy to aneeshb.com', ->
    exec 'scp -r build/* aneeshbc@50.22.11.7:~/www/blackboard', (err, stdout, stderr) ->
        throw err if err
        console.log stdout + stderr
