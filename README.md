# EduQuest - Indian College Search Portal

EduQuest is a modern, premium web portal designed for searching and comparing Information Technology (IT) and Business Management colleges across India. The application features a beautiful glassmorphic UI, responsive layouts, fast live search suggestions, and a robust Node/Express/MySQL backend.

---

## Features

- **Responsive Glassmorphic UI**: Beautiful visuals with modern typography, frosted glass effects, subtle hover interactions, and counters.
- **Fast Live Search suggestions**: Queries database as you type, offering immediate recommendations for matching institutions.
- **Dynamic College Profiles**: Displays extensive details of a college including logo initials, NAAC grade, type, address, website, and an interactive courses-offered list showing duration, eligibility, and fees.
- **Robust MVC Design**: Completely separated models, views, controllers, and routing rules on Express.js.

---

## Project Structure

```text
EduQuest/
├── config/
│   └── db.js                 # MySQL Pool Connection
├── controllers/
│   ├── collegeController.js  # College endpoint logic
│   └── courseController.js   # Course endpoint logic
├── database/
│   └── eduquest.sql          # Seed data (100 colleges and courses mapping)
├── models/
│   ├── collegeModel.js       # Database models for colleges, stats, and search
│   └── courseModel.js        # Database models for courses
├── public/
│   ├── index.html            # Landing / search homepage
│   ├── college.html          # Details view page
│   ├── css/
│   │   ├── style.css         # Glassmorphism, animations, variables
│   │   └── responsive.css    # Media queries override stylesheet
│   └── js/
│       ├── app.js            # General page setup, analytics, metrics counters
│       ├── search.js         # Debounced text search suggestions and filters
│       └── college.js        # Dynamic parsing and rendering of detail cards
├── routes/
│   ├── collegeRoutes.js      # Router for college paths
│   └── courseRoutes.js       # Router for course paths
├── .env                      # Connection ports and DB credentials
├── server.js                 # Server entry point
├── package.json              # App package dependencies
└── README.md                 # Project user documentation
```

---

## Installation & Setup

Follow these steps to run the project locally on your Windows system with VS Code:

### 1. Prerequisite Checks
Make sure you have Node.js and MySQL Server installed:
- **Node.js**: [Download Node.js](https://nodejs.org) (v16.0.0+ recommended)
- **MySQL Database**: Ensure MySQL server is running (usually via XAMPP, WampServer, or direct installation).

### 2. Import the Database
1. Open your MySQL client interface (e.g., phpMyAdmin, MySQL Workbench, Command Line, or VS Code Database extension).
2. Create a new database named `eduquest`:
   ```sql
   CREATE DATABASE eduquest;
   ```
3. Import the generated seed SQL file located at:
   `c:/Users/Mukht/OneDrive/Documents/anti_eduquest/database/eduquest.sql`
   
   If you are using the command line:
   ```cmd
   mysql -u root -p eduquest < "c:\Users\Mukht\OneDrive\Documents\anti_eduquest\database\eduquest.sql"
   ```
   *(Note: Replace `root` with your mysql username, and press Enter to type password if set).*

### 3. Setup Environment Variables
Verify or edit the `.env` file in the project root folder:
```env
PORT=3000
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=eduquest
```
If your MySQL root user has a password, enter it in `DB_PASSWORD`.

### 4. Install Dependencies
Open a terminal in the project directory in VS Code and run:
```cmd
npm install
```
This will download `express`, `mysql2`, `cors`, and `dotenv`.

### 5. Launch the Server
Start the Express server:
```cmd
npm start
```

You should see confirmation output:
```text
Database connected successfully.
==================================================
EduQuest Server is active on Port: 3000
Local web portal URL: http://localhost:3000
==================================================
```

### 6. Visit the Portal
Open your web browser and navigate to:
[http://localhost:3000](http://localhost:3000)
