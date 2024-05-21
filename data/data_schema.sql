-- TODO
-- Add conceptual data flow
-- Add ERD as document
-- Add Business flow documentation
-- Add metric definition with additive and non additive metrics

-- Create schema if not exists and set the context to the rainforest schema
CREATE SCHEMA IF NOT EXISTS rainforest;
USE rainforest;

-- Drop and create dim_buyer table
-- Table 'dim_buyer' (alias: Buyer, Customer, Client) stores detailed buyer information. Grain: individual buyer, Unique key: buyer_id
DROP TABLE IF EXISTS dim_buyer;
CREATE TABLE dim_buyer (
    buyer_id INT, -- Unique identifier for the buyer (alias: BuyerID, CustomerID, ClientID)
    user_id INT, -- Identifier linking to the user account (alias: UserID, AccountID)
    username VARCHAR(255), -- Username of the buyer (alias: UserName, Nickname)
    email VARCHAR(255), -- Email address of the buyer (alias: EmailAddress, ContactEmail)
    is_active BOOLEAN, -- Status to check if the buyer's account is active (alias: ActiveStatus, IsActive)
    first_time_purchased_timestamp TIMESTAMP, -- Timestamp of the buyer's first purchase (alias: FirstPurchase, FirstBuyDate)
    created_ts TIMESTAMP, -- Timestamp when the buyer record was created (alias: CreationTime, RecordCreated)
    last_updated_by INT, -- Last user/admin who updated the buyer record (alias: UpdatedBy, ModifiedBy)
    last_updated_ts TIMESTAMP -- Timestamp when the buyer record was last updated (alias: UpdateTime, LastModified)
);

-- Drop and create dim_seller table
-- Table 'dim_seller' (alias: Seller, Vendor, Merchant) stores detailed seller information. Grain: individual seller, Unique key: seller_id
DROP TABLE IF EXISTS dim_seller;
CREATE TABLE dim_seller (
    seller_id INT, -- Unique identifier for the seller (alias: SellerID, VendorID)
    user_id INT, -- Identifier linking to the user account (alias: UserID, MerchantAccount)
    username VARCHAR(255), -- Username of the seller (alias: UserName, VendorName)
    email VARCHAR(255), -- Email address of the seller (alias: EmailAddress, SellerEmail)
    is_active BOOLEAN, -- Status to check if the seller's account is active (alias: ActiveStatus, IsActive)
    first_time_sold_timestamp TIMESTAMP, -- Timestamp of the seller's first sale (alias: FirstSaleDate, InitialSaleTime)
    created_ts TIMESTAMP, -- Timestamp when the seller record was created (alias: CreationTime, RecordCreated)
    last_updated_by INT, -- Last user/admin who updated the seller record (alias: UpdatedBy, ModifiedBy)
    last_updated_ts TIMESTAMP -- Timestamp when the seller record was last updated (alias: UpdateTime, LastModified)
);

-- Drop and create dim_product table
-- Table 'dim_product' (alias: Product, Item, Goods) stores detailed product information. Grain: individual product, Unique key: product_id
DROP TABLE IF EXISTS dim_product;
CREATE TABLE dim_product (
    product_id INT, -- Unique identifier for the product (alias: ProductID, ItemID)
    name VARCHAR(255), -- Name of the product (alias: ProductName, ItemName)
    description VARCHAR(255), -- Description of the product (alias: Description, Details)
    price DECIMAL(10, 2), -- Price of the product (alias: Price, Cost)
    brand_id INT, -- Identifier for the brand of the product (alias: BrandID, Brand)
    brand_name VARCHAR(255), -- Name of the brand (alias: BrandName, Brand)
    manufacturer_id INT, -- Identifier for the manufacturer of the product (alias: ManufacturerID, MakerID)
    manufacturer_name VARCHAR(255), -- Name of the manufacturer (alias: ManufacturerName, Maker)
    review_count INT, -- Number of reviews for the product (alias: Reviews, FeedbackCount)
    avg_rating DECIMAL(3, 2), -- Average rating of the product (alias: AverageRating, Rating)
    created_ts TIMESTAMP, -- Timestamp when the product record was created (alias: CreationTime, RecordCreated)
    last_updated_by INT, -- Last user/admin who updated the product record (alias: UpdatedBy, ModifiedBy)
    last_updated_ts TIMESTAMP -- Timestamp when the product record was last updated (alias: UpdateTime, LastModified)
);

-- Drop and create dim_category table
-- Table 'dim_category' (alias: Category, ProductCategory, Section) stores detailed category information. Grain: individual category, Unique key: category_id
DROP TABLE IF EXISTS dim_category;
CREATE TABLE dim_category (
    category_id INT, -- Unique identifier for the category (alias: CategoryID, SectionID)
    name VARCHAR(255), -- Name of the category (alias: CategoryName, SectionName)
    created_ts TIMESTAMP, -- Timestamp when the category record was created (alias: CreationTime, RecordCreated)
    last_updated_by INT, -- Last user/admin who updated the category record (alias: UpdatedBy, ModifiedBy)
    last_updated_ts TIMESTAMP -- Timestamp when the category record was last updated (alias: UpdateTime, LastModified)
);

-- Drop and create dim_date table
-- Table 'dim_date' (alias: Date Dimension, Calendar) provides a comprehensive breakdown of dates for reporting purposes. Grain: individual date, Unique key: date_key
DROP TABLE IF EXISTS dim_date;
CREATE TABLE dim_date (
    date_key DATE, -- Key for the date, typically formatted as YYYYMMDD (alias: DateKey, CalendarKey)
    date DATE, -- Actual date (alias: ActualDate, FullDate)
    year INT, -- Year extracted from the date (alias: Year)
    quarter INT, -- Quarter extracted from the date (alias: Quarter)
    month INT, -- Month extracted from the date (alias: Month)
    day INT, -- Day extracted from the date (alias: Day)
    day_of_week INT, -- Day of the week extracted from the date (alias: DayOfWeek, Weekday)
    day_name VARCHAR(255), -- Name of the day (alias: DayName, WeekdayName)
    day_of_month INT, -- Day of the month extracted from the date (alias: DayOfMonth)
    day_of_quarter INT, -- Day of the quarter extracted from the date (alias: DayOfQuarter)
    day_of_year INT, -- Day of the year extracted from the date (alias: DayOfYear)
    week_of_month INT, -- Week of the month extracted from the date (alias: WeekOfMonth)
    week_of_year INT, -- Week of the year extracted from the date (alias: WeekOfYear)
    month_name VARCHAR(255), -- Name of the month (alias: MonthName)
    year_month INT, -- Year and month combination extracted from the date (alias: YearMonth)
    year_quarter INT -- Year and quarter combination extracted from the date (alias: YearQuarter)
);

-- Drop and create seller_x_product table
-- Table 'seller_x_product' (alias: Seller-Product Link, Vendor Items) stores relationships between sellers and products. Grain: seller-product pair, no unique single column key
DROP TABLE IF EXISTS seller_x_product;
CREATE TABLE seller_x_product (
    seller_id INT, -- Identifier for the seller (alias: SellerID, VendorID)
    product_id INT -- Identifier for the product (alias: ProductID, ItemID)
);

-- Drop and create product_x_category table
-- Table 'product_x_category' (alias: Product-Category Link, Item Classification) stores relationships between products and categories. Grain: product-category pair, no unique single column key
DROP TABLE IF EXISTS product_x_category;
CREATE TABLE product_x_category (
    product_id INT, -- Identifier for the product (alias: ProductID, ItemID)
    category_id INT -- Identifier for the category (alias: CategoryID, SectionID)
);

-- Drop and create fact_orders table
-- Table 'fact_orders' (alias: Orders, Transactions) captures sales transactions. Grain: individual order, Unique key: order_id
DROP TABLE IF EXISTS fact_orders;
CREATE TABLE fact_orders (
    order_id INT, -- Unique identifier for the order (alias: OrderID, TransactionID)
    buyer_id INT, -- Identifier for the buyer associated with the order (alias: BuyerID, CustomerID)
    order_ts TIMESTAMP, -- Timestamp of when the order was placed (alias: OrderTime, TransactionTime)
    total_price DECIMAL(10, 2), -- Total price of the order (alias: TotalAmount, SaleTotal)
    created_ts TIMESTAMP, -- Timestamp when the order record was created (alias: CreationTime, RecordCreated)
    last_updated_by INT, -- Last user/admin who updated the order record (alias: UpdatedBy, ModifiedBy)
    last_updated_ts TIMESTAMP -- Timestamp when the order record was last updated (alias: UpdateTime, LastModified)
);

-- Drop and create fact_order_items table
-- Table 'fact_order_items' (alias: Order Details, Order Line Items) captures detailed line items within each order. Grain: individual order item, Unique key: order_item_id
DROP TABLE IF EXISTS fact_order_items;
CREATE TABLE fact_order_items (
    order_item_id INT, -- Unique identifier for the order item (alias: OrderItemID, LineItemID)
    order_id INT, -- Identifier for the order associated with this item (alias: OrderID, TransactionID)
    product_id INT, -- Identifier for the product associated with this item (alias: ProductID, ItemID)
    seller_id INT, -- Identifier for the seller of this item (alias: SellerID, VendorID)
    quantity INT, -- Number of units of the product ordered (alias: Quantity, Amount)
    base_price DECIMAL(10, 2), -- Base price of a single unit of the product (alias: UnitPrice, PricePerItem)
    tax DECIMAL(10, 2), -- Tax amount for this item (alias: TaxAmount, Tax)
    created_ts TIMESTAMP, -- Timestamp when the order item record was created (alias: CreationTime, RecordCreated)
    last_updated_by INT, -- Last user/admin who updated the order item record (alias: UpdatedBy, ModifiedBy)
    last_updated_ts TIMESTAMP -- Timestamp when the order item record was last updated (alias: UpdateTime, LastModified)
);

-- Drop and create fact_clickstream_events table
-- Table 'fact_clickstream_events' (alias: User Events, Clickstream Data) stores user interaction events on the platform. Grain: individual event, Unique key: event_id
DROP TABLE IF EXISTS fact_clickstream_events;
CREATE TABLE fact_clickstream_events (
    event_id INT, -- Unique identifier for the event (alias: EventID, ClickID)
    user_id INT, -- Identifier for the user who triggered the event (alias: UserID, VisitorID)
    event_type VARCHAR(255), -- Type of event (alias: EventType, Action)
    product_id INT, -- Identifier for the product involved in the event (optional) (alias: ProductID, ItemID)
    order_id INT, -- Identifier for the order involved in the event (optional) (alias: OrderID, TransactionID)
    timestamp TIMESTAMP, -- Timestamp of when the event occurred (alias: EventTime, Timestamp)
    created_ts TIMESTAMP, -- Timestamp when the event record was created (alias: CreationTime, RecordCreated)
    last_updated_by INT, -- Last user/admin who updated the event record (alias: UpdatedBy, ModifiedBy)
    last_updated_ts TIMESTAMP -- Timestamp when the event record was last updated (alias: UpdateTime, LastModified)
);

