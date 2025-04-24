# Nike

## Описание

**Nike** — мобильное приложение интернет-магазина бренда Nike, разработанное как pet project. Приложение демонстрирует современные подходы к архитектуре, чистому коду и UI/UX-дизайну.  
Пользователь может просматривать товары, выбирать категории, добавлять в избранное или корзину и оформлять заказы.

## Особенности проекта

- Использование различных архитектур: **MVVM**, **MVP**, **MVC**.
- **Dependency Injection** через собственный DI-контейнер.
- Соблюдение принципов **SOLID** и **Clean Code**.
- Адаптивный и современный интерфейс.
- Работа с **JSON** и сохранение состояния.
- Покрытие бизнес-логики модульными тестами.

## Архитектура

| Экран         | Архитектура |
|---------------|-------------|
| Home          | MVVM        |
| Shop          | MVP         |
| Detail        | MVC         |
| Favorite      | MVC         |
| Bag           | MVC         |

## Внедрение зависимостей

В проекте реализован DI через `DependencyContainer` и `ScreenFactory`:

- Все зависимости (`URLSession`, `JSONDecoder`, `NetworkService`) создаются централизованно.
- `ScreenFactory` собирает модули, передавая зависимости через инициализаторы.
- Такой подход снижает связанность, упрощает тестирование и масштабирование.

DI внедряется один раз при запуске приложения и используется для построения всех модулей.

## Services

Проект использует несколько сервисов для управления данными и сетевыми запросами:

**NetworkService**
- Загружает данные с `localhost:3001`.
- Возвращает `Result` с моделями `HomeSectionsResponse`, `ShopSectionsResponse`.
- Абстрагирует сетевую логику через `NetworkServiceProtocol`.

**FavoritesService / BagService**
- Работа с `UserDefaults` через `JSONEncoder/Decoder`.
- Поддержка избранного и корзины с сохранением состояния.
- Подсчёт суммы и количества товаров.
- Реализованы через `FavoritesServiceProtocol`, `BagServiceProtocol`. 

## Custom Views

- `CustomButton` — настраиваемая кнопка с иконкой, цветом и обработчиком.
- `ButtonContainerView` — кнопка с разделителем.
- `GradientView` — вертикальный градиент.
- `ShadowView` — вью с тенью (включается флагом).

## Tab Bar

Кастомный `TabBarController`:

- Четыре экрана: Shop, Home, Favorites, Bag.
- Внедрение через DI и обёртка в `UINavigationController`.
- Повторное нажатие на активный таб вызывает scrollToTop().
- По умолчанию выбран экран **Home**.

## UI-компоненты & Design System

**ImageView**  
- Кастомный `UIImageView` со стилями: `.common`, `.product`, `.favorite`, и др.

**Label**  
- Кастомный `InsetLabel` с шрифтами и стилями: `.screenTitle`, `.price`, `.highlighted`, и др.

**StackView**  
- UIStackView с конфигурациями: `.productCell`, `.listHeader`, `.headerStackView`.

## Extensions

- `Date+WelcomeText.swift` — текст приветствия по времени суток.
- `UICollectionViewCell+Extension.swift` — `reuseCVId` и протокол `ReusableCollectionViewCell`.
- `UICollectionView+Extension.swift` — регистрация и извлечение ячеек.
- `UITableViewCell+reuseId.swift` — `reuseId` и `Reusable`.
- `UITableViewCell+dequeueCell.swift` — универсальное извлечение ячеек.
- `UIColor+Extension.swift` — изменение яркости цвета.
- `ScrollToTop+Extension.swift` — прокрутка к началу.
- `Array+Extension.swift` — безопасный доступ к элементам.
- `UIResponder.swift` — `findParentViewController()`.
- `UINavigationController.swift` — настройка внешнего вида и добавление поиска.
- `UIView+Extension.swift` — `makeSeparator()` и `viewController`.

## Constants 

Централизованные настройки UI:

- `Layout.swift` — отступы.
- `Constants.swift` — логические значения, например, количество баннеров.
- `Font.swift` — шрифты проекта.
- `Text.swift` — строки UI, сгруппированные по экранам.
- `Images.swift` — системные и кастомные иконки.

## Unit Tests

Покрытие бизнес-логики через `XCTest`.

**Тестируемые компоненты:**
- `ShopViewController` — viewDidLoad, обновление UI.
- `ShopPresenter` — события, загрузка данных.
- `ProductService` — обращение к сервису.

**Методы:**
- Spy-объекты (например, `ShopPresenterSpy`) для отслеживания вызовов.
- `XCTestExpectation` — ожидание асинхронных событий.
- Мокаем зависимости через протоколы.

## Экраны

### Home

- Приветствие пользователя в зависимости от времени суток.
- Секции с категориями товаров для добавления в **Favorite** или **Bag**.
- Горизонтальная промо-карусель с плавным обновлением прогресса (чёрная часть индикатора плавно перемещается и изменяет ширину в зависимости от позиции прокрутки (UIScrollViewDelegate)).
- Секция с видео и градиентом.
- Ознакомительные секции с товарами и их описанием.

**Архитектура:** MVVM  
**Особенности:** динамическое приветствие, вложенные collectionView внутри tableView, reusability секций.

### Home screenshots

<div style="display: flex; gap: 10px;">
  <img src="Screenshots/home_screen_1.png" alt="Home Screen 1" width="333"/>
  <img src="Screenshots/home_screen_2.png" alt="Home Screen 2" width="333"/>
  <img src="Screenshots/home_screen_3.png" alt="Home Screen 3" width="333"/>
</div>

---

### Shop

- Список категорий: Men, Women, Kids.
- Каждая категория содержит:
- товары с изображениями и описанием;
- ознакомительные баннеры или статьи о продукте.

**Архитектура:** MVP  
**Особенности:** презентер управляет логикой отображения и бизнес-логикой, экран масштабируется под любую категорию.

### Shop screenshots

<div style="display: flex; gap: 10px;">
  <img src="Screenshots/shop_screen_1.png" alt="Shop Screen 1" width="333"/>
  <img src="Screenshots/shop_screen_2.png" alt="Shop Screen 2" width="333"/>
  <img src="Screenshots/shop_screen_3.png" alt="Shop Screen 3" width="333"/>
</div>

---

### Detail

- Просмотр карточки товара с большим количеством фото.
- Добавление в корзину или избранное.
- Переключение между альтернативами товара.

**Архитектура:** MVC  
**Особенности:** карусель изображений, кастомная кнопка добавления, состояние товара (выбран / нет), использование библиотеки **ProgressHUD** для визуализации добавления товара в "Favorite" or "Bag". 

### Detail screenshots

<div style="display: flex; gap: 10px;">
  <img src="Screenshots/detail_screen_1.png" alt="Detail Screen 1" width="333"/>
  <img src="Screenshots/detail_screen_2.png" alt="Detail Screen 2" width="333"/>
</div>

---

### Favorite

- Список всех избранных товаров.
- Удаление из избранного.
- Состояние автоматически сохраняется.

**Архитектура:** MVC  
**Особенности:** синхронизация с Detail, динамическое обновление UI.

### Favorite screenshots

<div style="display: flex; gap: 10px;">
  <img src="Screenshots/favorite_screen_1.png" alt="Favorite Screen 1" width="333"/>
</div>

---

### Bag

- Добавленные товары с возможностью удалить по свайпу и нажатию.
- Возможность добавить товары по свайпу в избранное прямо из корзины.
- Выбор количесва товара через кастомный QuantityPickerViewController с UIPickerView.
- Подсчет итоговой суммы.

**Архитектура:** MVC  
**Особенности:** пересчет стоимости в реальном времени, удобный выбор количесва товара, избранное из корзины.

### Bag screenshots

<div style="display: flex; gap: 10px;">
  <img src="Screenshots/bag_screen_1.png" alt="Bag Screen 1" width="333"/>
</div>

---

## Планы по развитию

- Авторизация и личный профиль
- Оформление и отправка заказа
- Темная тема

---

## Контакты

- Разработчик: Alexander Mileychik
- GitHub: github.com/AMileychik/Nike
- Email: amileychik@gmail.com

---

## Установка

1. Склонировать репозиторий можно с помощью терминала или Sourcetree по этой ссылке https://github.com/AMileychik/Nike.git

2. Открой .xcodeproj в Xcode.

3. Установи зависимости c помощью SPM.

4. Установи Mockoon (https://mockoon.com/download/).

5. Скопируй из проекта (папка Resources) файлы Home.json и Shop.json, создай  http://localhost:3001/shop и http://localhost:3001/home.

6. Запусти сервер на Mockoon (Start server).

5. Скомпилируй проект на симуляторе.
