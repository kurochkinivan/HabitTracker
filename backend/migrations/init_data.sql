-- Active: 1731585563391@@127.0.0.1@30000@habit_tracker@public

INSERT INTO users (name, email, password, is_verified) VALUES 
('ivan_kurochkin', 'ivan.kurochkin.04@gmail.com', '12345', true);

INSERT INTO days_of_week (name) VALUES 
('Monday'), 
('Tuesday'), 
('Wednesday'), 
('Thursday'), 
('Friday'), 
('Saturday'), 
('Sunday');

INSERT INTO categories (name) VALUES
('Health'),          
('Sports'),             
('Productivity'),    
('Education'),       
('Nutrition'),           
('Psychology'),        
('Finance'),           
('Rest'),             
('Personal Growth'),   
('Social Connections'),  
('Creativity'),        
('Work'),            
('Hobby'),             
('Meditation'),         
('Self-Development');      

INSERT INTO habits (user_id, name, description, category_id, interval, popularity_index, active) VALUES
((SELECT id FROM users LIMIT 1), 'Morning Jogging', 'Run 5 km every morning', 1, 'daily', 85.50, TRUE),
((SELECT id FROM users LIMIT 1), 'Reading Books', 'Read at least 20 pages daily', 4, 'daily', 90.00, TRUE),
((SELECT id FROM users LIMIT 1), 'Guitar Practice', 'Practice guitar for 30 minutes', 3, 'weekly', 72.30, TRUE),
((SELECT id FROM users LIMIT 1), 'Meditation', 'Meditate for 10 minutes', 5, 'daily', 88.00, FALSE);

