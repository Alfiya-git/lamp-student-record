# LAMP Student Record System (Docker Networking + Git Integration)

## Overview
This is a mini-project implementing a **LAMP stack** (Linux, Apache, MySQL, PHP) using **manual Docker networking** without Docker Compose.  
It includes a **Student Record System** PHP application that interacts with a MySQL database.

The project demonstrates:
- Docker networking concepts
- Running multi-container applications
- Apache & PHP setup
- MySQL initialization
- GitHub version control integration

---

## Tech Stack
- **Linux** (Ubuntu 22.04)
- **Apache2** (web server)
- **MySQL 5.7** (database)
- **PHP 7.x with mysqli** (server-side scripting)
- **Docker** (manual container networking)
- **Git** (version control)

---

## Architecture
```
[ Apache + PHP Container ] <---> [ MySQL Container ]
          (lamp-network via Docker)
```

---

## Setup Instructions

### 1. Create Project Directory
```bash
mkdir lamp-student-record && cd lamp-student-record
```

### 2. Create a Docker Network
```bash
docker network create lamp-network
```

### 3. Setup MySQL Container
```bash
mkdir mysql-init
# Place any SQL files in mysql-init/ to auto-run on startup

docker run -d   --name mysql-container   --network lamp-network   -e MYSQL_ROOT_PASSWORD=rootpassword   -v $(pwd)/mysql-init:/docker-entrypoint-initdb.d   mysql:5.7
```

### 4. Setup Apache + PHP Container
```bash
docker run -d   --name apache-container   --network lamp-network   -p 8080:80   -v $(pwd)/src:/var/www/html   php:7.4-apache
```

### 5. Enable `mysqli` Extension
Inside Apache container:
```bash
docker exec -it apache-container bash
docker-php-ext-install mysqli
docker-php-ext-enable mysqli
apache2ctl restart
```

### 6. Access the App
Open in browser:
```
http://localhost:8080
```

---

## GitHub Integration

### Initialize Git
```bash
git init
git add .
git commit -m "Initial commit"
```

### Add Remote & Push
```bash
git remote add origin git@github.com:<your-username>/lamp-student-record.git
git push -u origin main
```

---

## Troubleshooting

### Apache “Forbidden” Error
**Cause:** Wrong permissions on `/var/www/html`  
**Fix:**
```bash
chmod -R 755 src
```

### `mysqli` Class Not Found
**Cause:** PHP mysqli extension not installed  
**Fix:**
```bash
docker-php-ext-install mysqli
docker-php-ext-enable mysqli
apache2ctl restart
```

### MySQL Init Directory Error
**Cause:** Mounted path not found or is a file instead of a directory  
**Fix:**  
Ensure `mysql-init` exists before running the container:
```bash
mkdir mysql-init
```

---

## License
MIT
