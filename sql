---------------------------------------------------------
-- 1. TABLES
---------------------------------------------------------
CREATE TABLE Cuisine (
    cuisine_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL
);

CREATE TABLE Dish (
    dish_id NUMBER PRIMARY KEY,
    cuisine_id NUMBER,
    name VARCHAR2(100) NOT NULL,
    description VARCHAR2(255),
    is_vegetarian CHAR(1) CHECK (is_vegetarian IN ('Y','N')),
    popularity NUMBER,
    price NUMBER(10,2),
    image_url VARCHAR2(255),
    FOREIGN KEY (cuisine_id) REFERENCES Cuisine(cuisine_id)
);

CREATE TABLE Ingredient (
    ingredient_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    unit VARCHAR2(50),
    stock_quantity NUMBER(10,2),
    reorder_level NUMBER(10,2)
);

CREATE TABLE Chef (
    chef_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    specialty VARCHAR2(100)
);

CREATE TABLE DishIngredient (
    dish_id NUMBER,
    ingredient_id NUMBER,
    required_quantity NUMBER(10,2),
    PRIMARY KEY (dish_id, ingredient_id),
    FOREIGN KEY (dish_id) REFERENCES Dish(dish_id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredient(ingredient_id)
);

CREATE TABLE DishChef (
    dish_id NUMBER,
    chef_id NUMBER,
    PRIMARY KEY (dish_id, chef_id),
    FOREIGN KEY (dish_id) REFERENCES Dish(dish_id),
    FOREIGN KEY (chef_id) REFERENCES Chef(chef_id)
);

CREATE TABLE Users (
    user_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE,
    password_hash VARCHAR2(255),
    role VARCHAR2(50)
);

CREATE TABLE InventoryLog (
    log_id NUMBER PRIMARY KEY,
    ingredient_id NUMBER,
    user_id NUMBER,
    change_quantity NUMBER(10,2),
    action_type VARCHAR2(50),
    log_timestamp TIMESTAMP,
    FOREIGN KEY (ingredient_id) REFERENCES Ingredient(ingredient_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

---------------------------------------------------------
-- 2. SEQUENCES + TRIGGERS (Auto IDs)
---------------------------------------------------------
-- Cuisine
CREATE SEQUENCE cuisine_seq START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER cuisine_bi
BEFORE INSERT ON Cuisine
FOR EACH ROW
BEGIN
   :NEW.cuisine_id := cuisine_seq.NEXTVAL;
END;
/

-- Dish
CREATE SEQUENCE dish_seq START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER dish_bi
BEFORE INSERT ON Dish
FOR EACH ROW
BEGIN
   :NEW.dish_id := dish_seq.NEXTVAL;
END;
/

-- Ingredient
CREATE SEQUENCE ingredient_seq START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER ingredient_bi
BEFORE INSERT ON Ingredient
FOR EACH ROW
BEGIN
   :NEW.ingredient_id := ingredient_seq.NEXTVAL;
END;
/

-- Chef
CREATE SEQUENCE chef_seq START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER chef_bi
BEFORE INSERT ON Chef
FOR EACH ROW
BEGIN
   :NEW.chef_id := chef_seq.NEXTVAL;
END;
/

-- Users
CREATE SEQUENCE user_seq START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER user_bi
BEFORE INSERT ON Users
FOR EACH ROW
BEGIN
   :NEW.user_id := user_seq.NEXTVAL;
END;
/

-- InventoryLog
CREATE SEQUENCE log_seq START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER log_bi
BEFORE INSERT ON InventoryLog
FOR EACH ROW
BEGIN
   :NEW.log_id := log_seq.NEXTVAL;
END;
/

---------------------------------------------------------
-- 3. SAMPLE DATA (IDs auto-generated)
---------------------------------------------------------
-- Cuisine
INSERT INTO Cuisine (name) VALUES ('Italian');
INSERT INTO Cuisine (name) VALUES ('Indian');
INSERT INTO Cuisine (name) VALUES ('Chinese');

-- Dish
INSERT INTO Dish (cuisine_id, name, description, is_vegetarian, popularity, price, image_url)
VALUES (1, 'Margherita Pizza', 'Classic cheese pizza', 'Y', 85, 299.00, 'pizza.jpg');

INSERT INTO Dish (cuisine_id, name, description, is_vegetarian, popularity, price, image_url)
VALUES (2, 'Butter Chicken', 'Creamy chicken curry', 'N', 95, 399.00, 'butter_chicken.jpg');

INSERT INTO Dish (cuisine_id, name, description, is_vegetarian, popularity, price, image_url)
VALUES (3, 'Fried Rice', 'Veg fried rice with soy sauce', 'Y', 75, 199.00, 'fried_rice.jpg');

-- Ingredient
INSERT INTO Ingredient (name, unit, stock_quantity, reorder_level) VALUES ('Tomato', 'kg', 50, 10);
INSERT INTO Ingredient (name, unit, stock_quantity, reorder_level) VALUES ('Cheese', 'kg', 20, 5);
INSERT INTO Ingredient (name, unit, stock_quantity, reorder_level) VALUES ('Chicken', 'kg', 30, 5);
INSERT INTO Ingredient (name, unit, stock_quantity, reorder_level) VALUES ('Rice', 'kg', 100, 20);
INSERT INTO Ingredient (name, unit, stock_quantity, reorder_level) VALUES ('Butter', 'kg', 15, 3);

-- Chef
INSERT INTO Chef (name, specialty) VALUES ('Giovanni Rossi', 'Italian Cuisine');
INSERT INTO Chef (name, specialty) VALUES ('Rajesh Sharma', 'Indian Cuisine');
INSERT INTO Chef (name, specialty) VALUES ('Li Wei', 'Chinese Cuisine');

-- DishIngredient
INSERT INTO DishIngredient VALUES (1, 1, 0.5);
INSERT INTO DishIngredient VALUES (1, 2, 0.3);
INSERT INTO DishIngredient VALUES (2, 3, 0.5);
INSERT INTO DishIngredient VALUES (2, 5, 0.2);
INSERT INTO DishIngredient VALUES (3, 4, 0.5);

-- DishChef
INSERT INTO DishChef VALUES (1, 1);
INSERT INTO DishChef VALUES (2, 2);
INSERT INTO DishChef VALUES (3, 3);

-- Users
INSERT INTO Users (name, email, password_hash, role) VALUES ('Admin User', 'admin@example.com', 'hashed_pw1', 'admin');
INSERT INTO Users (name, email, password_hash, role) VALUES ('Kitchen Staff', 'staff@example.com', 'hashed_pw2', 'staff');

-- InventoryLog
INSERT INTO InventoryLog (ingredient_id, user_id, change_quantity, action_type, log_timestamp)
VALUES (1, 2, -2.0, 'Used', TIMESTAMP '2025-08-28 12:00:00');

INSERT INTO InventoryLog (ingredient_id, user_id, change_quantity, action_type, log_timestamp)
VALUES (3, 2, -1.0, 'Used', TIMESTAMP '2025-08-28 13:00:00');

INSERT INTO InventoryLog (ingredient_id, user_id, change_quantity, action_type, log_timestamp)
VALUES (4, 1, 10.0, 'Restocked', TIMESTAMP '2025-08-28 14:00:00');
