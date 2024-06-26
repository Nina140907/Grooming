﻿Функция ПолучитьЦенуПродажи (Номенклатура, ВидЦены = Неопределено, ДатаЦены = Неопределено) Экспорт
	Если ВидЦены = Неопределено Тогда
		ВидЦены = Перечисления.ВидЦены.Розничная;
	КонецЕсли;
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	ЦеныНоменклатурыСрезПоследних.Цена КАК Цена,
	|	ЦеныНоменклатурыСрезПоследних.Номенклатура КАК Номенклатура
	|ИЗ
	|	РегистрСведений.ЦеныНоменклатуры.СрезПоследних(
	|			&Период,
	|			Номенклатура = &Номенклатура
	|				И ВидЦены = &ВидЦены) КАК ЦеныНоменклатурыСрезПоследних"; 
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	Запрос.УстановитьПараметр("Период", ДатаЦены);
	Запрос.УстановитьПараметр("ВидЦены", ВидЦены);  
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Сообщить("В базе данных не найдены цены для данной номенклатуры!");
		возврат 0;
	КонецЕсли;   
	
	Выборка = РезультатЗапроса.Выбрать(); 
	Выборка.Следующий();
	возврат Выборка.Цена;
	
КонецФункции
Функция ПолучитьЗаписьЦеныНаКонкретнуюДату(Номенклатура, ВидЦены, ДатаЦены) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	ЦеныНоменклатуры.Цена КАК Цена
	|ИЗ
	|	РегистрСведений.ЦеныНоменклатуры КАК ЦеныНоменклатуры
	|ГДЕ
	|	ЦеныНоменклатуры.Период = &Период
	|	И ЦеныНоменклатуры.Номенклатура = &Номенклатура
	|	И ЦеныНоменклатуры.ВидЦены = &ВидЦены";
	
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	Запрос.УстановитьПараметр("Период", ДатаЦены);
	Запрос.УстановитьПараметр("ВидЦены", ВидЦены);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		возврат 0;
	КонецЕсли;
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Выборка.Следующий();
	
	возврат Выборка.Цена;
	
КонецФункции 

Функция ПолучитьЦенуПоставщика (Номенклатура, Дата, Поставщик) Экспорт 
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	Запрос.УстановитьПараметр("Дата",Дата);
	Запрос.УстановитьПараметр("Поставщик", Поставщик); 
	
	Если ТипЗнч(Номенклатура) = Тип("Массив") Тогда
		ТабЗнач = Новый ТаблицаЗначений;
		ТабЗнач.Колонки.Добавить("Номенклатура",Новый ОписаниеТипов("СправочникСсылка.Номенклатура"));
		Для каждого Элемент Из Номенклатура Цикл
			НоваяСтр = ТабЗнач.Добавить();
			НоваяСтр.Номенклатура = Элемент;
		КонецЦикла;
		Запрос.УстановитьПараметр("ТабЗнач", ТабЗнач); 
		Запрос.Текст = "ВЫБРАТЬ
		|	ТабЗнач.Номенклатура КАК НоменклатураИзДокумента
		|ПОМЕСТИТЬ ВТ_ТабЗнач
		|ИЗ
		|	&ТабЗнач КАК ТабЗнач
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ЕСТЬNULL(ЦеныНоменклатурыПоставщиковСрезПоследних.Цена, 0) КАК Цена
		|ИЗ
		|	ВТ_ТабЗнач КАК ВТ_ТабЗнач
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ЦеныНоменклатурыПоставщиков.СрезПоследних(
		|				&Дата,
		|				Поставщик = &Поставщик
		|					И Номенклатура В (&Номенклатура)) КАК ЦеныНоменклатурыПоставщиковСрезПоследних
		|		ПО ВТ_ТабЗнач.НоменклатураИзДокумента = ЦеныНоменклатурыПоставщиковСрезПоследних.Номенклатура"; 
	Иначе 
		Запрос.Текст = "ВЫБРАТЬ
		|	ЦеныНоменклатурыПоставщиковСрезПоследних.Номенклатура КАК Номенклатура,
		|	ЦеныНоменклатурыПоставщиковСрезПоследних.Цена КАК Цена
		|ИЗ
		|	РегистрСведений.ЦеныНоменклатурыПоставщиков.СрезПоследних(
		|			&Дата,
		|			Поставщик = &Поставщик
		|				И Номенклатура = &Номенклатура) КАК ЦеныНоменклатурыПоставщиковСрезПоследних"
	КонецЕсли;
	РезультатЗапроса = Запрос.Выполнить(); 
	МассивЦен = Новый Массив;
	Если РезультатЗапроса.Пустой() Тогда 
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = СтрШаблон("В базе данных не найдены цены для  номенклатуры %1",Номенклатура);
		Сообщение.Сообщить(); 
		МассивЦен.Добавить("0");
		возврат МассивЦен;
	КонецЕсли;   
	
	Выборка = РезультатЗапроса.Выбрать(); 
	
	Пока Выборка.Следующий() Цикл
		МассивЦен.Добавить(Выборка.Цена);
	КонецЦикла;   
	
	возврат МассивЦен; 
КонецФункции
