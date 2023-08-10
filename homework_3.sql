create database homework_3;
use homework_3;

-- Часть 1 Используемы таблицы: salespeople, customers, orders
create table  `salespeople` (
    `snum` INT NOT NULL,
    `sname` VARCHAR(10) NOT NULL,
    `city` VARCHAR(10) NOT NULL,
    `comm` DECIMAL(4, 2),
    PRIMARY KEY (`snum`)
);
select * from `salespeople`;

INSERT INTO salespeople(snum, sname, city, comm)
VALUES
    (1001, "Peel", "London", 0.12),
    (1002, "Serres", "San Jose", 0.13),
    (1004, "Motika", "London", 0.11),
    (1007, "Rifkin", "Barcelona", 0.15),
    (1003, "Axelrod", "New York", 0.10);
select * from `salespeople`;

create table if not exists customers (
    `cnum` INT NOT NULL,
    `cname` VARCHAR(10) NOT NULL,
    `city` VARCHAR(10) NOT NULL,
    `rating` INT,
    `snum` INT,
    PRIMARY KEY (`cnum`),
    FOREIGN KEY (`snum`) REFERENCES salespeople (`snum`)
	);
select *from customers;

INSERT INTO customers(cnum, cname, city, rating, snum)
VALUES
    (2001, "Hoffman", "London", 100, 1001),
    (2002, "Giovanni", "Rome", 200, 1003),
    (2003, "Liu", "San Jose", 200, 1002),
    (2004, "Grass", "Berlin", 300, 1002),
    (2006, "Clemens", "London", 100, 1001),
    (2008, "Cisneros", "San Jose", 300, 1007),
    (2007, "Pereira", "Rome", 100, 1004);
select *from customers;

DROP TABLE IF EXISTS orders;
CREATE TABLE IF NOT EXISTS `orders` (
    `onum` INT NOT NULL,
    `amt` DECIMAL(7,2) NOT NULL,
    `odate` VARCHAR(10) NOT NULL,
    `cnum` INT,
    `snum` INT,
    PRIMARY KEY (`onum`),
    FOREIGN KEY (`cnum`) REFERENCES customers (`cnum`),
    FOREIGN KEY (`snum`) REFERENCES salespeople (`snum`)
);

INSERT INTO orders(onum, amt, odate, cnum, snum)
VALUES
    (3001, 18.69, '10/03/1990', 2008, 1007),
    (3003, 767.19, '10/03/1990', 2001, 1001),
    (3002, 1900.10, '10/03/1990', 2007, 1004),
    (3005, 5160.45, '10/03/1990', 2003, 1002),
    (3006, 1098.16, '10/03/1990', 2008, 1007),
    (3009, 1713.23, '10/04/1990', 2002, 1003),
    (3007, 75.75, '10/04/1990', 2004, 1002),
    (3008, 4723.00, '10/05/1990', 2006, 1001),
    (3010, 1309.95, '10/06/1990', 2004, 1002),
    (3011, 9891.88, '10/06/1990', 2006, 1001);
select * from orders;

-- 1.1. Напишите запрос, который вывел бы таблицу со столбцами в следующем порядке: city, sname, snum, comm  (к первой или второй таблице, используя SELECT)

select city, sname, snum, comm from salespeople;

-- 1.2. Напишите команду SELECT, которая вывела бы оценку(rating), сопровождаемую именем каждого заказчика в городе San Jose. (“заказчики”)

select rating, cname, city from customers
	where city = 'San Jose';
    
-- 1.3. Напишите запрос, который вывел бы значения snum всех продавцов из таблицы заказов без каких бы то ни было повторений. (уникальные значения в “snum“ “Продавцы”)

select distinct snum from orders;

-- 1.4. Напишите запрос, который бы выбирал заказчиков, чьи имена начинаются с буквы G. Используется оператор "LIKE": (“заказчики”)

select cname from customers where  cname like 'G%';

-- 1.5. Напишите запрос, который может дать вам все заказы со значениями суммы выше чем $1,000. (“Заказы”, “amt” - сумма)

select * from orders
   where amt> 1000;
   
   -- 1.6. Напишите запрос который выбрал бы наименьшую сумму заказа. (Из поля “amt” - сумма в таблице “Заказы” выбрать наименьшее значение)
   
   select min(amt) as 'наименьшая сумма заказа'
    from  orders;
    
    -- АЛЕКСЕЙ, А МОЖНО КАК-ТО ВЫВЕСТИ ВСЮ СТРОКУ (как я сделал ниже), НО НЕ УКАЗЫВАЯ КОНКРЕТНОГО ЧИСЛА 18,69
    
    select onum, amt, odate, cnum, snum
    from  orders
    where amt = 18.69;
    
   -- 1.7. Напишите запрос к таблице “Заказчики”, который может показать всех заказчиков, у которых рейтинг больше 100 и они находятся не в Риме.
   
   select cname, city from customers
   where  rating >100 and city != "Rome";
   
-- Часть 2 Используемы таблицы: staff
   
   DROP TABLE IF EXISTS staff;
CREATE TABLE IF NOT EXISTS `staff` (
    `id` INT AUTO_INCREMENT,
    `first_name` VARCHAR(45),
    `last_name` VARCHAR(45),
    `post` VARCHAR(45),
    `seniority` INT,
    `salary` DECIMAL(8,2),
    `age` INT,
    PRIMARY KEY (`id`)
);

INSERT INTO staff(
    first_name, last_name, post, seniority, salary, age)
VALUES
    ("Вася", "Петров", "Начальник", 40, 100000, 60),
    ("Петр", "Власов", "Начальник", 8, 70000, 30),
    ("Катя", "Катина", "Инженер", 2, 70000, 25),
    ("Саша", "Сасин", "Инженер", 12, 50000, 35),
    ("Иван", "Петров", "Рабочий", 40, 30000, 59),
    ("Петр", "Петров", "Рабочий", 20, 55000, 60),
    ("Сидр", "Сидоров", "Рабочий", 10, 20000, 35),
    ("Антон", "Антонов", "Рабочий", 8, 19000, 28),
    ("Юрий", "Юрков", "Рабочий", 5, 15000, 25),
    ("Максим", "Петров", "Рабочий", 2, 11000, 19),
    ("Юрий", "Петров", "Рабочий", 3, 12000, 24),
    ("Людмила", "Маркина", "Уборщица", 10, 10000, 49);
select * from staff;
    
-- 2.1. Отсортируйте поле “зарплата” в порядке убывания и возрастания

select first_name, last_name, post, seniority, salary, age
	from staff 
	   order by salary; -- asc
       
select first_name, last_name, post, seniority, salary, age
	from staff 
	   order by salary desc;

-- 2.2. Отсортируйте по возрастанию поле “Зарплата” и выведите 5 строк с наибольшей заработной платой (возможен подзапрос)
-- 1 variant
select id, first_name, last_name, post, seniority, salary, age
	from staff 
	   order by salary
		limit 7,5;

-- 2 variant
select salary
	from staff 
	   order by salary desc
		limit 5;
        
select * from staff
	where salary in (select  salary
	from staff 
	   order by salary desc
		limit 5)   
	order by salary;
   
    ATTENTION:
    This version of MySQL doesn't yet support 'LIMIT & IN/ALL/ANY/SOME subquery'	

   

-- 2.3.Выполните группировку всех сотрудников по специальности , суммарная зарплата которых превышает 100000

SELECT 
post, 
SUM(salary) AS 'cуммарная зпл' 
FROM staff
group by post
having SUM(salary) > 100000;

		
			



   