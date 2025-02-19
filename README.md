# **🚀 FastAPI Docker Project**

This is a basic web application developed using the **FastAPI** framework.

## **📁 Directory Structure**

.  
│── app/  
│   └── main.py  
│── config/  
│   ├── nginx/  
│   │   └── config.json  
│   ├── entrypoint.sh  
│── Dockerfile  
│── Makefile  
│── docker-compose.yml  
│── requirements.txt  
│── .env (Environment variables required by the project)

## **🛠️ Installation**

### **1️⃣ Install Required Dependencies**

* [Docker](https://docs.docker.com/get-docker/)  
* [Docker Compose](https://docs.docker.com/compose/install/)

### **2️⃣ Create the .env File**

Create your **.env** file and add the necessary variables.

### **3️⃣ Start the Application**

**To start using Docker:**
```
make build  \# Builds the Docker image and starts containers.
```
Alternatively:
```
docker-compose up -d --build
```
## **🐳 Docker Usage**

| Command | Description |
| ----- | ----- |
| make build | Builds the Docker image and starts containers. |
| make up | Starts containers using the existing Docker image. |
| make down | Stops and removes containers. |

## **📌 config.json Explanation**

The `config.json` file contains configuration settings for **NGINX Unit** and defines how the FastAPI application will run. If you’d like to explore further, you can check out the official [unit.nginx.org](https://unit.nginx.org/howto/fastapi/?utm_source=chatgpt.com)

### **Main Structure**
```
{  
    "listeners": {  
        "*:9000": {  
            "pass": "applications/fastapi"  
        }  
    },  
    "applications": {  
        "fastapi": {  
            "type": "python",  
            "path": "/code/",  
            "home": "/usr/local",  
            "module": "app.main",  
            "callable": "app"  
        }  
    }  
}
```
### **Detailed Explanations**

* **listeners**: Specifies which port the application will listen on. Here, `*:9000` means port 9000 is open for external access.  
* **pass**: Defines which application incoming connections will be forwarded to. Since it’s set to `applications/fastapi`, requests are directed to the FastAPI application.  
* **applications**: Lists the applications running on the server.  
  * **fastapi**: The name given to the project.  
  * **type**: Specifies the application type. Set to **Python**.  
  * **path**: The root directory of the FastAPI application (`/code/`).  
  * **home**: Location of the Python environment (`/usr/local`).  
  * **module**: Defines which Python module will be run by FastAPI (`app.main`).  
  * **callable**: Specifies the callable object in the FastAPI application (`app`).

## **📌 Dockerfile Explanation**

### **Using the Base Image**
```
FROM python:3.11.6-alpine3.18
```
I’m currently using an Alpine-based **Python 3.11.6** image because it’s lightweight. However, feel free to check DockerHub for more up-to-date versions or other Python images that may better suit your needs.
### **Installing Required Packages**
```
RUN apk update \--no-cache && \\  
    apk add \--no-cache unit-python3 curl tzdata gcc g++ libc-dev libffi-dev libpq-dev && \\  
    apk upgrade \--no-cache
```
* `apk add unit-python3`: Installs **NGINX Unit** for Python.  
* `curl tzdata gcc g++`: Adds necessary tools like **Curl**, timezone data, and C compilers.  
* `libc-dev libffi-dev libpq-dev`: Libraries for **PostgreSQL** and system-related dependencies.

## **📌 Docker-Compose Explanation**

### **Service Definitions**
```
services:  
  app:  
    build:  
      context: .  
      dockerfile: Dockerfile
```
This section defines how to build the container using the **Dockerfile**.

### **Port Configuration**

ports: 
``` 
  - "9000:9000"
```
Exposes the **9000** port of FastAPI to the outside world.

### **Volume Usage**

volumes: 
``` 
  - ./:/code
```
This line synchronizes local files with those inside the container.

## **📝 API Usage**

### **📌 API Documentation**

You can access the Swagger UI at:

http://localhost:9000/api-docs

### **📌 Example Request**

Main endpoint:
```
curl -X 'GET' 'http://localhost:9000/' -H 'accept: application/json'
```
Response:
```
{  
  "Hello": "World"  
}
```