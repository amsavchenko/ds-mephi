# Отчёт о задании "Petrov & Boshirov Challenge" по предмету Data Science

Ссылка на код – 

Выполнили студенты группы Б17-505:

- Зоричев Виталий 
- Иванова Дарья
- Казьмин Сергей
- Савченко Антон

---

## 1. Постановка задачи

Задача заключалась в приобретении навыков работы с большим объемом данных из разнородных источников, осуществлении очистки, предобработки и слияния данных. Данные надо было проанализировать и найти потенциальных "русских шпионов".

Предоставленные данные:

```
├── BoardingData.csv
├── FrequentFlyerForum-Profiles.json
├── PointzAggregator-AirlinesData.xml
├── Sirena-export-fixed.tab
├── Skyteam_Timetable.pdf
├── SkyTeam-Exchange.yaml
├── YourBoardingPassDotAero/
```

## 2. Технические особенности решения

Для начала был осуществлен просмотр всех предоставленных файлов для оценки их полезности при анализе и выделения списка полей, которые есть в каждом файле или которые можно однозначно получить из значений других полей. Был определен список признаков, которые надо вытащить из каждого файла:

- Имя пассажира
- Пол пассажира
- Номер рейса
- Дата полёта
- Время вылета
- Название авиакомпании
- Страна, город, аэропорт вылета и прилета
- Номер использованной карты лояльности
- Дата рождения и номер паспорта пассажира

Далее будет рассказано про парсинг файлов каждого типа.

### 2.1. Excel

Всего было 365 файлов с расширением `.xlsx`, внутри каждого примерно 1500 листов, на каждом из которых отдельный посадочный талон. Для загрузки данных использовался метод `pandas.read_excel()`, позволяющий считать весь файл (со всеми листами) в `pandas.DataFrame`. В файлах не была указана авиакомпания, выполнившая рейс, поэтому эта информация доставалась из номера рейса (первые 2 буквы определяют авиакомпанию). Так же не были указаны страны вылета и прилёта, эта информация добавлялась по коду аэропортов. Главная сложность при работе с данными Excel-файлами заключалась в том, что полное имя пассажира было записано в 1 строку и порядок следования имени и фамилии менялся. Усугубляло ситуацию то, что в некоторых посадочных талонах было добавлена еще и первая буква отчества. Борьба с этой проблемой проводилась в 2 шага:

1. удаление отчества – сначала строка разбивалась на отдельные слова, далее слова сортировались по длине, и если слов 3, то гарантированно кратчайшее слово - это первая буква отчества, её можно удалить.

```python
def process_excel_name(name):
  name = sorted(name.split(' '), key=lambda x: len(x))
  if len(name) == 3:
    name.pop(0)
   return ' '.join(name)
```

2. разделение имени и фамилии – для этого помогли данные, подготовленные другими участниками. Собрал уникальный набор имён и фамилий, встртившихся в других файлах, и по нему разделил свои строки.

### 2.2 YAML

<img src="/Users/amsavchenko/Library/Application Support/typora-user-images/image-20201024185006757.png" alt="image-20201024185006757" style="zoom:50%;" />

Из-за того, что файл был слишком объёмным, он был разделен на много файлов – один файл на один день полётов. 

Теперь каждый файл можно было представить в виде дерева из вложенных словарей (в этом помог модуль PyYaml). А так как не у всех подсловарей в этом дереве был именованный ключ, то решить проблему парсинга помог обход в глубину. 

<img src="/Users/amsavchenko/Documents/study/ds/Airlines/1.png" style="zoom:80%;" />

После последующей обработки были получены 2 файла CSV: один, содержащий данные о программе лояльности, другой – с данными о полёте.

### 2.3. TAB

![](/Users/amsavchenko/Documents/study/ds/Airlines/2.png)

Так как каждое поле в этом файле представлялось фиксированным количеством символов – было решено вручную выделить эти поля из файла, после чего слить в csv. 

<img src="/Users/amsavchenko/Library/Application Support/typora-user-images/image-20201024185424221.png" alt="image-20201024185424221" style="zoom:50%;" />

После чего данные были загружены в pandas.DataFrame , где были обработаны в соответствии с договорённостями команды о нормальном обобщённом виде данных. Для перевода имён пассажиров в транслит был использован модуль transliterate. После обработки дали были выгружены в отдельный csv-файл.

### 2.4. CSV

![](/Users/amsavchenko/Documents/study/ds/Airlines/4.png)

В данном случае необходимо было лишь привести данные к общему виду, после чего сохранить в новый файл csv.

### 2.5. XML

Для загрузки данных выбран язык программирования python.

Файл выглядел следующим образом:

<img src="/Users/amsavchenko/Documents/study/ds/Airlines/Без заголовка.png" style="zoom:67%;" />

К сожалению, в python нет метода, который автоматически сделает из файла в xml формате готовый DataFrame. Поэтому можно было либо написать функцию обхода дерева, либо воспользоваться модулем pandas_read_xml, который загружает данные из .xml, а далее воспользоваться функцией auto_separate_tables для создания DataFrame. Был выбран второй способ. 

Из файла получилось извлечь следующие признаки:

- Имя пассажира
- Номер рейса
- Дата полёта
- Название авиакомпании
- Аэропорт вылета и прилета
- Номер использованной карты лояльности

По аэропорту были определены страна и город вылета.

Были решены проблемы разнородности данных: имена и фамилии переведены в нижний регистр, а коды аэропортов в верхний.

Готовый DataFrame:

<img src="/Users/amsavchenko/Documents/study/ds/Airlines/3.png" style="zoom:80%;" />

### 2.6. JSON

Файл `FrequentFlyerForum-Profiles.json`– профили часто летающих пассажиров на форуме. Для парсинга использовался язык программирования JavaScript, его библиотека `fs`, а также метод `JSON.parse()`.

Файл содержал все необходимые данные, указанные ранее, за исключением имен пассажиров и времени вылета. Часть имен были скрыты - добавлялись из других таблиц по номеру карты лояльности. Время вылета добавлялось из других таблиц по номеру рейса.

Итог – csv-файл `FrequentFlyerForum-Profiles.csv` с указанными ранее столбцами.

### 2.7. Заполнение пропущенных значений

Не в каждом файле были все нужные поля, часто некоторые значения надо было заполнять по значениям других полей. Для этого было создано 2 таблицы:

1. по номеру рейса определяющая код аэропортов вылета и прилета

<img src="/Users/amsavchenko/Library/Application Support/typora-user-images/image-20201024200147574.png" alt="image-20201024200147574" style="zoom:80%;" />

2. по коду аэропорта определяющая страну и город, в котором аэропорт расположен

<img src="/Users/amsavchenko/Library/Application Support/typora-user-images/image-20201024200202135.png" alt="image-20201024200202135" style="zoom:80%;" />

### 2.8. Решение проблем с транслитерацией

В разных таблицах были разные варианты транслитерации, поэтому было необходимо привести все имена в единый формат. Для этого сначала из строк были удалены апострофы, обозначающие мягкий знак, далее произведены замены буквенные сочетаний. Например, 

- x => ks
- ia, ja => ya
- iu, ju => yu
- и т.д.

### 2.9. Объединение 6 таблиц в одну

На предыдущем этапе были получены 6 таблиц с определенными выше полями, и стало необходимо объединить их в одну. При этом полёты в таблицах пересекались, и было необходимо оставить только уникальные полеты. Для этого создавался составной индекс:

![image-20201024210505920](/Users/amsavchenko/Library/Application Support/typora-user-images/image-20201024210505920.png)

Вычислялось пересечение индексов и из одной таблицы удалялись все индексы из пересечения:

![image-20201024210513783](/Users/amsavchenko/Library/Application Support/typora-user-images/image-20201024210513783.png)

Итого после объединения 6 таблиц в таблице получилось 1435495 строк. 

### 2.10. Выделение признаков для пассажиров

Теперь возникла необходимость перейти от таблицы с полётами к таблице пассажиров, которая бы могла в дальнейшем использоваться в качестве выборки для применения алгоитмов машинного обучения. Была создана таблица из 74477 пассажиров, для каждого из которых вычислены следующие признаки:

- Общее число полетов
- Число посещенных стран и городов
- Число использованных карт лояльности
- Средний временной интервал между полётами
- Число использованных авиакомпаний к числу полётов
- Использование карты лояльности Аэрофлота
- Количество полётов заграницу 
- Зарегистрирован ли человек на форуме часто летающих пассажиров
- Скрыл ли человек своё имя на форуме
- Количество посещенных оффшорных стран
- и т. д.

Полученный датасет:

![image-20201024211002782](/Users/amsavchenko/Library/Application Support/typora-user-images/image-20201024211002782.png)

Матрица линейной корреляции признаков:
![image-20201024211021455](/Users/amsavchenko/Library/Application Support/typora-user-images/image-20201024211021455.png)

## 3. Описание гипотезы

Получив таблицу с признаками, определяющими характер путешествий пассажиров, мы поняли, что близкая задача к решаемой – задача обнаружения аномалий. То есть мы можем искать "потенциальных русских шпионов" как пассажиров с некоторым аномальным поведением. Для решения этой задачи пробовали несколько алгоритмов, остановились на Isolation Forest. 

- Ансамбль решающих деревьев
- Каждое строится до тех пор, пока каждый объект не будет в отдельном листе
- На каждой итерации выбирается случайный признак и случайное расщепление по нему
- Для каждого объекта мера его нормальности – среднее арифметическое глубин листьев, в которые он попал

Настраиваемые признаки:

- число деревьев
- объём выборки для построения одного дерева
- число признаков, которые используются для построения одного дерева
- **доля выбросов в выборке** (для выбора порога)

Доля выбросов выбиралась так, чтобы получить 75 аномалий. 

## 4. Результаты

После применения модели было выделено 75 человек, являющихся аномалиями в данных. Попробуем объяснить, почему они могли действительно быть шпионами. 