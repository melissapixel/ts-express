# === Переменные ===
APP_NAME = ts-express-app
DOCKER_COMPOSE = docker-compose
NPM = npm

# === Цвета для вывода ===
GREEN = \033[0;32m
YELLOW = \033[0;33m
BLUE = \033[0;34m
NC = \033[0m # No Color

# === Основные цели ===

.PHONY: help install dev build start clean lint test up down logs restart shell db

# Справка по командам
help:
	@echo "$(BLUE)================================$(NC)"
	@echo "$(YELLOW)  Доступные команды для $(APP_NAME)$(NC)"
	@echo "$(BLUE)================================$(NC)"
	@echo "  make install   - Установить зависимости"
	@echo "  make dev       - Запустить в режиме разработки (локально)"
	@echo "  make build     - Скомпилировать TypeScript"
	@echo "  make start     - Запустить продакшн сборку (локально)"
	@echo "  make up        - Запустить Docker контейнеры"
	@echo "  make down      - Остановить Docker контейнеры"
	@echo "  make restart   - Перезапустить контейнеры"
	@echo "  make logs      - Показать логи контейнеров"
	@echo "  make shell     - Войти в контейнер приложения (bash)"
	@echo "  make db        - Войти в контейнер базы данных (psql)"
	@echo "  make clean     - Очистить сборку и node_modules"
	@echo "  make lint      - Проверить код линтером"
	@echo "  make test      - Запустить тесты"

# Установка зависимостей
install:
	@echo "$(GREEN)📦 Установка зависимостей...$(NC)"
	$(NPM) install

# Разработка (локально без Docker)
dev:
	@echo "$(GREEN)🚀 Запуск в режиме разработки...$(NC)"
	$(NPM) run dev

# Сборка проекта
build:
	@echo "$(GREEN)🔨 Сборка проекта...$(NC)"
	$(NPM) run build

# Запуск продакшн версии (локально)
start: build
	@echo "$(GREEN)▶️ Запуск продакшн сервера...$(NC)"
	$(NPM) start

# Docker: Поднять контейнеры
up:
	@echo "$(GREEN)🐳 Запуск Docker контейнеров...$(NC)"
	$(DOCKER_COMPOSE) up --build

# Docker: Поднять контейнеры в фоне (detached)
up-d:
	@echo "$(GREEN)🐳 Запуск Docker контейнеров (фон)...$(NC)"
	$(DOCKER_COMPOSE) up -d --build

# Docker: Остановить контейнеры
down:
	@echo "$(YELLOW)🛑 Остановка контейнеров...$(NC)"
	$(DOCKER_COMPOSE) down

# Docker: Остановить и удалить тома (сброс БД)
down-v:
	@echo "$(YELLOW)⚠️ Остановка и удаление данных...$(NC)"
	$(DOCKER_COMPOSE) down -v

# Docker: Логи
logs:
	$(DOCKER_COMPOSE) logs -f

# Docker: Рестарт
restart: down up

# Docker: Войти в консоль приложения
shell:
	$(DOCKER_COMPOSE) exec app sh

# Docker: Войти в консоль базы данных
db:
	$(DOCKER_COMPOSE) exec db psql -U postgres -d mydb

# Очистка
clean:
	@echo "$(YELLOW)🧹 Очистка...$(NC)"
	rm -rf dist
	rm -rf node_modules
	@echo "$(GREEN)✅ Очистка завершена$(NC)"

# Линтинг
lint:
	$(NPM) run lint

# Тесты
test:
	$(NPM) run test