USE proman_db;

-- Наповнення таблиці Role
INSERT INTO Role (name, description) VALUES
('Administrator', 'Full access to all system features'),
('Manager', 'Manage projects and tasks'),
('Worker', 'Responsible for completing tasks');

-- Наповнення таблиці Permission
INSERT INTO Permission (name) VALUES
('Edit Task'),
('Delete Task'),
('View Task'),
('Manage Users');

-- Наповнення таблиці RolePermission
INSERT INTO `Grant` (role_id, permission_id) VALUES
(1, 1), -- Administrator: Edit Task
(1, 2), -- Administrator: Delete Task
(1, 3), -- Administrator: View Task
(1, 4), -- Administrator: Manage Users
(2, 1), -- Manager: Edit Task
(2, 3), -- Manager: View Task
(3, 3); -- Worker: View Task

-- Наповнення таблиці User
INSERT INTO User (name, email, password, profilePicture, status) VALUES
('Alice', 'alice@example.com', 'password123', 'https://example.com/avatar/alice.png', 'active'),
('Bob', 'bob@example.com', 'password123', 'https://example.com/avatar/bob.png', 'active'),
('Charlie', 'charlie@example.com', 'password123', NULL, 'inactive');

-- Наповнення таблиці Project
INSERT INTO Project (name, description, creationDate, status) VALUES
('Project Alpha', 'Description of Project Alpha', '2024-01-01 10:00:00', 'active'),
('Project Beta', 'Description of Project Beta', '2024-02-01 10:00:00', 'completed');

-- Наповнення таблиці Task
INSERT INTO Task (project_id, name, description, status, startDate, dueDate) VALUES
(1, 'Design Database Schema', 'Create a database schema for the project', 'in progress', '2024-01-01', '2024-01-05'),
(1, 'Develop API Endpoints', 'Build API for the project', 'pending', '2024-01-06', '2024-01-15'),
(2, 'Write Documentation', 'Document the project for future developers', 'completed', '2024-02-01', '2024-02-05');

-- Наповнення таблиці TaskComment
INSERT INTO TaskComment (task_id, content, creationDate, author_id) VALUES
(1, 'This is the initial schema design draft.', '2024-01-02 12:00:00', 1),
(2, 'Need clarification on API authentication.', '2024-01-07 09:30:00', 2),
(3, 'Documentation looks good. Ready for submission.', '2024-02-05 15:00:00', 1);

-- Наповнення таблиці Attachment
INSERT INTO Attachment (task_id, link, fileType, fileSize) VALUES
(1, 'https://example.com/files/schema.pdf', 'pdf', 2048),
(2, 'https://example.com/files/api-docs.docx', 'docx', 1024),
(3, 'https://example.com/files/project-summary.xlsx', 'xlsx', 512);

-- Наповнення таблиці Tag
INSERT INTO Tag (name, color) VALUES
('Urgent', 'red'),
('Backend', 'blue'),
('Frontend', 'green');

-- Наповнення таблиці TasksTag
INSERT INTO TasksTag (task_id, tag_id) VALUES
(1, 1), -- Task 1: Urgent
(1, 2), -- Task 1: Backend
(2, 2), -- Task 2: Backend
(3, 3); -- Task 3: Frontend

-- Наповнення таблиці Member
INSERT INTO Member (user_id, project_id, role_id) VALUES
(1, 1, 1), -- Alice: Administrator for Project Alpha
(2, 1, 2), -- Bob: Manager for Project Alpha
(3, 2, 3); -- Charlie: Worker for Project Beta

-- Наповнення таблиці Assignee
INSERT INTO Assignee (user_id, task_id) VALUES
(1, 1), -- Alice assigned to Task 1
(2, 2), -- Bob assigned to Task 2
(3, 3); -- Charlie assigned to Task 3
