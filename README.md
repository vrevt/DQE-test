# DQE-test
Тестовое задание на позицию Marketing Data Quality Engineer

## task 4
### 0. Подготовка
Так как мне привычнее работать с базой, чем с таблицей я загрузил 
__test.csv__ в postgres в таблицу _test_csv_ (использовав поля из условия).
Уже на этапе переноса я получил ошибки несоответствия типов. 
Пока проигнорирую это и буду использовать тип text в бд.
### 1. Пункты проверки
* В первую очередь проверю есть ли в таблице null. 
Само по себе значение null не ошибка, но, возможно, мы теряем данные (либо
потеряем в будущем при использовании данной таблицы).
* Проверю, что в каждой колонке содержатся данные, соответствующие 
заданному ей формату поля.
  * install_date - проверим на соответствие даты YYYY-MM-DD.
  * country - проверим на соответствие двухбуквенному коду.
  * campaign_id - проверим, является ли значение числом.
  * campaign_name - допустим любой текст.
  * installs - число (которое по смыслу, скорее всего, должно быть неотрицательным).
* Проверю экстремумы для колонок - min/max для install_date и installs.
* Проверю не потеряны ли данные за какие-либо даты.
* Найду сумму installs по каждой дате (дате и стране) и проверю нет ли выбивающихся значений из 
общего диапазона (возможно мы теряли данные installs за эту дату (страну), или добавили дубликаты).
### 2. Найденные проблемы
Все SQL query для извлечения описываемых данных сохранены в __task_4.sql__.
Таблицы ниже для удобного ознакомления.
* __значения null в следующих записях__

campaign_id (2 записи):

install_date | country | campaign_id | campaign_name | installs
- | --- |-----------| --- | ---
2022-04-17|CC|null|.3k8Egg2ahGH1DF08Dck|2264
2022-06-06|CA|null|h21iChHb974dDb9F3E.g|3752

country (988 записей)

install_date | country | campaign_id | campaign_name | installs
- |-------| -- | --- | ---
2022-12-12|null|4366414684|GiaF0cD_iCG-7BD-1KH.|2278
2022-06-25|null|3564730093|64k4_CB9hae97Ff62CcI|4226

* __Несоответствие формату__

country (1015 записей)

install_date | country | campaign_id | campaign_name | installs
- |---------| --- | --- | ---
2022-12-11|         |1622248465|bBfh2_247c48B7449d5.|3405
2022-09-18| N/A     |4913236576|223ebC.AK5b0bE5kGFf1|4786
2022-09-02| 59      |3740410419|Dc_Ei_cC8cHcK2A5hB8F|1846

campaign_id (3 записи)

install_date | country | campaign_id | campaign_name | installs
- | --- | --- | --- | ---
2022-11-18|GR|(cid)|B3a798eD1C0D-EkDH5E4|1392
2022-05-16|ZZ|$CAMPAIGN_ID$|id.FH0F23ci8bG2hD693|4985
2022-04-25|CU|7A8ihHf4_D4gK4H13aa5|7A8ihHf4_D4gK4H13aa5|2475

* __подозрительные значения__

отрицательное installs (973 записи)

install_date | country | campaign_id | campaign_name | installs
- | --- | --- | --- | ---
2022-09-01|US|1255485065|hF.9k.cC0c4ABDF8AEhH|-1

installs в 10 раз больше среднего installs (maxint, 2 записи)

install_date | country | campaign_id | campaign_name | installs
- | --- | --- | --- | ---
2023-03-15|US|1371207243|B-8HhcHKB9bd.94c46-1|2147483647
2022-12-18|BY|9419499089|A6A8_8CGdCKd733.-9dC|2147483647

install_date за 1970 год (2 записи)

install_date | country | campaign_id | campaign_name | installs
- | --- | --- | --- | ---
1970-01-01|BY|4798685209|E7kB1e49.IDKBh9fHkd-|4928
1970-01-01|IN|5916072091|aI64GD39hB08af.k4c7G|1703

install_date за 2300 год (3 записи)

install_date | country | campaign_id | campaign_name | installs
- | --- | --- | --- | ---
2300-12-10|CH|9909523883|0.i6ki0fIE4KfHg5IcF1|3814
2023-03-21|BR|9914978793|k2d_4AfH_6edkcD.C52.|801
2023-03-21|CU|9942975992|9kE838D9a0.i106KFc-9|146

записей с country = GB только 2. С другими country от 1035 до 8126.

country | record_cnt
- | -
GB|2
null|988
EU|1044
US|7845


* __Очень косвенные догадки__

У 3 campaign_id есть не уникальные campaign_name, у двух из них совпадение и по country. 
Все остальные campaign_id имеют уникальный campaign_name

install_date | country | campaign_id | campaign_name      | installs
- | --- | --- |--------------------| ---
2023-02-05|CA|2905851120|IHiAa2-KF21CHC-6B3bC|3916
2022-04-07|BY|2905851120|63baEbg0adgFhF0489G5|957

install_date | country | campaign_id | campaign_name | installs
- | --- | --- | --- | ---
2022-05-10|UK|9935450190|k0fH_1EeCf877772c9aF|725
2022-03-24|UK|9935450190|a0kBH6A46KFd5Ib42.4-|4084
2022-08-19|ID|9177739839|GGfADG597cG84206c.5k|4322
2023-02-05|ID|9177739839|IE1E9HB5gF.-a23aIK63|2982
