INSERT INTO Offices (city, phone, country, addres1, addres2, region, postal_num) VALUES 
('New York', '212-555-1234', 'USA', '123 5th Ave', 'Suite 100', 'NY', '10001'),
('Los Angeles', '213-555-5678', 'USA', '456 Elm St', '', 'CA', '90001'),
('Toronto', '416-555-8765', 'Canada', '789 King St', '', 'ON', 'M5V1M5'),
('London', '44-20-5556-7890', 'UK', '10 Downing St', '', 'London', 'SW1A 1AA'),
('Tokyo', '81-3-5556-1234', 'Japan', '1 Chiyoda', '', 'Kanto', '100-8111');

INSERT INTO Employees (first_name, last_name, email, job_title, office_id, manager_id, extension) VALUES 
('John', 'Doe', 'johndoe@example.com', 'Sales Manager', 1, NULL, '101'),
('Jane', 'Smith', 'janesmith@example.com', 'HR Manager', 2, NULL, '102'),
('Mike', 'Brown', 'mikebrown@example.com', 'IT Specialist', 3, NULL, '103'),
('Emily', 'White', 'emilywhite@example.com', 'Marketing Specialist', 1, 1, '104'),
('Chris', 'Green', 'chrisgreen@example.com', 'Operations Manager', 4, 2, '105');

INSERT INTO Customers (client_name, contact_name, last_name_client, fax, addres_line1, addres_line2, city, country, region, phone, sales_rep_id, credit_line) VALUES 
('ACME Corp', 'Alice', 'Johnson', '555-1234', '500 Elm St', '', 'New York', 'USA', 'NY', '212-555-7890', 1, 50000.00),
('Global Solutions', 'Bob', 'Miller', '555-5678', '100 Main St', '', 'Los Angeles', 'USA', 'CA', '213-555-6543', 2, 75000.00),
('Maple Tech', 'Carol', 'Davis', '555-9876', '200 Queen St', '', 'Toronto', 'Canada', 'ON', '416-555-4321', 3, 60000.00),
('King Industries', 'David', 'King', '555-2468', '300 King St', '', 'London', 'UK', 'London', '44-20-5556-9870', 4, 80000.00),
('Sunrise Electronics', 'Eve', 'Williams', '555-8642', '400 Cherry Blossom', '', 'Tokyo', 'Japan', 'Kanto', '81-3-5556-2345', 5, 90000.00);

INSERT INTO Orders (customer_id, order_date, required_date, shipped_date, status, comments) VALUES 
(1, '2024-09-01', '2024-09-10', '2024-09-05', 'Shipped', 'Delivered on time.'),
(2, '2024-08-20', '2024-08-30', '2024-08-25', 'Shipped', 'Customer requested urgent delivery.'),
(3, '2024-07-15', '2024-07-25', '2024-07-20', 'Delivered', 'Standard delivery.'),
(4, '2024-06-10', '2024-06-20', '2024-06-15', 'Cancelled', 'Customer cancelled the order.'),
(5, '2024-05-05', '2024-05-15', '2024-05-10', 'Pending', 'Awaiting shipment.');

INSERT INTO Payments (customer_id, payment_date, amount, payment_method) VALUES 
(1, '2024-09-05', 1500.00, 'Credit Card'),
(2, '2024-08-25', 2500.00, 'Bank Transfer'),
(3, '2024-07-20', 1800.00, 'Credit Card'),
(4, '2024-06-15', 2000.00, 'PayPal'),
(5, '2024-05-10', 2200.00, 'Bank Transfer');

INSERT INTO range (description_text, description_html, imagen) VALUES 
('Low-range products', '<p>Low-range affordable products</p>', 'low_range.jpg'),
('Mid-range products', '<p>Mid-range quality products</p>', 'mid_range.jpg'),
('High-end products', '<p>High-end luxury products</p>', 'high_end.jpg'),
('Eco-friendly products', '<p>Sustainable eco-friendly products</p>', 'eco_friendly.jpg'),
('Custom products', '<p>Custom-made personalized products</p>', 'custom_products.jpg');

INSERT INTO Products (product_name, dimension, description, supplier, quantity_in_stock, buy_price, manager_, supplier_price, product_range) VALUES 
('Laptop', '15 inch', 'High-performance laptop', 'TechSupplier', 50, 800.00, 950.00, 850.00, 3),
('Smartphone', '6 inch', 'Latest model smartphone', 'MobileWorld', 200, 600.00, 750.00, 700.00, 2),
('Headphones', 'Wireless', 'Noise-cancelling headphones', 'AudioMax', 100, 150.00, 200.00, 180.00, 2),
('Monitor', '27 inch', '4K UHD Monitor', 'DisplayTech', 75, 300.00, 400.00, 350.00, 3),
('Tablet', '10 inch', 'High-resolution tablet', 'GadgetsPro', 120, 250.00, 350.00, 300.00, 2);

INSERT INTO OrderDetails (order_id, product_id, quantity_ordered, price_each) VALUES 
(1, 1, 2, 800.00),
(2, 2, 3, 600.00),
(3, 3, 1, 150.00),
(4, 4, 4, 300.00),
(5, 5, 5, 250.00);
