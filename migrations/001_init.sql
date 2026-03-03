-- ============================================
-- 1. Справочники (должны быть созданы первыми)
-- ============================================

-- Языки
CREATE TABLE IF NOT EXISTS language_list (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code VARCHAR(10) NOT NULL UNIQUE,  -- ru, en, fr
    name VARCHAR(100)                  -- Русский, English (опционально для админки)
);

-- Издательства
CREATE TABLE IF NOT EXISTS publisher (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    slug VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(100),
    website VARCHAR(255),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Серии книг
CREATE TABLE IF NOT EXISTS series (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    slug VARCHAR(255) NOT NULL UNIQUE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Жанры
CREATE TABLE IF NOT EXISTS genre_list (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    slug VARCHAR(100) NOT NULL UNIQUE,  -- fantasy, detective
    name VARCHAR(100) NOT NULL UNIQUE,  -- Фантастика, Детектив
    description TEXT
);

-- ============================================
-- 2. Основные сущности
-- ============================================

-- Авторы
CREATE TABLE IF NOT EXISTS author_list (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    slug VARCHAR(255) NOT NULL UNIQUE,
    full_name VARCHAR(255) NOT NULL,
    birth_date DATE,
    death_date DATE,
    biography TEXT,
    country VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Книги
CREATE TABLE IF NOT EXISTS book (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    slug VARCHAR(255) NOT NULL UNIQUE,
    title VARCHAR(255) NOT NULL,
    original_title VARCHAR(255),
    description TEXT,
    isbn VARCHAR(20) UNIQUE,  -- ISBN-10 или ISBN-13
    published_date DATE,      -- Дата выхода издания
    language_id INTEGER NOT NULL REFERENCES language_list(id) ON DELETE RESTRICT,
    pages_count INTEGER CHECK (pages_count > 0),
    cover_image_url VARCHAR(500),
    
    -- Связи с сущностями
    series_id INTEGER REFERENCES series(id) ON DELETE SET NULL,
    series_order INTEGER CHECK (series_order > 0),
    publisher_id INTEGER REFERENCES publisher(id) ON DELETE SET NULL,
    
    -- Системные поля
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- 3. Связующие таблицы (Many-to-Many)
-- ============================================

-- Связь Книги <-> Авторы (с ролью)
CREATE TABLE IF NOT EXISTS author_book (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    book_id INTEGER NOT NULL REFERENCES book(id) ON DELETE CASCADE,
    author_id INTEGER NOT NULL REFERENCES author_list(id) ON DELETE CASCADE,
    role VARCHAR(50) NOT NULL DEFAULT 'Автор', -- Автор, Переводчик, Иллюстратор
    
    -- Уникальность связи: один автор не может иметь одну и ту же роль в одной книге дважды
    UNIQUE (book_id, author_id, role)
);

-- Связь Книги <-> Жанры
CREATE TABLE IF NOT EXISTS book_genre (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    book_id INTEGER NOT NULL REFERENCES book(id) ON DELETE CASCADE,
    genre_id INTEGER NOT NULL REFERENCES genre_list(id) ON DELETE CASCADE,
    
    UNIQUE (book_id, genre_id)
);

-- ============================================
-- 4. Триггер для авто-обновления updated_at
-- ============================================

-- Функция обновления таймстампа
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Применение триггера ко всем таблицам с updated_at
CREATE TRIGGER trg_book_updated_at 
    BEFORE UPDATE ON book 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER trg_author_updated_at 
    BEFORE UPDATE ON author_list 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER trg_publisher_updated_at 
    BEFORE UPDATE ON publisher 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER trg_series_updated_at 
    BEFORE UPDATE ON series 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();