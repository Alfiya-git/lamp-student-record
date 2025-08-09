# LAMP Student Record System – Documentation

## Project Goal
Deploy a LAMP-based Student Record System using manual Docker networking and integrate it with GitHub for version control.

---

## Step-by-Step Execution

### 1. Docker Network Creation
```bash
docker network create lamp-network
```

---

### 2. MySQL Container Setup
```bash
mkdir mysql-init
docker run -d   --name mysql-container   --network lamp-network   -e MYSQL_ROOT_PASSWORD=rootpassword   -v $(pwd)/mysql-init:/docker-entrypoint-initdb.d   mysql:5.7
```
**Issue:**  
```
error mounting ".../mysql-init": not a directory
```
**Solution:**  
Created the `mysql-init` directory before mounting.

---

### 3. Apache + PHP Container
```bash
docker run -d   --name apache-container   --network lamp-network   -p 8080:80   -v $(pwd)/src:/var/www/html   php:7.4-apache
```
**Issue:** Apache returned `403 Forbidden`  
**Solution:**  
Set correct permissions:
```bash
chmod -R 755 src
```

---

### 4. PHP `mysqli` Extension Error
**Error:**
```
Fatal error: Uncaught Error: Class 'mysqli' not found
```
**Solution:**
```bash
docker exec -it apache-container bash
docker-php-ext-install mysqli
docker-php-ext-enable mysqli
apache2ctl restart
```

---

### 5. GitHub Push Issues
**Problem 1:** Wrong account authentication (HTTP 403)  
**Solution:**  
Switched to SSH method:
```bash
git remote set-url origin git@github.com:Alfiya-git/lamp-student-record.git
```
Added correct SSH key to GitHub.

**Problem 2:** “Key already in use”  
**Solution:**  
Removed key from wrong GitHub account and added to correct one.

---

## Final Outcome
- MySQL container successfully initialized with database scripts.
- Apache + PHP container connected to MySQL via Docker network.
- Application accessible on `http://localhost:8080`.
- Project pushed to GitHub.

---

## Commands Summary
```bash
docker network create lamp-network
docker run -d --name mysql-container --network lamp-network -e MYSQL_ROOT_PASSWORD=rootpassword -v $(pwd)/mysql-init:/docker-entrypoint-initdb.d mysql:5.7
docker run -d --name apache-container --network lamp-network -p 8080:80 -v $(pwd)/src:/var/www/html php:7.4-apache
docker exec -it apache-container bash
docker-php-ext-install mysqli
docker-php-ext-enable mysqli
apache2ctl restart
git init
git remote add origin git@github.com:<username>/lamp-student-record.git
git push -u origin main
```
