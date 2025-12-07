# Rick and Morty Characters App 🚀

Мобильное приложение на Flutter для изучения вселенной Рика и Морти с управлением избранным и полной поддержкой оффлайн-режима.

## 📱 Функциональность

### Основные возможности
- **Список персонажей**: Отображение всех персонажей Рика и Морти с информацией (имя, статус, вид, пол и т.д.)
- **Система избранного**: Добавляйте и удаляйте любимых персонажей одним нажатием
- **Оффлайн-режим**: Полный доступ к данным без подключения к интернету
- **Интуитивная навигация**: Интерфейс с настраиваемой нижней панелью навигации
- **Темная/светлая тема**: Переключение темы с плавными анимациями

### Технические особенности
- **Оптимизированная архитектура**: Один запрос к API при первом запуске, затем всё работает локально
- **Интеллектуальное кеширование**: Автоматическое сохранение данных в SQLite
- **Управление подключением**: Автоматическое определение сети и переключение на локальный кеш
- **Анимации**: Визуальные эффекты при добавлении/удалении из избранного (конфетти, Lottie-анимации)
- **Производительность**: Оптимизированная загрузка изображений с кешированием, Оптимизация запросов API

## 🏗️ Архитектура

### База данных SQLite

```sql
-- Таблица персонажей
CREATE TABLE characters (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  status TEXT NOT NULL,
  species TEXT NOT NULL,
  type TEXT,
  gender TEXT NOT NULL,
  image TEXT NOT NULL,
  url TEXT NOT NULL,
  created TEXT NOT NULL
);

-- Таблица избранного
CREATE TABLE favorites (
  character_id INTEGER PRIMARY KEY,
  FOREIGN KEY(character_id) REFERENCES characters(id) ON DELETE CASCADE
);
```

### Поток данных

1. **Первый запуск**: Запрос к API Rick and Morty → Сохранение в SQLite
2. **Последующие запуски**: 
   - ✅ Есть интернет: Данные, загруженные из API
   - ❌ Нет интернета: Данные загружаются из локального кеша
3. **Избранное**: 100% локальное управление через SQL-объединение таблиц `characters` и `favorites`

## 🛠️ Использованные технологии

### State Management
- **GetX**: Реактивное управление состоянием и навигация

### Хранение данных
- **SQLite (sqflite)**: Локальная база данных для персонажей и избранного
- **GetStorage**: Пользовательские настройки (тема)

### Сеть и подключение
- **http**: REST API запросы
- **connectivity_plus**: Определение сетевого подключения
- **cached_network_image**: Кеширование изображений

### UI/UX
- **curved_navigation_bar**: Настраиваемая панель навигации
- **lottie**: Векторные анимации
- **confetti**: Эффекты празднования
- **flutter_spinkit**: Индикаторы загрузки

### Инструменты разработки
- **flutter_launcher_icons**: Генерация иконок
- **flutter_native_splash**: Нативный экран запуска

## 📋 Требования

- Flutter SDK: `^3.7.0`
- Dart SDK: `^3.7.0`

## 🚀 Установка

### 1. Клонировать репозиторий
```bash
git clone https://github.com/ваш-username/rick_and_morty.git
cd rick_and_morty
```

### 2. Установить зависимости
```bash
flutter pub get
```

### 3. Сгенерировать иконку приложения (опционально)
```bash
dart run run flutter_launcher_icons
```

### 4. Сгенерировать экран запуска (опционально)
```bash
dart run flutter_native_splash:create
```

### 5. Запустить приложение
```bash
flutter run
```

## 📦 Структура проекта

```
📦lib
 ┣ 📂core
 ┃ ┣ 📂configs
 ┃ ┃ ┣ 📜app_colors.dart
 ┃ ┃ ┗ 📜app_routes.dart
 ┃ ┗ 📂constants
 ┃ ┃ ┗ 📜api_constants.dart
 ┣ 📂features
 ┃ ┣ 📂characters
 ┃ ┃ ┣ 📂data
 ┃ ┃ ┃ ┣ 📂databases
 ┃ ┃ ┃ ┃ ┗ 📜character_database.dart
 ┃ ┃ ┃ ┣ 📂models
 ┃ ┃ ┃ ┃ ┣ 📜character.dart
 ┃ ┃ ┃ ┃ ┗ 📜character_response.dart
 ┃ ┃ ┃ ┣ 📂repositories
 ┃ ┃ ┃ ┃ ┗ 📜characters_repository_impl.dart
 ┃ ┃ ┃ ┗ 📂sources
 ┃ ┃ ┃ ┃ ┣ 📜character_data_source.dart
 ┃ ┃ ┃ ┃ ┣ 📜character_local_data_source.dart
 ┃ ┃ ┃ ┃ ┗ 📜character_remote_data_source.dart
 ┃ ┃ ┣ 📂domains
 ┃ ┃ ┃ ┣ 📂repositories
 ┃ ┃ ┃ ┃ ┗ 📜characters_repository.dart
 ┃ ┃ ┃ ┗ 📂usecases
 ┃ ┃ ┃ ┃ ┗ 📜get_all_characters.dart
 ┃ ┃ ┗ 📂presentation
 ┃ ┃ ┃ ┣ 📂controllers
 ┃ ┃ ┃ ┃ ┣ 📜base_character_list_controller.dart
 ┃ ┃ ┃ ┃ ┣ 📜characters_fav_list_screens_controller.dart
 ┃ ┃ ┃ ┃ ┗ 📜characters_list_screens_controller.dart
 ┃ ┃ ┃ ┣ 📂interfaces
 ┃ ┃ ┃ ┃ ┗ 📜characters_screem_interface.dart
 ┃ ┃ ┃ ┣ 📂screens
 ┃ ┃ ┃ ┃ ┣ 📜characters_fav_screens.dart
 ┃ ┃ ┃ ┃ ┣ 📜characters_item.dart
 ┃ ┃ ┃ ┃ ┗ 📜characters_list_screens.dart
 ┃ ┃ ┃ ┗ 📂widgets
 ┃ ┃ ┃ ┃ ┗ 📜character_loading_indicator.dart
 ┃ ┗ 📜home_page.dart
 ┣ 📂shared
 ┃ ┣ 📂services
 ┃ ┃ ┗ 📜di_service.dart
 ┃ ┗ 📂themes
 ┃ ┃ ┣ 📜theme_controller.dart
 ┃ ┃ ┣ 📜theme_data.dart
 ┃ ┃ ┣ 📜theme_ripple_overlay.dart
 ┃ ┃ ┣ 📜theme_toggle_button.dart
 ┃ ┃ ┗ 📜zoom_circle_painter.dart
 ┗ 📜main.dart
```

## 🎯 Используемое API

[Rick and Morty API](https://rickandmortyapi.com/documentation/)

## 🌟 Преимущества

- ✅ **Оптимальная производительность**: Требуется только один API-запрос
- ✅ **100% оффлайн**: Работает без подключения после первого запуска
- ✅ **Чистая архитектура**: Чёткое разделение ответственности
- ✅ **Продуманный UX**: Анимации и визуальная обратная связь
- ✅ **Поддерживаемый код**: Модульная структура с комментариями

**Разработано с ❤️ и Flutter**