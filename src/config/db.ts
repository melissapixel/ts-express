import { Pool } from 'pg';
import dotenv from 'dotenv';

dotenv.config();

// Создаем пул соединений
export const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  port: Number(process.env.DB_PORT) || 5432,
  database: process.env.DB_NAME || 'mydb',
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD || 'secret',
  max: 20,                                                                      // Максимальное количество клиентов в пуле
  idleTimeoutMillis: 30000,                                                     // Время простоя перед закрытием
  connectionTimeoutMillis: 2000,                                                // Таймаут подключения
});

// Проверка подключения при старте
pool.on('connect', () => {
  console.log('✅ Connected to PostgreSQL');
});

pool.on('error', (err) => {
  console.error('❌ Unexpected error on idle client', err);
  process.exit(-1);
});