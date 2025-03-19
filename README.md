# Queue Up
A site for hosting Lan parties

## (Dev) Port mappings
This section is used to help keep track of which ports are in use where

- Host port:
    - The outermost exposed port, from the kind container to your machine
- Node port
    - The next outermost exposed port, maps the port from inside the cluster to the kind container
- Cluster port
    - The next inner most port, maps the container port to the cluster port
- Container port
    - The inner most port, simply the port the app is running on inside of the container 

|App                     |Host port|Node port|Cluster port|Container port|
|------------------------|---------|---------|------------|--------------|
|Admin organiser backend |3000     |30100    |3000        |3000          |
|Admin organiser frontend|8080     |30200    |8080        |80            |
|Guest backend           |5137     |30300    |5173        |3000          |
|Guest frontend          |8000     |30400    |8000        |80            |
|Authenticator api       |5000     |30500    |5000        |3000          |
|Rabbitmq service        |5672     |30600    |5672        |5672          |