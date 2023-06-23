-- Таблица пользователей.
CREATE TABLE IF NOT EXISTS users
(
    id               bigserial primary key,
    nickname         varchar(40) not null,
    description      varchar(400),
    location         varchar(30),
    university       varchar(100),
    header_image     varchar(300),
    avatar           varchar(300),
    count_of_friends integer default 0
);

-- Таблица постов пользователя.
CREATE TABLE IF NOT EXISTS posts
(
    id                bigserial primary key,
    date_public       timestamp default current_timestamp,
    content           text,
    count_of_likes    integer   default 0,
    count_of_comments integer   default 0,
    user_id           integer not null REFERENCES users (id)
);

-- Таблица файлов в посте (фото, видео, музло).
CREATE TABLE IF NOT EXISTS files_in_post
(
    id        bigserial primary key,
    file_name varchar(400) not null,
    post_id   integer      not null REFERENCES posts (id)
);

-- Таблица комментариев под постом.
CREATE TABLE IF NOT EXISTS comments_under_post
(
    id                bigserial primary key,
    date_public       timestamp default current_timestamp,
    content           text,
    count_of_likes    integer   default 0,
    user_id           integer not null REFERENCES users (id),
    post_id           integer not null REFERENCES posts (id)
);

-- Таблица фоток пользователя.
CREATE TABLE IF NOT EXISTS user_images
(
    id                bigserial primary key,
    date_public       timestamp default current_timestamp,
    image_name        varchar(300),
    count_of_likes    integer   default 0,
    count_of_comments integer   default 0,
    user_id           integer not null REFERENCES users (id)
);

-- Лайки поста. Важно добавить потом триггер, или как он там звался, что при лайке обновлялся счётчик в табличке посты (count_of_likes)
CREATE TABLE likes_of_post (
    id bigserial primary key,
    user_id integer not null references users(id),
    post_id integer not null references posts(id)
);