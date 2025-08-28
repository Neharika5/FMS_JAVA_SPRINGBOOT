-- ========================
-- Table: Cuisine
-- ========================
CREATE TABLE Cuisine (
    cuisine_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL
);

-- ========================
-- Table: Dish
-- ========================
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

-- ========================
-- Table: Ingredient
-- ========================
CREATE TABLE Ingredient (
    ingredient_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    unit VARCHAR2(50),
    stock_quantity NUMBER(10,2),
    reorder_level NUMBER(10,2)
);

-- ========================
-- Table: Chef
-- ========================
CREATE TABLE Chef (
    chef_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    specialty VARCHAR2(100)
);

-- ========================
-- Table: DishIngredient
-- ========================
CREATE TABLE DishIngredient (
    dish_id NUMBER,
    ingredient_id NUMBER,
    required_quantity NUMBER(10,2),
    PRIMARY KEY (dish_id, ingredient_id),
    FOREIGN KEY (dish_id) REFERENCES Dish(dish_id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredient(ingredient_id)
);

-- ========================
-- Table: DishChef
-- ========================
CREATE TABLE DishChef (
    dish_id NUMBER,
    chef_id NUMBER,
    PRIMARY KEY (dish_id, chef_id),
    FOREIGN KEY (dish_id) REFERENCES Dish(dish_id),
    FOREIGN KEY (chef_id) REFERENCES Chef(chef_id)
);

-- ========================
-- Table: Users
-- ========================
CREATE TABLE Users (
    user_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE,
    password_hash VARCHAR2(255),
    role VARCHAR2(50)
);

-- ========================
-- Table: InventoryLog
-- ========================
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
