# RampUp 2020

## How is this made

__Java:__ Programming language
__Tomcat:__ Servlet container
__PostgreSQL:__ Database
__Docker-compose:__ Container manager
__Jenkins:__ CI tool
__Ngrok:__ Port forwarding for Jenkins

## Individual options

* __TEST:__ ```mvn test```
* __BUILD:__ ```mvn clean package```
* __RUN:__ ```docker-compose up```

These are basically the steps of the pipeline, to make the run works, you must run the build first.
The build step automatically runs the test, so there is not test step, but an artifact.

## Pipeline

The pipeline consists of three stages, Build, Local Deploy and Deploy Artifact.

### Build Stage

This runs ```mvn clean package``` with a flag to allow tests failures.
What this command does, is remove any possible past target, run the unitary tests, and create a war file.
There is also a post step, that generate a report of unit tests, and archive the war file as an artifact, when the build does not fail.

### Local Deploy Stage

The first step of the stage is to remove any possible container associated to the project, to avoid conflicts with the new ones. This by executin the command ```docker-compose down```.
The next step runs ```docker-compose up``` whith some flags to make a clean execution.What this does, is run all the services needed to make the application works.

### Deploy Artifact

This stage runs ```mvn deploy``` to send the mail2clients.war to a nexus repository.

### Artifacts

The pipeline will generate one artifact if something goes wrong, or two if at least the build stage finishes succesfuly.
The first one is the pipeline.log, a log of how the pipeline was. This artifact will be always generated, no matter how the pipelines ends.
The second one, is the mail2clients.war, this artifact will be generated when the build finishes.

## Services

### Tomcat

This is the main service, is a Tomcat 9 container, with the war file inside to serve it. This service connect with the postgres service to make the java app able to use the database.
This is 
 bind to the 8000 port of the host, and has 4 environment variables, which are, the credentiasl for the emal, and the credentials for the database.

### Postgres

This is the database service, it has three environment variables, one for the initial password for the main user. And the other two for the credentails of the user of the app.
This is bind to the 5432 port, as usual for postgresql.

## App

To see information about how the apps works, see the app_README.md file
