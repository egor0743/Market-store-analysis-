create TABLE categories (
    category_id smallint NOT NULL,
    category_name character varying(15) NOT NULL,
    description text
);

create TABLE customers (
    customer_id bpchar NOT NULL,
    company_name character varying(40) NOT NULL,
    contact_name character varying(30),
    contact_title character varying(30),
    address character varying(60),
    city character varying(60),
    region character varying(60),
    postal_code character varying(10),
    country character varying(60),
    phone character varying(24),
    fax character varying(24)
);

CREATE TABLE employees (
    employee_id smallint NOT NULL,
    last_name character varying(20) NOT NULL,
    first_name character varying(10) NOT NULL,
    title character varying(30),
    title_of_courtesy character varying(25),
    birth_date date,
    hire_date date,
    address character varying(60),
    city character varying(15),
    region character varying(15),
    postal_code character varying(10),
    country character varying(15),
    home_phone character varying(24),
    extension character varying(4),
    photo bytea,
    notes text,
    reports_to smallint,
    photo_path character varying(255)
);

CREATE table employee_territories (
    employee_id smallint NOT NULL,
    territory_id character varying(20) NOT NULL
);

CREATE TABLE order_details (
    order_id smallint NOT NULL,
    product_id smallint NOT NULL,
    unit_price real NOT NULL,
    quantity smallint NOT NULL,
    discount real NOT NULL
);

CREATE TABLE orders (
    order_id smallint NOT NULL,
    customer_id bpchar,
    employee_id smallint,
    order_date date,
    required_date date,
    shipped_date date,
    ship_via smallint,
    freight real,
    ship_address character varying(60),
    ship_city character varying(15),
    ship_region character varying(15),
    ship_postal_code character varying(10),
    ship_country character varying(15)
);
alter table orders 
alter column ship_country set data type character varying(55);

   CREATE TABLE products (
    product_id smallint NOT NULL,
    product_name character varying(40) NOT NULL,
    supplier_id smallint,
    category_id smallint,
    quantity_per_unit character varying(20),
    unit_price real,
    units_in_stock smallint,
    units_on_order smallint,
    reorder_level smallint,
    discontinued integer NOT null
    );
 
CREATE TABLE region (
    region_id smallint NOT NULL,
    region_description bpchar NOT NULL
);

CREATE TABLE territories (
    territory_id character varying(20) NOT NULL,
    territory_description bpchar NOT NULL,
    region_id smallint NOT NULL
);

CREATE TABLE suppliers (
    supplier_id smallint NOT NULL,
    company_name character varying(40) NOT NULL,
    contact_name character varying(30),
    contact_title character varying(30),
    address character varying(60),
    city character varying(15),
    region character varying(15),
    postal_code character varying(10),
    country character varying(15),
    phone character varying(24),
    fax character varying(24),
    homepage text
   );

CREATE TABLE shippers (
    shipper_id smallint NOT NULL,
    company_name character varying(40) NOT NULL
);

CREATE TABLE calendar (
    calendar_date DATE PRIMARY KEY,
    month_number INT,
    year INT,
    month_name VARCHAR(20)
);

-- Primary keys

ALTER TABLE ONLY categories
    ADD CONSTRAINT pk_categories PRIMARY KEY (category_id); 

ALTER TABLE ONLY customers 
    ADD CONSTRAINT pk_customers PRIMARY KEY (customer_id);

ALTER TABLE ONLY employees
    ADD CONSTRAINT pk_employees PRIMARY KEY (employee_id);

ALTER TABLE ONLY employee_territories
    ADD CONSTRAINT pk_employee_territories PRIMARY KEY (employee_id, territory_id);

ALTER TABLE ONLY order_details
    ADD CONSTRAINT pk_order_details PRIMARY KEY (order_id, product_id);

ALTER TABLE ONLY orders 
    ADD CONSTRAINT pk_orders PRIMARY KEY (order_id);

ALTER TABLE ONLY products
    ADD CONSTRAINT pk_products PRIMARY KEY (product_id);

ALTER TABLE ONLY region
    ADD CONSTRAINT pk_region PRIMARY KEY (region_id);

ALTER TABLE ONLY shippers
    ADD CONSTRAINT pk_shippers PRIMARY KEY (shipper_id);

ALTER TABLE ONLY suppliers
    ADD CONSTRAINT pk_suppliers PRIMARY KEY (supplier_id);

ALTER TABLE ONLY territories
    ADD CONSTRAINT pk_territories PRIMARY KEY (territory_id);


-- FOREIGH KEYS

ALTER TABLE ONLY orders
    ADD CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES customers;

ALTER TABLE ONLY orders
    ADD CONSTRAINT fk_orders_employees FOREIGN KEY (employee_id) REFERENCES employees;

ALTER TABLE ONLY orders
    ADD CONSTRAINT fk_orders_shippers FOREIGN KEY (ship_via) REFERENCES shippers;

ALTER TABLE ONLY order_details
    ADD CONSTRAINT fk_order_details_products FOREIGN KEY (product_id) REFERENCES products;

ALTER TABLE ONLY order_details
    ADD CONSTRAINT fk_order_details_orders FOREIGN KEY (order_id) REFERENCES orders; 

ALTER TABLE ONLY products
    ADD CONSTRAINT fk_products_categories FOREIGN KEY (category_id) REFERENCES categories;

ALTER TABLE ONLY products
    ADD CONSTRAINT fk_products_suppliers FOREIGN KEY (supplier_id) REFERENCES suppliers; 

ALTER TABLE ONLY territories
    ADD CONSTRAINT fk_territories_region FOREIGN KEY (region_id) REFERENCES region;

ALTER TABLE ONLY employee_territories
    ADD CONSTRAINT fk_employee_territories_territories FOREIGN KEY (territory_id) REFERENCES territories; 

ALTER TABLE ONLY employee_territories
    ADD CONSTRAINT fk_employee_territories_employees FOREIGN KEY (employee_id) REFERENCES employees;

ALTER TABLE ONLY employees
    ADD CONSTRAINT fk_employees_employees FOREIGN KEY (reports_to) REFERENCES employees;
   
ALTER TABLE order_details 
	ADD CONSTRAINT order_det_date FOREIGN KEY (order_date) REFERENCES calendar (calendar_date);
   
 -- CATEGORIES 
INSERT INTO categories VALUES (1, 'Болти', 'Різні типи болтів, включаючи шестигранні, кареточні та кільцеві болти');
INSERT INTO categories VALUES (2, 'Гайки', 'Різні види гайок, такі як шестигранні, крилоподібні та самозатяжні гайки');
INSERT INTO categories VALUES (3, 'Шайби', 'Шайби, включаючи плоскі, пружинні та ущільнювальні шайби');
INSERT INTO categories VALUES (4, 'Метчики', 'Метчики для нарізання внутрішніх різьблень');
INSERT INTO categories VALUES (5, 'Плашки', 'Плашки для нарізання зовнішніх різьблень');
INSERT INTO categories VALUES (6, 'Свердла', 'Свердла для різних матеріалів і призначень');
INSERT INTO categories VALUES (7, 'Шурупи', 'Різні типи шурупів, включаючи дерев’яні, машинні та саморізи');
INSERT INTO categories VALUES (8, 'Анкери', 'Анкери для закріплення предметів на різних поверхнях');

-- PRODUCTS 

INSERT INTO products VALUES (1, 'Болт М6x30', 1, 1, '100 шт', 1.50, 200, 0, 50, 0);
INSERT INTO products VALUES (2, 'Гайка М6', 1, 2, '200 шт', 0.75, 300, 0, 100, 0);
INSERT INTO products VALUES (3, 'Шайба М6', 1, 3, '300 шт', 0.50, 500, 0, 150, 0);
INSERT INTO products VALUES (4, 'Шуруп 3x16', 2, 7, '50 шт', 2.00, 150, 20, 30, 0);
INSERT INTO products VALUES (5, 'Дюбель 6x30', 2, 8, '100 шт', 1.00, 400, 0, 100, 0);
INSERT INTO products VALUES (6, 'Саморіз 4x25', 3, 7, '200 шт', 1.20, 250, 30, 50, 0);
INSERT INTO products VALUES (7, 'Анкер 8x50', 3, 8, '50 шт', 2.50, 100, 0, 20, 0);
INSERT INTO products VALUES (8, 'Свердло 5 мм', 4, 6, '10 шт', 3.00, 80, 10, 20, 0);
INSERT INTO products VALUES (9, 'Свердло 8 мм', 4, 6, '10 шт', 4.00, 60, 15, 15, 0);
INSERT INTO products VALUES (10, 'Гвинт М8x40', 5, 1, '100 шт', 2.00, 120, 20, 40, 0);
INSERT INTO products VALUES (11, 'Гайка М8', 5, 2, '150 шт', 1.00, 200, 0, 50, 0);
INSERT INTO products VALUES (12, 'Шайба М8', 5, 3, '200 шт', 0.80, 300, 0, 75, 0);
INSERT INTO products VALUES (13, 'Пластина монтажна 50x100 мм', 6, 1, '20 шт', 5.00, 50, 5, 10, 0);
INSERT INTO products VALUES (14, 'Гачок стіновий', 6, 1, '30 шт', 1.50, 70, 10, 20, 0);
INSERT INTO products VALUES (15, 'Куточок 40x40 мм', 7, 1, '50 шт', 3.50, 100, 0, 30, 0);
INSERT INTO products VALUES (16, 'Куточок 60x60 мм', 7, 1, '30 шт', 4.50, 60, 0, 20, 0);
INSERT INTO products VALUES (17, 'Заклепка 4x10 мм', 8, 1, '100 шт', 1.00, 200, 0, 50, 0);
INSERT INTO products VALUES (18, 'Заклепка 5x15 мм', 8, 1, '100 шт', 1.50, 150, 0, 40, 0);
INSERT INTO products VALUES (19, 'Шуруп 5x50', 9, 7, '50 шт', 2.50, 100, 20, 25, 0);
INSERT INTO products VALUES (20, 'Анкер 10x60', 9, 8, '20 шт', 3.00, 80, 10, 20, 0);
INSERT INTO products VALUES (21, 'Гвинт М10x50', 10, 1, '100 шт', 2.50, 120, 20, 40, 0);
INSERT INTO products VALUES (22, 'Гайка М10', 10, 2, '150 шт', 1.20, 200, 0, 50, 0);
INSERT INTO products VALUES (23, 'Шайба М10', 10, 3, '200 шт', 0.90, 300, 0, 75, 0);
INSERT INTO products VALUES (24, 'Пластина монтажна 60x120 мм', 3, 1, '20 шт', 6.00, 50, 5, 10, 0);
INSERT INTO products VALUES (25, 'Гачок підвісний', 7, 1, '30 шт', 1.80, 70, 10, 20, 0);
INSERT INTO products VALUES (26, 'Куточок 80x80 мм', 10, 1, '30 шт', 5.50, 60, 0, 20, 0);
INSERT INTO products VALUES (27, 'Заклепка 6x20 мм', 9, 1, '100 шт', 2.00, 150, 0, 40, 0);
INSERT INTO products VALUES (28, 'Шуруп 6x70', 6, 7, '50 шт', 3.00, 100, 20, 25, 0);
INSERT INTO products VALUES (29, 'Анкер 12x80', 5, 8, '20 шт', 4.00, 80, 10, 20, 0);
INSERT INTO products VALUES (30, 'Гвинт М12x60', 4, 1, '100 шт', 3.00, 120, 20, 40, 0);

--  CUSTOMERS 
select * from products 

INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone, fax) VALUES
('BONDA', 'Торгівля і Ко', 'Бондарець Яків', 'Менеджер з продажу', 'Вул. Шевченка 15', 'Київ', NULL, '01001', 'Україна', '044-1234567', '044-7654321'),
('PETRO', 'Петрівський ринок', 'Петренко Олексій', 'Директор', 'Вул. Лесі Українки 10', 'Львів', NULL, '79000', 'Україна', '032-2345678', '032-8765432'),
('IVANO', 'Івано-Франківський торговий дім', 'Іванов Іван', 'Торговий представник', 'Вул. Мазепи 20', 'Івано-Франківськ', NULL, '76000', 'Україна', '0342-345678', '0342-876543'),
('SERHI', 'Сергіївський маркет', 'Сергієнко Марина', 'Адміністратор', 'Вул. Сумська 35', 'Харків', NULL, '61000', 'Україна', '057-4567890', '057-9876543'),
('ZHYTO', 'Житомирська торгова компанія', 'Житник Олена', 'Менеджер з продажу', 'Вул. Перемоги 12', 'Житомир', NULL, '10000', 'Україна', '0412-567890', '0412-678901'),
('OLEKS', 'Олександрійський супермаркет', 'Олександрова Світлана', 'Заступник директора', 'Вул. Грушевського 5', 'Олександрія', NULL, '28000', 'Україна', '05235-123456', '05235-654321'),
('DROHO', 'Дрогобицький базар', 'Дрогобиченко Віктор', 'Торговий агент', 'Вул. Котляревського 22', 'Дрогобич', NULL, '82100', 'Україна', '03244-234567', '03244-765432'),
('VINNY', 'Вінницька компанія', 'Вінничук Богдан', 'Менеджер з продажу', 'Вул. Соборна 45', 'Вінниця', NULL, '21000', 'Україна', '0432-345678', '0432-876543'),
('SUMYK', 'Сумський ринок', 'Сумська Наталія', 'Директор', 'Вул. Харківська 33', 'Суми', NULL, '40000', 'Україна', '0542-456789', '0542-987654'),
('CHERN', 'Чернігівська торгова мережа', 'Чернігівський Дмитро', 'Адміністратор', 'Вул. Миру 11', 'Чернігів', NULL, '14000', 'Україна', '0462-567890', '0462-678901'),
('POLTA', 'Полтавський супермаркет', 'Полтавенко Юлія', 'Менеджер з продажу', 'Вул. Жовтнева 20', 'Полтава', NULL, '36000', 'Україна', '0532-123456', '0532-654321'),
('KHERS', 'Херсонський ринок', 'Херсонський Олег', 'Торговий представник', 'Вул. Ушакова 28', 'Херсон', NULL, '73000', 'Україна', '0552-234567', '0552-765432'),
('DNPRO', 'Дніпропетровський супермаркет', 'Дніпренко Андрій', 'Директор', 'Проспект Гагаріна 100', 'Дніпро', NULL, '49000', 'Україна', '056-345678', '056-876543'),
('ODESA', 'Одеський торговий дім', 'Одеський Віктор', 'Заступник директора', 'Вул. Дерибасівська 14', 'Одеса', NULL, '65000', 'Україна', '048-456789', '048-987654'),
('LUCKI', 'Луцький базар', 'Луцький Василь', 'Менеджер з продажу', 'Вул. Лесі Українки 8', 'Луцьк', NULL, '43000', 'Україна', '0332-567890', '0332-678901'),
('UZHOR', 'Ужгородський ринок', 'Ужгородський Михайло', 'Адміністратор', 'Вул. Корзо 16', 'Ужгород', NULL, '88000', 'Україна', '0312-123456', '0312-654321'),
('TERNO', 'Тернопільський супермаркет', 'Тернопільський Ігор', 'Торговий агент', 'Вул. Руська 2', 'Тернопіль', NULL, '46000', 'Україна', '0352-234567', '0352-765432'),
('RIVNE', 'Рівненська компанія', 'Рівненко Володимир', 'Менеджер з продажу', 'Вул. Соборна 7', 'Рівне', NULL, '33000', 'Україна', '0362-345678', '0362-876543'),
('CHENR', 'Черкаська торгова мережа', 'Черкаський Петро', 'Директор', 'Вул. Смілянська 12', 'Черкаси', NULL, '18000', 'Україна', '0472-456789', '0472-987654'),
('KHMEL', 'Хмельницький супермаркет', 'Хмельницький Сергій', 'Заступник директора', 'Вул. Кам’янецька 5', 'Хмельницький', NULL, '29000', 'Україна', '0382-567890', '0382-678901'),
('ZAPOR', 'Запорізький ринок', 'Запорізька Оксана', 'Адміністратор', 'Вул. Соборна 22', 'Запоріжжя', NULL, '69000', 'Україна', '061-123456', '061-654321'),
('CHERB', 'Чернівецький торговий дім', 'Чернівецький Микола', 'Торговий представник', 'Вул. Головна 40', 'Чернівці', NULL, '58000', 'Україна', '0372-234567', '0372-765432'),
('MYKOL', 'Миколаївський супермаркет', 'Миколаївський Дмитро', 'Директор', 'Проспект Центральний 15', 'Миколаїв', NULL, '54000', 'Україна', '0512-345678', '0512-876543'),
('IVAN2', 'Івано-Франківський ринок', 'Івано-Франківський Олег', 'Менеджер з продажу', 'Вул. Незалежності 30', 'Івано-Франківськ', NULL, '76000', 'Україна', '0342-456789', '0342-987654'),
('SUMSK', 'Сумська торгова мережа', 'Сумський Юрій', 'Адміністратор', 'Вул. Троїцька 17', 'Суми', NULL, '40000', 'Україна', '0542-567890', '0542-678901'),
('POLT2', 'Полтавська компанія', 'Полтавенко Анастасія', 'Торговий агент', 'Вул. Європейська 25', 'Полтава', NULL, '36000', 'Україна', '0532-123456', '0532-654321'),
('LVIV2', 'Львівський ринок', 'Львівський Віктор', 'Менеджер з продажу', 'Вул. Городоцька 50', 'Львів', NULL, '79000', 'Україна', '032-2345678', '032-8765432'),
('KHARK', 'Харківський базар', 'Харківський Олександр', 'Директор', 'Вул. Сумська 28', 'Харків', NULL, '61000', 'Україна', '057-3456789', '057-9876543'),
('DNIP2', 'Дніпровський супермаркет', 'Дніпропетровська Ольга', 'Заступник директора', 'Вул. Глинки 40', 'Дніпро', NULL, '49000', 'Україна', '056-1234567', '056-7654321'),
('ODES2', 'Одеська торгова мережа', 'Одеський Михайло', 'Торговий представник', 'Вул. Пушкінська 18', 'Одеса', NULL, '65000', 'Україна', '048-4567890', '048-9876543'),
('KYIV2', 'Київський ринок', 'Київський Артем', 'Менеджер з продажу', 'Проспект Перемоги 30', 'Київ', NULL, '01000', 'Україна', '044-5678901', '044-6789012'),
('ZHITO2', 'Житомирський базар', 'Житомирський Павло', 'Адміністратор', 'Вул. Київська 5', 'Житомир', NULL, '10000', 'Україна', '0412-345678', '0412-876543'),
('LVIVK', 'Львівська торгова компанія', 'Львівська Анна', 'Директор', 'Вул. Коперника 7', 'Львів', NULL, '79000', 'Україна', '032-1234567', '032-7654321');

	select * from customers c 
	truncate table customers 
select * from customers c 
where customer_id in ( 
	select customer_id 
	from customers c
	group by customer_id  
	having count(customer_id) > 1 )
	
-- EMPLOYEES

INSERT INTO employees VALUES (1, 'Друзь', 'Ілля', 'Продавець-консультант', 'Пан', '1988-07-12', '2015-03-01', 'Вул. Лесі Українки 12', 'Київ', NULL, '01001', 'Україна', '(044) 123-4567', '1234', '\x', 'Має ступінь бакалавра з економіки. Працює в компанії з 2015 року.', 2, 'http://accweb/employees/druz.bmp');
INSERT INTO employees VALUES (2, 'Юрков', 'Федя', 'Менеджер з продажу', 'Пан', '1990-04-23', '2016-06-10', 'Вул. Грушевського 8', 'Львів', NULL, '79000', 'Україна', '(032) 234-5678', '5678', '\x', 'Здобув ступінь магістра з маркетингу. Працює в компанії з 2016 року.', 1, 'http://accweb/employees/yurkov.bmp');
INSERT INTO employees VALUES (3, 'Милохін', 'Даня', 'Заступник директора', 'Пан', '1985-11-15', '2012-09-05', 'Вул. Соборна 15', 'Одеса', NULL, '65000', 'Україна', '(048) 345-6789', '6789', '\x', 'Здобув ступінь магістра з менеджменту. Працює в компанії з 2012 року.', NULL, 'http://accweb/employees/milokhin.bmp');
INSERT INTO employees VALUES (4, 'Андрей', 'Зайців', 'Директор з маркетингу', 'Пан', '1989-02-05', '2013-11-20', 'Проспект Перемоги 20', 'Дніпро', NULL, '49000', 'Україна', '(056) 456-7890', '7890', '\x', 'Має ступінь доктора філософії з маркетингу. Працює в компанії з 2013 року.', 3, 'http://accweb/employees/kreed.bmp');
INSERT INTO employees VALUES (5, 'Міжело', 'Олег', 'Керівник відділу', 'Пан', '1992-06-30', '2017-02-15', 'Вул. Тараса Шевченка 22', 'Харків', NULL, '61000', 'Україна', '(057) 567-8901', '8901', '\x', 'Здобув ступінь бакалавра з управління. Працює в компанії з 2017 року.', 4, 'http://accweb/employees/mizhelo.bmp');
INSERT INTO employees VALUES (6, 'Карнавал', 'Валя', 'Адміністратор', 'Пані', '1995-03-14', '2018-08-22', 'Вул. Жовтнева 10', 'Полтава', NULL, '36000', 'Україна', '(0532) 678-9012', '9012', '\x', 'Має ступінь бакалавра з адміністративних наук. Працює в компанії з 2018 року.', 5, 'http://accweb/employees/karnaval.bmp');
INSERT INTO employees VALUES (7, 'Мирош', 'Нікіта', 'Інженер з продажу', 'Пан', '1993-09-25', '2019-01-10', 'Вул. Пушкінська 14', 'Запоріжжя', NULL, '69000', 'Україна', '(061) 789-0123', '0123', '\x', 'Має ступінь бакалавра з інженерії. Працює в компанії з 2019 року.', 6, 'http://accweb/employees/miroshnik.bmp');
INSERT INTO employees VALUES (8, 'Голубін', 'Гліб', 'ІТ-спеціаліст', 'Пан', '1994-11-02', '2020-07-01', 'Вул. Незалежності 5', 'Херсон', NULL, '73000', 'Україна', '(0552) 890-1234', '1234', '\x', 'Має ступінь бакалавра з інформаційних технологій. Працює в компанії з 2020 року.', 7, 'http://accweb/employees/golubin.bmp');

-- employee_territories 
INSERT INTO employee_territories VALUES (1, '01581');
INSERT INTO employee_territories VALUES (2, '01730');
INSERT INTO employee_territories VALUES (2, '01833');
INSERT INTO employee_territories VALUES (3, '02108');
INSERT INTO employee_territories VALUES (3, '02215');
INSERT INTO employee_territories VALUES (4, '02467');
INSERT INTO employee_territories VALUES (4, '02720');
INSERT INTO employee_territories VALUES (4, '02780');
INSERT INTO employee_territories VALUES (5, '02903');
INSERT INTO employee_territories VALUES (5, '02860');
INSERT INTO employee_territories VALUES (6, '03060');
INSERT INTO employee_territories VALUES (6, '03101');
INSERT INTO employee_territories VALUES (7, '03301');
INSERT INTO employee_territories VALUES (7, '03431');
INSERT INTO employee_territories VALUES (8, '03755');
INSERT INTO employee_territories VALUES (8, '03801');
INSERT INTO employee_territories VALUES (8, '04011');

-- Order_details 
select * from order_details

INSERT INTO order_details (order_id, product_id, unit_price, quantity, discount) VALUES
(10851, 1, 22.0, 15, 0.0),
(10851, 2, 18.0, 25, 0.05),
(10851, 3, 30.0, 20, 0.1),
(10852, 4, 22.0, 10, 0.0),
(10852, 5, 30.0, 5, 0.0),
(10853, 6, 18.0, 50, 0.1),
(10853, 7, 22.0, 20, 0.0),
(10854, 8, 30.0, 10, 0.0),
(10854, 9, 18.0, 15, 0.05),
(10855, 10, 22.0, 30, 0.0),
(10855, 11, 30.0, 25, 0.05),
(10856, 12, 18.0, 35, 0.0),
(10856, 13, 22.0, 40, 0.0),
(10857, 14, 30.0, 20, 0.1),
(10857, 15, 18.0, 10, 0.0),
(10858, 16, 22.0, 15, 0.0),
(10858, 17, 30.0, 35, 0.0),
(10859, 18, 18.0, 25, 0.05),
(10859, 19, 22.0, 45, 0.0),
(10860, 20, 30.0, 15, 0.0),
(10860, 21, 18.0, 10, 0.0),
(10861, 22, 22.0, 50, 0.0),
(10861, 23, 30.0, 40, 0.05),
(10862, 24, 18.0, 30, 0.0),
(10862, 25, 22.0, 20, 0.0),
(10863, 26, 30.0, 10, 0.1),
(10863, 27, 18.0, 15, 0.0),
(10864, 28, 22.0, 25, 0.0),
(10864, 29, 30.0, 35, 0.0),
(10865, 30, 18.0, 45, 0.0),
(10865, 1, 22.0, 30, 0.0),
(10866, 2, 30.0, 20, 0.1),
(10866, 3, 18.0, 50, 0.0),
(10867, 4, 22.0, 15, 0.0),
(10867, 5, 30.0, 25, 0.05),
(10868, 6, 18.0, 35, 0.0),
(10868, 7, 22.0, 40, 0.0),
(10869, 8, 30.0, 20, 0.1),
(10869, 9, 18.0, 10, 0.0),
(10870, 10, 22.0, 15, 0.0),
(10870, 11, 30.0, 35, 0.0),
(10871, 12, 18.0, 25, 0.05),
(10871, 13, 22.0, 45, 0.0),
(10872, 14, 30.0, 15, 0.0),
(10872, 15, 18.0, 10, 0.0),
(10873, 16, 22.0, 50, 0.0),
(10873, 17, 30.0, 40, 0.05),
(10874, 18, 18.0, 30, 0.0),
(10874, 19, 22.0, 20, 0.0),
(10875, 20, 30.0, 10, 0.1),
(10875, 21, 18.0, 15, 0.0),
(10876, 22, 22.0, 25, 0.0),
(10876, 23, 30.0, 35, 0.0),
(10877, 24, 18.0, 45, 0.0),
(10877, 25, 22.0, 30, 0.0),
(10878, 26, 30.0, 20, 0.1),
(10878, 27, 18.0, 50, 0.0),
(10879, 28, 22.0, 15, 0.0),
(10879, 29, 30.0, 25, 0.05),
(10880, 30, 18.0, 35, 0.0),
(10880, 1, 22.0, 40, 0.0)

-- Orders 
INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight, ship_address, ship_city, ship_region, ship_postal_code, ship_country) VALUES
(10851, 'BONDA', 5, '2022-07-04', '2022-07-16', '2022-07-10', 3, 32.38, 'Вул. Шевченка 15', 'Київ', NULL, '01001', 'Україна'),
(10852, 'PETRO', 6, '2022-07-05', '2022-08-16', '2022-07-12', 1, 11.61, 'Вул. Лесі Українки 10', 'Львів', NULL, '79000', 'Україна'),
(10853, 'IVANO', 4, '2022-07-08', '2022-08-16', '2022-07-15', 2, 65.83, 'Вул. Мазепи 20', 'Івано-Франківськ', NULL, '76000', 'Україна'),
(10854, 'SERHI', 3, '2022-07-08', '2022-08-16', '2022-07-15', 1, 41.34, 'Вул. Сумська 35', 'Харків', NULL, '61000', 'Україна'),
(10855, 'ZHYTO', 4, '2022-07-09', '2022-08-16', '2022-07-16', 2, 51.30, 'Вул. Перемоги 12', 'Житомир', NULL, '10000', 'Україна'),
(10856, 'OLEKS', 3, '2022-07-10', '2022-08-16', '2022-07-17', 3, 58.17, 'Вул. Грушевського 5', 'Олександрія', NULL, '28000', 'Україна'),
(10857, 'DROHO', 4, '2022-07-11', '2022-08-16', '2022-07-18', 2, 22.98, 'Вул. Котляревського 22', 'Дрогобич', NULL, '82100', 'Україна'),
(10858, 'VINNY', 1, '2022-07-12', '2022-08-16', '2022-07-19', 2, 148.33, 'Вул. Соборна 45', 'Вінниця', NULL, '21000', 'Україна'),
(10859, 'SUMYK', 8, '2022-07-15', '2022-08-16', '2022-07-22', 2, 13.97, 'Вул. Харківська 33', 'Суми', NULL, '40000', 'Україна'),
(10860, 'CHERN', 3, '2022-07-16', '2022-08-16', '2022-07-23', 3, 81.91, 'Вул. Миру 11', 'Чернігів', NULL, '14000', 'Україна'),
(10861, 'POLTA', 2, '2022-07-17', '2022-08-16', '2022-07-24', 1, 140.51, 'Вул. Жовтнева 20', 'Полтава', NULL, '36000', 'Україна'),
(10862, 'KHERS', 4, '2022-07-18', '2022-08-16', '2022-07-25', 3, 3.25, 'Вул. Ушакова 28', 'Херсон', NULL, '73000', 'Україна'),
(10863, 'DNPRO', 2, '2022-07-19', '2022-08-16', '2022-07-26', 1, 55.09, 'Проспект Гагаріна 100', 'Дніпро', NULL, '49000', 'Україна'),
(10864, 'ODESA', 1, '2022-07-20', '2022-08-16', '2022-07-27', 3, 148.33, 'Вул. Дерибасівська 14', 'Одеса', NULL, '65000', 'Україна'),
(10865, 'LUCKI', 7, '2022-07-22', '2022-08-16', '2022-07-29', 3, 6.55, 'Вул. Лесі Українки 8', 'Луцьк', NULL, '43000', 'Україна'),
(10866, 'UZHOR', 8, '2022-07-23', '2022-08-16', '2022-07-30', 2, 3.05, 'Вул. Корзо 16', 'Ужгород', NULL, '88000', 'Україна'),
(10867, 'TERNO', 6, '2022-07-24', '2022-08-16', '2022-07-31', 3, 55.09, 'Вул. Руська 2', 'Тернопіль', NULL, '46000', 'Україна'),
(10868, 'RIVNE', 8, '2022-07-25', '2022-08-16', '2022-08-01', 1, 5.74, 'Вул. Соборна 7', 'Рівне', NULL, '33000', 'Україна'),
(10869, 'CHENR', 2, '2022-07-26', '2022-08-16', '2022-08-02', 2, 7.45, 'Вул. Смілянська 12', 'Черкаси', NULL, '18000', 'Україна'),
(10870, 'KHMEL', 4, '2022-07-27', '2022-08-16', '2022-08-03', 3, 17.68, 'Вул. Кам’янецька 5', 'Хмельницький', NULL, '29000', 'Україна'),
(10871, 'ZAPOR', 3, '2022-07-28', '2022-08-16', '2022-08-04', 2, 97.64, 'Вул. Соборна 22', 'Запоріжжя', NULL, '69000', 'Україна'),
(10872, 'CHERB', 1, '2022-07-29', '2022-08-16', '2022-08-05', 3, 53.05, 'Вул. Головна 40', 'Чернівці', NULL, '58000', 'Україна'),
(10873, 'MYKOL', 5, '2022-07-30', '2022-08-16', '2022-08-06', 1, 81.91, 'Проспект Центральний 15', 'Миколаїв', NULL, '54000', 'Україна'),
(10874, 'IVAN2', 6, '2022-07-31', '2022-08-16', '2022-08-07', 3, 7.45, 'Вул. Незалежності 30', 'Івано-Франківськ', NULL, '76000', 'Україна'),
(10875, 'SUMSK', 2, '2022-08-01', '2022-08-16', '2022-08-08', 2, 17.68, 'Вул. Троїцька 17', 'Суми', NULL, '40000', 'Україна'),
(10876, 'POLT2', 3, '2022-08-02', '2022-08-16', '2022-08-09', 3, 97.64, 'Вул. Європейська 25', 'Полтава', NULL, '36000', 'Україна'),
(10877, 'LVIV2', 4, '2022-08-03', '2022-08-16', '2022-08-10', 1, 53.05, 'Вул. Городоцька 50', 'Львів', NULL, '79000', 'Україна'),
(10878, 'KHARK', 5, '2022-08-04', '2022-08-16', '2022-08-11', 3, 81.91, 'Проспект Науки 33', 'Харків', NULL, '61000', 'Україна'),
(10879, 'KYIV2', 6, '2022-08-05', '2022-08-16', '2022-08-12', 2, 7.45, 'Вул. Хрещатик 19', 'Київ', NULL, '01001', 'Україна'),
(10880, 'ODES2', 3, '2022-08-06', '2022-08-16', '2022-08-13', 1, 5.74, 'Вул. Пушкінська 6', 'Одеса', NULL, '65000', 'Україна');
 
-- Region

INSERT INTO region VALUES (1, 'Східна Україна');
INSERT INTO region VALUES (2, 'Західна Україна');
INSERT INTO region VALUES (3, 'Північна Україна');
INSERT INTO region VALUES (4, 'Південна Україна');

-- Territories 

INSERT INTO territories (territory_id, territory_description, region_id) VALUES
('01581', 'Львів', 1),
('01730', 'Івано-Франківськ', 1),
('01833', 'Чернівці', 1),
('02108', 'Київ', 2),
('02215', 'Львівська область', 2),
('02467', 'Тернопіль', 2),
('02720', 'Одеса', 3),
('02780', 'Миколаїв', 3),
('02860', 'Херсон', 3),
('02903', 'Запоріжжя', 3),
('03060', 'Харків', 4),
('03101', 'Полтава', 4),
('03301', 'Суми', 4),
('03431', 'Чернігів', 4),
('03755', 'Житомир', 1),
('03801', 'Вінниця', 1),
('04011', 'Кропивницький', 2),
('04101', 'Черкаси', 2),
('04401', 'Ужгород', 3),
('04530', 'Мукачево', 3);

-- Shippers

INSERT INTO shippers VALUES (1, 'Нова Пошта');
INSERT INTO shippers VALUES (2, 'Укрпошта');
INSERT INTO shippers VALUES (3, 'Meest');

-- Suplliers 

INSERT INTO suppliers VALUES (1, 'Exotic Liquids', 'Charlotte Cooper', 'Purchasing Manager', '49 Gilbert St.', 'London', NULL, 'EC1 4SD', 'UK', '(171) 555-2222', NULL, NULL);
INSERT INTO suppliers VALUES (2, 'New Orleans Cajun Delights', 'Shelley Burke', 'Order Administrator', 'P.O. Box 78934', 'New Orleans', 'LA', '70117', 'USA', '(100) 555-4822', NULL, '#CAJUN.HTM#');
INSERT INTO suppliers VALUES (3, 'ARMSTED', 'Regina Murphy', 'Sales Representative', '707 Oxford Rd.', 'Ann Arbor', 'MI', '48104', 'USA', '(313) 555-5735', '(313) 555-3349', NULL);
INSERT INTO suppliers VALUES (4, 'Tokyo Traders', 'Yoshi Nagase', 'Marketing Manager', '9-8 Sekimai Musashino-shi', 'Tokyo', NULL, '100', 'Japan', '(03) 3555-5011', NULL, NULL);
INSERT INTO suppliers VALUES (5, 'Cooperativa de Quesos ''Las Cabras''', 'Antonio del Valle Saavedra', 'Export Administrator', 'Calle del Rosal 4', 'Oviedo', 'Asturias', '33007', 'Spain', '(98) 598 76 54', NULL, NULL);
INSERT INTO suppliers VALUES (6, 'Mayumi''s', 'Mayumi Ohno', 'Marketing Representative', '92 Setsuko Chuo-ku', 'Osaka', NULL, '545', 'Japan', '(06) 431-7877', NULL, 'Mayumi''s (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/mayumi.htm#');
INSERT INTO suppliers VALUES (7, 'Pavlova, Ltd.', 'Ian Devling', 'Marketing Manager', '74 Rose St. Moonie Ponds', 'Melbourne', 'Victoria', '3058', 'Australia', '(03) 444-2343', '(03) 444-6588', NULL);
INSERT INTO suppliers VALUES (8, 'Specialty Ltd.', 'Peter Wilson', 'Sales Representative', '29 King''s Way', 'Manchester', NULL, 'M14 GSD', 'UK', '(161) 555-4448', NULL, NULL);
INSERT INTO suppliers VALUES (9, 'PB Knäckebröd AB', 'Lars Peterson', 'Sales Agent', 'Kaloadagatan 13', 'Göteborg', NULL, 'S-345 67', 'Sweden', '031-987 65 43', '031-987 65 91', NULL);
INSERT INTO suppliers VALUES (10, 'Refrescos Americanas LTDA', 'Carlos Diaz', 'Marketing Manager', 'Av. das Americanas 12.890', 'Sao Paulo', NULL, '5442', 'Brazil', '(11) 555 4640', NULL, NULL);

-- Calendar 

INSERT INTO calendar (calendar_date, month_number, year, month_name) VALUES
('2023-01-01', 1, 2023, 'January'),
('2023-01-11', 1, 2023, 'January'),
('2023-01-21', 1, 2023, 'January'),
('2023-02-10', 2, 2023, 'February'),
('2023-02-20', 2, 2023, 'February'),
('2023-03-20', 3, 2023, 'March'),
('2023-03-30', 3, 2023, 'March'),
('2023-04-01', 4, 2023, 'April'),
('2023-04-10', 4, 2023, 'April'),
('2023-04-20', 4, 2023, 'April'),
('2023-05-10', 5, 2023, 'May'),
('2023-05-20', 5, 2023, 'May'),
('2023-06-10', 6, 2023, 'June'),
('2023-06-20', 6, 2023, 'June'),
('2023-07-01', 7, 2023, 'July'),
('2023-07-11', 7, 2023, 'July'),
('2023-07-21', 7, 2023, 'July'),
('2023-08-10', 8, 2023, 'August'),
('2023-08-20', 8, 2023, 'August'),
('2023-09-10', 9, 2023, 'September'),
('2023-09-20', 9, 2023, 'September'),
('2023-10-01', 10, 2023, 'October'),
('2023-10-10', 10, 2023, 'October'),
('2023-10-20', 10, 2023, 'October'),
('2023-11-10', 11, 2023, 'November'),
('2023-11-20', 11, 2023, 'November'),
('2023-12-10', 12, 2023, 'December'),
('2023-12-20', 12, 2023, 'December');

ALTER TABLE order_details ADD COLUMN order_date DATE;

-- January
UPDATE order_details SET order_date = '2023-01-01' WHERE order_id BETWEEN 10851 AND 10853;

-- February
UPDATE order_details SET order_date = '2023-02-10' WHERE order_id BETWEEN 10854 AND 10856;

-- March
UPDATE order_details SET order_date = '2023-03-20' WHERE order_id BETWEEN 10857 AND 10859;

-- April
UPDATE order_details SET order_date = '2023-04-01' WHERE order_id BETWEEN 10860 AND 10862;

-- May
UPDATE order_details SET order_date = '2023-05-10' WHERE order_id BETWEEN 10863 AND 10865;

-- June
UPDATE order_details SET order_date = '2023-06-20' WHERE order_id BETWEEN 10866 AND 10868;

-- July
UPDATE order_details SET order_date = '2023-07-01' WHERE order_id BETWEEN 10869 AND 10871;

-- August
UPDATE order_details SET order_date = '2023-08-10' WHERE order_id BETWEEN 10872 AND 10874;

-- September
UPDATE order_details SET order_date = '2023-09-20' WHERE order_id BETWEEN 10875 AND 10877;

-- October
UPDATE order_details SET order_date = '2023-10-01' WHERE order_id BETWEEN 10878 AND 10879;

-- November
UPDATE order_details SET order_date = '2023-11-10' WHERE order_id BETWEEN 10880 AND 10880;

-- December
UPDATE order_details SET order_date = '2023-12-20' WHERE order_id = 10880;
