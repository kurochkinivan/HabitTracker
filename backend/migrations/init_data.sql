-- Active: 1739282930250@@127.0.0.1@30000@habit_tracker

INSERT INTO users (id, name, email, password, is_verified) VALUES 
('be954b57-3cfb-4a8e-ac86-aa8cb3d0899d', 'ivan_kurochkin', 'vanya.kurochkin.23@mail.ru', '33363362343230633962643261303439323139343736663236666639633033315994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', true);

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

INSERT INTO habits (user_id, name, description, category_id, interval, popularity_index, is_active) VALUES
((SELECT id FROM users LIMIT 1), 'Morning Jogging', 'Run 5 km every morning', 1, 'daily', 85.50, TRUE),
((SELECT id FROM users LIMIT 1), 'Reading Books', 'Read at least 20 pages daily', 4, 'daily', 90.00, TRUE),
((SELECT id FROM users LIMIT 1), 'Guitar Practice', 'Practice guitar for 30 minutes', 3, 'weekly', 72.30, TRUE),
((SELECT id FROM users LIMIT 1), 'Meditation', 'Meditate for 10 minutes', 5, 'daily', 88.00, FALSE);

INSERT INTO habit_notifications (habit_id, notification_time, is_active) VALUES
((SELECT id FROM habits LIMIT 1), '18:00', true),
((SELECT id FROM habits LIMIT 1), '12:00', true);

INSERT INTO habit_schedules (habit_id, day_id) VALUES
((SELECT id FROM habits LIMIT 1), 1),
((SELECT id FROM habits LIMIT 1), 3),
((SELECT id FROM habits LIMIT 1), 5);