# RampUp 2020

## How is this made

Java
PostgreSQL
Docker-compose
Jenkins

## Individual options

* __TEST:__ ```mvn test```
* __BUILD:__ ```mvn clean package```
* __RUN:__ ```docker-compose up```

These are basically the steps of the pipeline, to make the run works, you must run the build first.
The build step automatically runs the test, so there is not test step, but an artifact.
