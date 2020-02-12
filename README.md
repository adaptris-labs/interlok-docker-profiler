# interlok-docker-profiler

## What is this

This image runs an instance of Interlok with the profiling monitor enabled using AspectJ.

## Quickstart

* You'll need java of course because gradle is the build system.
* Docker of course

* `./gradlew docker`
    * Since you haven't specified a image name, it will be _adaptrislabs/interlok-docker-profiler_
    * The version is _latest_;
* Either run `docker-compose up` or `./gradlew dockerComposeUp`
    * Wait for the adapter to fully start (you'll see something in the console output to that effect).

Now you'll see lots of logging which is the profiler searching for events.  Simply do a HTTP POST to http://localhost:8080/endpoint1.

After a short time you'll see profiling statistics showing up in the logs.

## Resources

* https://interlok.adaptris.net/interlok-docs

## Gradle flags

You can control some behaviour by passing in project properties in the form *-PpropertyKey=value*

Property Key | Default Value | Description | Notes
------------ | ------------- | ----------- | -----
releaseVersion|latest|The docker tag version ||
dockerImageName|adaptrislabs/interlok-docker-profiler| The docker image name||
buildEnv|docker|Change it to anything else to drive local properties from your hostname| This directly affects the way property files are sourced, by default it will be `variables.propertes.{buildEnv}`|
