DROP DATABASE IF EXISTS proman_db;

CREATE DATABASE proman_db;

USE proman_db;

CREATE TABLE User (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    email VARCHAR(128) UNIQUE NOT NULL,
    password VARCHAR(32) NOT NULL,
    profilePicture VARCHAR(128),
    status VARCHAR(16)
);

CREATE TABLE Role (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name ENUM('Administrator', 'Manager', 'Worker') NOT NULL,
    description VARCHAR(64)
);

CREATE TABLE Permission (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(64) NOT NULL
);

CREATE TABLE `Grant` (
    role_id INT,
    permission_id INT,
    PRIMARY KEY (role_id, permission_id),
    FOREIGN KEY (role_id) REFERENCES Role(id) ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES Permission(id) ON DELETE CASCADE
);

CREATE TABLE Project (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    description VARCHAR(512),
    creationDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(16)
);

CREATE TABLE Task (
    id INT AUTO_INCREMENT PRIMARY KEY,
    project_id INT,
    name VARCHAR(64) NOT NULL,
    description VARCHAR(512),
    status VARCHAR(16) NOT NULL,
    startDate DATE,
    dueDate DATE,
    FOREIGN KEY (project_id) REFERENCES Project(id) ON DELETE CASCADE
);

CREATE TABLE TaskComment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    task_id INT,
    content VARCHAR(1024) NOT NULL,
    creationDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    author_id INT,
    FOREIGN KEY (task_id) REFERENCES Task(id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES User(id) ON DELETE CASCADE
);

CREATE TABLE Attachment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    task_id INT,
    link VARCHAR(64),
    fileType VARCHAR(16),
    fileSize INT,
    FOREIGN KEY (task_id) REFERENCES Task(id) ON DELETE CASCADE
);

CREATE TABLE Tag (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(16) NOT NULL,
    color VARCHAR(16)
);

CREATE TABLE TasksTag (
    tag_id INT,
    task_id INT,
    PRIMARY KEY (tag_id, task_id),
    FOREIGN KEY (tag_id) REFERENCES Tag(id) ON DELETE CASCADE,
    FOREIGN KEY (task_id) REFERENCES Task(id) ON DELETE CASCADE
);

CREATE TABLE Member (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    project_id INT,
    role_id INT,
    FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES Project(id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES Role(id) ON DELETE CASCADE
);

CREATE TABLE Assignee (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    task_id INT,
    FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE,
    FOREIGN KEY (task_id) REFERENCES Task(id) ON DELETE CASCADE
);
