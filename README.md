# **Netflix Data Analysis**  

## **🔹 Project Overview**  
This project analyzes **Netflix’s movies and TV shows dataset** to uncover insights into **genre popularity, IMDb ratings, and content trends**. The data is **cleaned with Python (Pandas in Jupyter Notebook), stored in MySQL, integrated with Power BI via ODBC for real-time updates, and visualized through an interactive dashboard**.  

---

## 1️⃣ Project Steps  

### **📌 Step 1: Data Cleaning with Python (Pandas in Jupyter Notebook)**  
- Used **Pandas** for:   
  ✅ Removing duplicate rows  
  ✅ Standardizing column names  
  ✅Removed duplicate rows to ensure data consistency.                                                                      
  ✅Dropped the imdbID column as it was irrelevant to analysis.                                       
  ✅Removed rows with missing Movie_Title to maintain data integrity.                             
  ✅Replaced null values in Genres with "Unknown" to avoid missing classifications.                                       
  ✅Replaced null values in IMDB_Rating and IMDB_Votes with 0 to prevent calculation errors.                                     
  ✅Split multiple genres in a single cell into separate rows to normalize genre classification.                                       
  ✅Split multiple countries in Available_Countries into separate rows for better regional analysis.                                         
  ✅Converted Release_Year to an integer format for accurate time-based analysis

---

### **📌 Step 2: SQL Integration in Jupyter Notebook**  
- Connected **Python with MySQL** using `pymysql` & `SQLAlchemy`.  
- Uploaded the cleaned dataset from Pandas to MySQL.  

```python
import pandas as pd
from sqlalchemy import create_engine

engine = create_engine("mysql+pymysql://root:Niramayi@127.0.0.1:3306/netflix")

df = pd.read_csv("movies_data.csv")
df.to_sql("Data" ,con = engine,if_exists = "replace",index = False )
```

---

### **📌 Step 3: Data Normalization in MySQL**  
- **Normalized the dataset** by creating **four tables**:  
  ✅ `Movies` – Stores movie details (Title, IMDb Rating, Release Year)  
  ✅ `Genres` – Stores unique genres  
  ✅ `Movie_Genres` – Maps movies to multiple genres (Many-to-Many relationship)  
  ✅ `Movie_Countries` – Stores country availability for each movie  

```sql
CREATE TABLE Movies (
    Movie_ID INT PRIMARY KEY AUTO_INCREMENT,
    Movie_Title VARCHAR(255),
    IMDB_Rating FLOAT,
    Release_Year INT
);
```

---

### **📌 Step 4: SQL Queries for Data Analysis**  
- **Yaer wise count of movies:**  
  ```sql
  SELECT Release_Year,COUNT(DISTINCT Movie_Title) Movie_Count
  FROM movies
  GROUP BY Release_Year
  ORDER BY Release_Year;
  ```
- **genre wise count of movies:**  
  ```sql
  SELECT g.Genre,COUNT(DISTINCT m.Movie_Title) Movie_Count
  FROM genres g
  JOIN movie_genres mg ON mg.Genre_ID=g.Genre_ID
  JOIN movies m ON m.Movie_ID = mg.Movie_ID
  GROUP BY g.Genre
  ORDER BY Movie_Count;
  ```
- **Average IMDB rating of each genre:**  
  ```sql
  SELECT g.Genre,AVG(m.IMDB_Rating) Average_rating
  FROM genres g
  JOIN movie_genres mg ON mg.Genre_ID=g.Genre_ID
  JOIN movies m ON m.Movie_ID = mg.Movie_ID 
  GROUP BY g.Genre
  ORDER BY Average_rating;
  ```

---

### **📌 Step 5: MySQL-Power BI Integration (Real-Time Updates Using ODBC)**  
- **Connected MySQL to Power BI using the ODBC Connector** for **dynamic & real-time updates**.  
- Steps to connect:  
  1️⃣ **Install the MySQL ODBC Driver**  
  2️⃣ **Set up an ODBC Data Source** (ODBC Data Source Administrator → System DSN → Add → MySQL ODBC 8.0 Driver)  
  3️⃣ **Connect Power BI to ODBC**:  
     - `Get Data → ODBC → Select MySQL DSN → Load Data`  

---

### **📌 Step 6: Power BI Dashboard & Report Creation**  
- **Created an interactive Power BI Dashboard** with:  
  ✅ **KPI Cards**: Total Movies, Average IMDb Rating, Most-Watched Genre  
  ✅ **Bar Chart**: Movie Count by Genre  
  ✅ **Line Chart**: Content Releases Over Time  
  ✅ **Table**: Most-Watched Movies  

---

##  2️⃣ Setup Instructions  

### **📌 Step 1: Install Required Tools**
- **Database:** Install [MySQL](https://dev.mysql.com/downloads/)  
- **Power BI:** Download [Power BI Desktop](https://powerbi.microsoft.com/)  
- **Python & Libraries:** Install dependencies  
  ```sh
  pip install pandas numpy pymysql sqlalchemy
  ```

---

### **📌 Step 2: Load Data into SQL Database**  
1. Open MySQL and create a database:  
   ```sql
   CREATE DATABASE Netflix;
   ```
2. Import the dataset into MySQL using Python.

---

### **📌 Step 3: Connect SQL Database to Power BI via ODBC**  
1. Install **MySQL ODBC Connector**  
2. Open **ODBC Data Source Administrator**  
3. Add a new **System DSN** for MySQL  
4. Open **Power BI → Get Data → ODBC**  
5. Select **MySQL DSN** → Load tables  

---

##  3️⃣ Project Outcomes & Insights  
📊 **Most-Watched Genre:** **Drama** is the most-watched genre on Netflix.  
🎬 **Highest Rated Genre:** **War** has the highest IMDb ratings despite fewer movies.  
📈 **Most Releases:** **2022 had the highest number of shows released.**  
🏆 **Most Watched Movie:** *The Shawshank Redemption* leads in watch count.  

---

## 4️⃣ Future Improvements 
🔹 Use **Machine Learning** to predict **popular movie trends**.  
🔹 Add a **recommendation system** based on **viewer preferences**.  
🔹 Expand analysis by including **user engagement data (likes, reviews, social media trends)**.  
