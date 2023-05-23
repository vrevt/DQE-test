/* creating extension for uuid and creating tables */
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

create table if not exists users (
    user_id uuid,
    install_time timestamp
);
create table if not exists sessions (
    user_id uuid,
    session_time timestamp
);
create table if not exists payments (
    user_id uuid,
    payment_time timestamp,
    revenue numeric
);

select uuid_generate_v4();

insert into users (user_id, install_time) values
('de595437-c283-461e-b379-71e70f870048', '2023-06-26 11:31:23'),
('36bf8f56-b162-4a91-8621-530f6a49b116', '2023-06-26 01:32:24'),
('36f911b0-61e1-4449-aaa6-1fca26ee7957', '2023-06-26 05:33:25'),
('8dc36873-c7ff-4c98-893c-5d9004708394', '2023-06-27 03:34:26'),
('7486cc56-a711-4d58-8149-4084678b24f0', '2023-06-28 04:35:27'),
('8be67a84-546c-4643-8ba1-d84bd064c77d', '2023-07-28 07:36:28');

insert into sessions (user_id, session_time) values
('de595437-c283-461e-b379-71e70f870048', '2023-06-26 11:31:23'),
('de595437-c283-461e-b379-71e70f870048', '2023-06-27 10:31:23'),
('de595437-c283-461e-b379-71e70f870048', '2023-06-28 09:31:23'),
('de595437-c283-461e-b379-71e70f870048', '2023-06-29 11:31:23'),
('36bf8f56-b162-4a91-8621-530f6a49b116', '2023-06-26 01:32:24'),
('36f911b0-61e1-4449-aaa6-1fca26ee7957', '2023-06-26 05:33:25'),
('8dc36873-c7ff-4c98-893c-5d9004708394', '2023-06-27 03:34:26'),
('7486cc56-a711-4d58-8149-4084678b24f0', '2023-06-28 04:35:27'),
('8be67a84-546c-4643-8ba1-d84bd064c77d', '2023-07-28 07:36:28'),
('de595437-c283-461e-b379-71e70f870048', '2023-06-27 11:32:23'),
('36bf8f56-b162-4a91-8621-530f6a49b116', '2023-06-27 01:33:24'),
('36f911b0-61e1-4449-aaa6-1fca26ee7957', '2023-06-27 05:34:25'),
('8dc36873-c7ff-4c98-893c-5d9004708394', '2023-06-29 03:34:26'),
('7486cc56-a711-4d58-8149-4084678b24f0', '2023-07-28 04:35:27'),
('8be67a84-546c-4643-8ba1-d84bd064c77d', '2023-08-28 07:36:28');

insert into payments (user_id, payment_time, revenue) values
('de595437-c283-461e-b379-71e70f870048', '2023-06-26 11:31:25', 20),
('de595437-c283-461e-b379-71e70f870048', '2023-06-27 10:31:25', 1),
('de595437-c283-461e-b379-71e70f870048', '2023-06-28 09:31:25', 100),
('de595437-c283-461e-b379-71e70f870048', '2023-06-29 11:31:25', 8),
('36bf8f56-b162-4a91-8621-530f6a49b116', '2023-06-26 01:32:25', 3),
('36f911b0-61e1-4449-aaa6-1fca26ee7957', '2023-06-26 05:33:26', 1),
('8dc36873-c7ff-4c98-893c-5d9004708394', '2023-06-27 03:34:40', 232),
('7486cc56-a711-4d58-8149-4084678b24f0', '2023-06-28 04:35:50', 9),
('36bf8f56-b162-4a91-8621-530f6a49b116', '2023-06-27 01:33:59', 1),
('36f911b0-61e1-4449-aaa6-1fca26ee7957', '2023-06-27 05:34:59', 0),
('8dc36873-c7ff-4c98-893c-5d9004708394', '2023-06-29 03:36:00', 22),
('7486cc56-a711-4d58-8149-4084678b24f0', '2023-07-28 04:37:04', 15),
('8be67a84-546c-4643-8ba1-d84bd064c77d', '2023-08-28 07:38:08', 13);
