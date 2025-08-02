

CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE posts (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    author_id BIGINT,
    published_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE comments (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    post_id BIGINT,
    user_id BIGINT,
    content VARCHAR(1000) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);


-- Insert a new user
INSERT INTO users (username, email, password_hash)
VALUES ('alice', 'alice@example.com', 'hashed_password_1');

-- Insert another user
INSERT INTO users (username, email, password_hash)
VALUES ('bob', 'bob@example.com', 'hashed_password_2');

-- Insert a blog post written by Alice (assuming Alice's id is 1)
INSERT INTO posts (title, content, author_id)
VALUES ('My First Blog Post', 'This is the content of my first post.', 1);

-- Insert a comment by Bob on Alice's post (assuming Bob's id is 2 and the post's id is 1)
INSERT INTO comments (post_id, user_id, content)
VALUES (1, 2, 'Great post, Alice!');


-- Get all posts with their author's username
SELECT
    p.id,
    p.title,
    p.content,
    p.published_at,
    u.username AS author
FROM
    posts p
JOIN
    users u ON p.author_id = u.id;


-- Update the title of the first post
UPDATE posts
SET title = 'My Updated First Blog Post'
WHERE id = 1;

-- Delete a comment
DELETE FROM comments
WHERE id = 1;

-- Deleting a post (assuming post_id is 1) will automatically delete its comments
-- due to the ON DELETE CASCADE rule in our DDL.
DELETE FROM posts
WHERE id = 1;