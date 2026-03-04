-- ============================================
-- 🧪 ТЕСТОВЫЕ ДАННЫЕ ДЛЯ БД
-- ============================================
-- Рекомендуется запускать на чистой базе или с TRUNCATE таблиц
-- ============================================

-- 🌍 1. Языки
INSERT INTO language_list (code, name) VALUES
    ('ru', 'Русский'),
    ('en', 'English'),
    ('fr', 'Français'),
    ('de', 'Deutsch'),
    ('es', 'Español'),
    ('ja', '日本語')
ON CONFLICT (code) DO NOTHING;

-- 🏢 2. Издательства
INSERT INTO publisher (slug, name, country, website) VALUES
    ('ast', 'АСТ', 'Россия', 'https://ast.ru'),
    ('eksamo', 'Эксмо', 'Россия', 'https://eksimo.ru'),
    ('penguin', 'Penguin Random House', 'USA', 'https://penguinrandomhouse.com'),
    ('harper', 'HarperCollins', 'UK', 'https://harpercollins.com'),
    ('gallimard', 'Éditions Gallimard', 'France', 'https://gallimard.fr'),
    ('azbooka', 'Азбука', 'Россия', 'https://azbooka.ru')
ON CONFLICT (slug) DO NOTHING;

-- 📚 3. Серии книг
INSERT INTO series (slug, title, description) VALUES
    ('tolkien-legacy', 'Наследие Толкина', 'Классические произведения Дж.Р.Р. Толкина о Средиземье'),
    ('witcher-saga', 'Ведьмак. Сага', 'Цикл фэнтези-романов Анджея Сапковского'),
    ('foundation', 'Основание', 'Легендарная серия Айзека Азимова о будущем галактической империи'),
    ('sherlock-holmes', 'Шерлок Холмс', 'Приключения великого сыщика и доктора Ватсона'),
    ('dune-chronicles', 'Хроники Дюны', 'Эпическая сага Фрэнка Герберта')
ON CONFLICT (slug) DO NOTHING;

-- 🎭 4. Жанры
INSERT INTO genre_list (slug, name, description) VALUES
    ('fantasy', 'Фэнтези', 'Миры с магией, мифическими существами и героическими приключениями'),
    ('scifi', 'Научная фантастика', 'Технологии будущего, космос, альтернативные реальности'),
    ('detective', 'Детектив', 'Расследования преступлений, загадки и логика'),
    ('adventure', 'Приключения', 'Путешествия, экспедиции, поиск сокровищ'),
    ('romance', 'Романтика', 'Истории о любви и отношениях'),
    ('horror', 'Ужасы', 'Произведения, вызывающие страх и напряжение'),
    ('historical', 'Исторический роман', 'События прошлого, реконструкция эпох'),
    ('classic', 'Классика', 'Признанные шедевры мировой литературы')
ON CONFLICT (slug) DO NOTHING;

-- ✍️ 5. Авторы
INSERT INTO author_list (slug, full_name, birth_date, death_date, country, biography) VALUES
    ('tolkien', 'Дж.Р.Р. Толкин', '1892-01-03', '1973-09-02', 'UK', 'Британский писатель, филолог, создатель жанра высокого фэнтези'),
    ('sapkowski', 'Анджей Сапковский', '1948-06-21', NULL, 'Poland', 'Польский писатель-фантаст, автор цикла «Ведьмак»'),
    ('asimov', 'Айзек Азимов', '1920-01-02', '1992-04-06', 'USA', 'Американский писатель-фантаст, биохимик, популяризатор науки'),
    ('doyle', 'Артур Конан Дойл', '1859-05-22', '1930-07-07', 'UK', 'Создатель Шерлока Холмса, врач по образованию'),
    ('herbert', 'Фрэнк Герберт', '1920-10-08', '1986-02-11', 'USA', 'Автор культовой саги «Дюна»'),
    ('lukyanenko', 'Сергей Лукьяненко', '1968-04-11', NULL, 'Russia', 'Писатель-фантаст, автор «Дозоров»'),
    ('murakami', 'Харуки Мураками', '1949-01-12', NULL, 'Japan', 'Японский писатель, мастер магического реализма'),
    ('christie', 'Агата Кристи', '1890-09-15', '1976-01-12', 'UK', 'Королева детектива, создательница Эркюля Пуаро')
ON CONFLICT (slug) DO NOTHING;

-- 📖 6. Книги
INSERT INTO book (slug, title, original_title, description, isbn, published_date, language_id, pages_count, cover_image_url, series_id, series_order, publisher_id) VALUES
    -- Толкин: Хоббит и Властелин Колец
    ('the-hobbit-ru', 'Хоббит, или Туда и обратно', 'The Hobbit', 'Приключение Бильбо Бэггинса в компании гномов и волшебника', '978-5-17-111111-1', '2023-01-15', 1, 320, '/covers/hobbit.jpg', 1, 1, 1),
    ('fellowship-ru', 'Братство Кольца', 'The Fellowship of the Ring', 'Первая часть эпической трилогии о Кольце Всевластья', '978-5-17-222222-2', '2023-02-20', 1, 480, '/covers/fellowship.jpg', 1, 2, 1),
    ('two-towers-ru', 'Две Крепости', 'The Two Towers', 'Вторая часть трилогии: разделение Братства и война за Средиземье', '978-5-17-333333-3', '2023-03-10', 1, 448, '/covers/two-towers.jpg', 1, 3, 1),
    ('return-king-ru', 'Возвращение Короля', 'The Return of the King', 'Финал трилогии: битва за Гондор и судьба Кольца', '978-5-17-444444-4', '2023-04-05', 1, 512, '/covers/return-king.jpg', 1, 4, 1),
    
    -- Ведьмак
    ('last-wish-ru', 'Последнее желание', 'Ostatnie życzenie', 'Сборник рассказов о Геральте из Ривии', '978-5-17-555555-5', '2022-11-01', 1, 416, '/covers/last-wish.jpg', 2, 1, 2),
    ('sword-destiny-ru', 'Меч Предназначения', 'Miecz przeznaczenia', 'Второй сборник рассказов, связывающий истории с большой сагой', '978-5-17-666666-6', '2022-12-15', 1, 384, '/covers/sword-destiny.jpg', 2, 2, 2),
    ('blood-elves-ru', 'Кровь Эльфов', 'Krew elfów', 'Первый роман саги: обучение Цири и политические интриги', '978-5-17-777777-7', '2023-01-20', 1, 432, '/covers/blood-elves.jpg', 2, 3, 2),
    
    -- Азимов: Основание
    ('foundation-ru', 'Основание', 'Foundation', 'Падение Галактической Империи и план спасения цивилизации', '978-5-17-888888-8', '2021-06-10', 1, 352, '/covers/foundation.jpg', 3, 1, 6),
    ('foundation-empire-ru', 'Основание и Империя', 'Foundation and Empire', 'Второй том: противостояние с Мулом и кризисы Психохистории', '978-5-17-999999-9', '2021-07-15', 1, 368, '/covers/foundation-empire.jpg', 3, 2, 6),
    
    -- Шерлок Холмс
    ('study-in-scarlet-ru', 'Этюд в багровых тонах', 'A Study in Scarlet', 'Первое дело Шерлока Холмса и доктора Ватсона', '978-5-17-101010-1', '2020-03-01', 1, 224, '/covers/study-scarlet.jpg', 4, 1, 1),
    ('hound-baskervilles-ru', 'Собака Баскервилей', 'The Hound of the Baskervilles', 'Легендарное дело о проклятом псе на болотах Девоншира', '978-5-17-202020-2', '2020-05-20', 1, 288, '/covers/hound.jpg', 4, 5, 1),
    
    -- Дюна
    ('dune-ru', 'Дюна', 'Dune', 'Эпическая сага о пустынной планете Арракис, специи и судьбе Пола Атрейдеса', '978-5-17-303030-3', '2022-08-01', 1, 640, '/covers/dune.jpg', 5, 1, 2),
    
    -- Отдельные произведения
    ('night-watch-ru', 'Ночной Дозор', NULL, 'Городской фэнтези о борьбе Светлых и Тёмных Иных в современной Москве', '978-5-17-404040-4', '2019-10-10', 1, 480, '/covers/night-watch.jpg', NULL, NULL, 2),
    ('norwegian-wood-ru', 'Норвежский лес', 'Noruwei no Mori', 'Лиричная история о любви, потере и взрослении в Токио 1960-х', '978-5-17-505050-5', '2021-04-12', 1, 368, '/covers/norwegian-wood.jpg', NULL, NULL, 6),
    ('murder-orient-ru', 'Убийство в «Восточном экспрессе»', 'Murder on the Orient Express', 'Эркюль Пуаро расследует загадочное убийство в запертом вагоне поезда', '978-5-17-606060-6', '2020-09-01', 1, 320, '/covers/orient-express.jpg', NULL, NULL, 1)
ON CONFLICT (slug) DO NOTHING;

-- 🔗 7. Связи: Книги <-> Авторы (с ролями)
INSERT INTO author_book (book_id, author_id, role) VALUES
    -- Толкин
    ((SELECT id FROM book WHERE slug='the-hobbit-ru'), (SELECT id FROM author_list WHERE slug='tolkien'), 'Автор'),
    ((SELECT id FROM book WHERE slug='fellowship-ru'), (SELECT id FROM author_list WHERE slug='tolkien'), 'Автор'),
    ((SELECT id FROM book WHERE slug='two-towers-ru'), (SELECT id FROM author_list WHERE slug='tolkien'), 'Автор'),
    ((SELECT id FROM book WHERE slug='return-king-ru'), (SELECT id FROM author_list WHERE slug='tolkien'), 'Автор'),
    
    -- Ведьмак (с переводчиком)
    ((SELECT id FROM book WHERE slug='last-wish-ru'), (SELECT id FROM author_list WHERE slug='sapkowski'), 'Автор'),
    ((SELECT id FROM book WHERE slug='last-wish-ru'), (SELECT id FROM author_list WHERE slug='lukyanenko'), 'Переводчик'),
    ((SELECT id FROM book WHERE slug='sword-destiny-ru'), (SELECT id FROM author_list WHERE slug='sapkowski'), 'Автор'),
    ((SELECT id FROM book WHERE slug='sword-destiny-ru'), (SELECT id FROM author_list WHERE slug='lukyanenko'), 'Переводчик'),
    ((SELECT id FROM book WHERE slug='blood-elves-ru'), (SELECT id FROM author_list WHERE slug='sapkowski'), 'Автор'),
    ((SELECT id FROM book WHERE slug='blood-elves-ru'), (SELECT id FROM author_list WHERE slug='lukyanenko'), 'Переводчик'),
    
    -- Азимов
    ((SELECT id FROM book WHERE slug='foundation-ru'), (SELECT id FROM author_list WHERE slug='asimov'), 'Автор'),
    ((SELECT id FROM book WHERE slug='foundation-empire-ru'), (SELECT id FROM author_list WHERE slug='asimov'), 'Автор'),
    
    -- Конан Дойл
    ((SELECT id FROM book WHERE slug='study-in-scarlet-ru'), (SELECT id FROM author_list WHERE slug='doyle'), 'Автор'),
    ((SELECT id FROM book WHERE slug='hound-baskervilles-ru'), (SELECT id FROM author_list WHERE slug='doyle'), 'Автор'),
    
    -- Герберт
    ((SELECT id FROM book WHERE slug='dune-ru'), (SELECT id FROM author_list WHERE slug='herbert'), 'Автор'),
    
    -- Лукьяненко
    ((SELECT id FROM book WHERE slug='night-watch-ru'), (SELECT id FROM author_list WHERE slug='lukyanenko'), 'Автор'),
    
    -- Мураками (с переводчиком)
    ((SELECT id FROM book WHERE slug='norwegian-wood-ru'), (SELECT id FROM author_list WHERE slug='murakami'), 'Автор'),
    ((SELECT id FROM book WHERE slug='norwegian-wood-ru'), (SELECT id FROM author_list WHERE slug='lukyanenko'), 'Переводчик'),
    
    -- Кристи
    ((SELECT id FROM book WHERE slug='murder-orient-ru'), (SELECT id FROM author_list WHERE slug='christie'), 'Автор')
ON CONFLICT (book_id, author_id, role) DO NOTHING;

-- 🏷️ 8. Связи: Книги <-> Жанры
INSERT INTO book_genre (book_id, genre_id) VALUES
    -- Хоббит и Властелин Колец
    ((SELECT id FROM book WHERE slug='the-hobbit-ru'), (SELECT id FROM genre_list WHERE slug='fantasy')),
    ((SELECT id FROM book WHERE slug='the-hob