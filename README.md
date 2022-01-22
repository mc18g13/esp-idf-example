# esp-idf-example

esp-idf example project with linux host unit tests and mocking

`make docker-build` Builds docker image to run other commands in  
`make enter` Opens a console to the docker container for debugging  
`make build` Mounts and builds firmware inside docker image  
`make unit` Builds and runs unit tests for a single component with dependencies.
This example has the dependencies mocked  

`make help` for all targets and information