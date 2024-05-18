﻿ 
 &НаСервере
 Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	 Если Не Объект.Ссылка.Пустая() Тогда
		 ЦенаПродажи = РаботаСЦенами.ПолучитьЦенуПродажи(Объект.Ссылка);
	 КонецЕсли;
 КонецПроцедуры   
 
 &НаКлиенте
 Процедура ИзменитьЦену(Команда)
	 Если Объект.Ссылка.Пустая() Тогда 
		 Сообщить("Перед установкой цены необходимо записать документ!");
	 Иначе     
		 ОткрытьФорму("Справочник.Номенклатура.Форма.ФормаСозданияЦены",Новый Структура("Номенклатура", Объект.Ссылка),,,,, Новый ОписаниеОповещения("ПослеИзмененияЦены", ЭтаФорма),РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс); 
	 КонецЕсли;
 КонецПроцедуры
 
 &НаКлиенте
 Процедура ПослеИзмененияЦены(Результат, ДополнительныеПараметры) Экспорт    
	 ЦенаПродажи =  РаботаСЦенами.ПолучитьЦенуПродажи(Объект.Ссылка);
 КонецПроцедуры
 
 &НаКлиенте
 Процедура СчетБухгалтерскогоУчетаНачалоВыбора(Элемент, ДанныеВыбора, ВыборДобавлением, СтандартнаяОбработка)
	 СтандартнаяОбработка = Ложь;
	 
	 СписокДоступныхЗначений = Новый СписокЗначений;
	 Если Объект.ТипНоменклатуры = ПредопределенноеЗначение("Перечисление.ТипыНоменклатуры.Товар") Тогда
		 СписокДоступныхЗначений.Добавить(ПредопределенноеЗначение("ПланСчетов.Хозрасчетный.Товары"));
	 ИначеЕсли Объект.ТипНоменклатуры = Предопределенноезначение("Перечисление.ТипыНоменклатуры.Материал") Тогда
		 СписокДоступныхЗначений.Добавить(Предопределенноезначение("ПланСчетов.Хозрасчетный.Материалы"));
	 ИначеЕсли Объект.ТипНоменклатуры = ПредопределенноеЗначение("Перечисление.ТипыНоменклатуры.Услуга") Тогда
		 СписокДоступныхЗначений.Добавить(ПредопределенноеЗначение("ПланСчетов.Хозрасчетный.РасходыНаПродажу"));
		 СписокДоступныхЗначений.Добавить(ПредопределенноеЗначение("ПланСчетов.Хозрасчетный.ПрочиеДоходыИРасходы"));
	 Иначе 
		 СписокДоступныхЗначений.Добавить(ПредопределенноеЗначение("ПланСчетов.Хозрасчетный.ПустаяСсылка"));
	 КонецЕсли;
	 ДанныеВыбора = СписокДоступныхЗначений;
 КонецПроцедуры
 
 &НаКлиенте
 Процедура ТипНоменклатурыПриИзменении(Элемент)
	 Если Объект.ТипНоменклатуры = ПредопределенноеЗначение("Перечисление.ТипыНоменклатуры.Материал") Тогда
		 УстановитьПараметрыВыбора( ПредопределенноеЗначение("ПланСчетов.Хозрасчетный.Материалы"));
		 Объект.СчетБухгалтерскогоУчета = ПредопределенноеЗначение("ПланСчетов.Хозрасчетный.Материалы");  	
	 ИначеЕсли Объект.ТипНоменклатуры = ПредопределенноеЗначение("Перечисление.ТипыНоменклатуры.Товар") Тогда
		 Объект.СчетБухгалтерскогоУчета = ПредопределенноеЗначение("ПланСчетов.Хозрасчетный.Товары");
		 УстановитьПараметрыВыбора(ПредопределенноеЗначение("ПланСчетов.Хозрасчетный.Товары"));
	 ИначеЕсли Объект.ТипНоменклатуры = ПредопределенноеЗначение("Перечисление.ТипыНоменклатуры.Услуга") Тогда
		 Объект.СчетБухгалтерскогоУчета = ПредопределенноеЗначение("ПланСчетов.Хозрасчетный.РасходыНаПродажу");
		 УстановитьПараметрыВыбора(ПредопределенноеЗначение("ПланСчетов.Хозрасчетный.РасходыНаПродажу"));	 
	 КонецЕсли;
 КонецПроцедуры
 
&НаКлиенте
Процедура УстановитьПараметрыВыбора(Счет) 
	 
	НовыйМассив = Новый Массив();  
	НовыйМассив.Добавить(Новый ПараметрВыбора("Отбор.Ссылка",Счет));
	НовыйПараметр = Новый ФиксированныйМассив(НовыйМассив);
	Элементы.СчетБухгалтерскогоУчета.ПараметрыВыбора = НовыйПараметр;	

КонецПроцедуры 

 
