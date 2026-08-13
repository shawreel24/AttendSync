# AttendSync Backend Integration Completed

I have successfully connected the AttendSync sign-in page to a functional PHP backend with MySQL.

Here is a breakdown of what has been implemented:

## Changes Made

### 1. Database Setup Script
- Created [database.sql](file:///d:/5th%20Sem/Mini%20Project/AttendSync/database.sql) which contains the SQL commands to create the `attendsync` database and the `users` table. 
- It includes some sample data so you can test logging in right away:
  - **Teacher:** `teacher@school.edu` (Password: `password123`)
  - **Student:** `student@school.edu` (Password: `password123`)
  - **Admin:** `admin@school.edu` (Password: `password123`)

### 2. Database Connection
- Created [db.php](file:///d:/5th%20Sem/Mini%20Project/AttendSync/db.php) which sets up a secure PDO connection to your local MySQL server.
- **Note:** It assumes your MySQL username is `root` with no password (default for tools like XAMPP/WAMP). If yours is different, you can update it in the file.

### 3. Backend Logic
- Created [login.php](file:///d:/5th%20Sem/Mini%20Project/AttendSync/login.php) which handles incoming requests securely.
- It receives JSON data (email, password, and role) from the frontend, queries the database, and uses `password_verify` to check the hashed passwords for security.

### 4. Frontend Integration
- Modified [script.js](file:///d:/5th%20Sem/Mini%20Project/AttendSync/js/script.js) to replace the "simulated" login popup.
- It now uses the `fetch()` API to send actual credentials to the PHP backend. Because of this, the page won't reload unexpectedly, maintaining the smooth, modern UI look you designed.

## How to Test This Locally

1. **Start your server:** Make sure Apache and MySQL are running in your local development environment (XAMPP, WAMP, Laragon, etc.).
2. **Setup the Database:**
   - Open your database manager (like phpMyAdmin at `http://localhost/phpmyadmin`).
   - Import the `database.sql` script I created, or manually run the SQL commands from the file to create the tables.
3. **Run the App:** 
   - Ensure the `AttendSync` project is in your server's root folder (e.g., `htdocs` for XAMPP).
   - Go to `http://localhost/AttendSync/index.html` in your browser.
   - Try logging in with the sample credentials mentioned above!
