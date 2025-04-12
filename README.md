# ph-L2-M6-B4-assignment

### 1. What is PostgreSQL?

    PostgreSQL একটি শক্তিশালী, ওপেন-সোর্স রিলেশনাল ডাটাবেস ম্যানেজমেন্ট সিস্টেম (RDBMS) যা SQL (Structured Query Language) সাপোর্ট করে। এটি বড় ডেটাসেট, কমপ্লেক্স কোয়েরি, এবং হাই-কনকারেন্সি এনভায়রনমেন্টের জন্য উপযুক্ত।

### 2. What is the purpose of a database schema in PostgreSQL?

    ডাটাবেস স্কিমা হলো এমন  একটি ধারনা বা সংজ্ঞা যেটা টেবিল, ভিউ, ফাংশন, ইনডেক্স, ও অন্যান্য অবজেক্টকে অরগানাইয এবং নিয়ন্ত্রণ করে
    উদাহরণ:

    CREATE SCHEMA myschema;
    CREATE TABLE myschema.customers (id SERIAL, name VARCHAR(100));

### 3. Explain the Primary Key and Foreign Key concepts in PostgreSQL.

    Primary Key (PK)
    ----------------
    একটি টেবিলের ইউনিকলি আইডেন্টিফাই করার ভ্যালু । এক বা একাধিক কলামের ডেটা নিয়ে Primary Key declare করা যায় । এটা কখনও NULL হতে পারবে না এবং ডুপ্লিকেট মান থাকতে পারবে  না।
    উদাহরণ:
    CREATE TABLE students (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100)
    );

    Foreign Key (FK)
    ----------------
    একটি টেবিলের Primary Key অন্য টেবিলে ব্যবহৃত হলে সেটাকে দ্বিতীয় টেবিলে Foreign Key বলে। এটি ডেটা রিলেশনশিপ (Relationships) তৈরি করে।
    উদাহরণ:
    CREATE TABLE orders (
        order_id SERIAL PRIMARY KEY,
        student_id INT REFERENCES students(id)
    );

### 4. What is the difference between the VARCHAR and CHAR data types?

    CHAR(n)
    -------
    Fixed-length: ফিক্সড-লেন্থ স্ট্রিং (ফাকা জায়গা স্পেস দিয়ে পূর্ণ করা হয়)। যেমন, CHAR(10) এ "abc" স্টোর করলে 'abc ' (7 স্পেস) হবে
    Storage: বেশি স্টোরেজ ব্যবহার করতে পারে।
    Use Cases: ফিক্সড-সাইজ ডেটা (যেমন: স্টেট কোড "CA", "NY")।
    Performance: কিছুটা ভাল কারণ ডেটাবেজ প্রত্যেকটা রেকর্ডের position জানে

    VARCHAR(n)
    ----------
    Fixed-length: ভ্যারিয়েবল-লেন্থ স্ট্রিং (স্পেস প্যাড করে না)। যেমন, VARCHAR(10) এ "abc" স্টোর করলে 'abc' (অতিরিক্ত স্পেস নেই)।
    Storage: মেমরি এফিশিয়েন্ট।
    Use Cases: ভ্যারিয়েবল-লেন্থ ডেটা (যেমন: নাম, এড্রেস)।
    Performance: CHAR এর তুলনায় কম

### 5. Explain the purpose of the WHERE clause in a SELECT statement.

    WHERE ক্লজ ব্যবহার করা হয় শর্তসাপেক্ষে ডাটা ফিল্টার করার জন্য। এটি শুধুমাত্র সেই রো(Row) গুলো রিটার্ন করে যেগুলো নির্দিষ্ট কন্ডিশন পূরণ করে।

    উদাহরণ:
    SELECT * FROM students WHERE age > 20;

    এটি শুধুমাত্র সেই ছাত্রদের ডাটা দেখাবে যাদের বয়স 20-এর বেশি।

### 6. What are the LIMIT and OFFSET clauses used for?

    LIMIT
    -----
    কোয়েরি রেজাল্টে কতগুলো রো রিটার্ন করবে তা নির্ধারণ করে।
    উদাহরণ:
    SELECT * FROM students LIMIT 5; -- প্রথম ৫টি রো দেখাবে

    OFFSET
    ------
    কোয়েরি রেজাল্টে কতগুলো রো স্কিপ করবে তা নির্ধারণ করে (পেজিনেশনে ব্যবহৃত)।
    উদাহরণ:
    SELECT * FROM students LIMIT 5 OFFSET 10; -- 11-15 নং রো দেখাবে

### 7. How can you modify data using UPDATE statements?

    UPDATE স্টেটমেন্ট একটা টেবিলের এক্সিস্টিং ডেটা আপডেট করে।

    Syntax:
    UPDATE table_name
    SET column1 = value1, column2 = value2
    WHERE condition;

    উদাহরণ:
    UPDATE students SET age = 22 WHERE id = 1;

    এটি students টেবিলে id=1 এর age কলাম 22-এ আপডেট করবে।

### 8. What is the significance of the JOIN operation, and how does it work in PostgreSQL?

    JOIN একাধিক টেবিল থেকে ডাটা কম্বাইন করে রিটার্ন করে।

    JOIN প্রকারভেদ:
    INNER JOIN: শুধুমাত্র ম্যাচিং রো রিটার্ন করে।
    LEFT JOIN: বাম টেবিলের সব রো + ডান টেবিলের ম্যাচিং রো।
    RIGHT JOIN: ডান টেবিলের সব রো + বাম টেবিলের ম্যাচিং রো।
    FULL JOIN: উভয় টেবিলের সব রো (ম্যাচিং বা না ম্যাচিং)।

    উদাহরণ (INNER JOIN):
    SELECT s.name, o.order_date
    FROM students s
    INNER JOIN orders o ON s.id = o.student_id;

### 9. Explain the GROUP BY clause and its role in aggregation operations.

    GROUP BY একই মানের রোগুলিকে গ্রুপ করে এবং এর সাথে এগ্রিগেট ফাংশন (COUNT, SUM, AVG ইত্যাদি) ব্যবহার করা যায়

    উদাহরণ:
    SELECT department, COUNT(*) AS total_students
    FROM students
    GROUP BY department;

    এটি প্রতিটি ডিপার্টমেন্টে কতজন ছাত্র আছে তা গণনা করবে।

### 10. How can you calculate aggregate functions like COUNT(), SUM(), and AVG() in PostgreSQL?

    COUNT(): রো সংখ্যা গণনা করে।
    SELECT COUNT(*) FROM students; -- মোট ছাত্র সংখ্যা

    SUM(): সংখ্যাসূচক কলামের যোগফল বের করে।
    SELECT SUM(salary) FROM employees; -- বেতনের যোগফল

    AVG(): সংখ্যাসূচক কলামের গড় বের করে।
    SELECT AVG(age) FROM students; -- ছাত্রদের গড় বয়স

    এই ফাংশনগুলি সাধারণত GROUP BY এর সাথে ব্যবহার করা হয়।
