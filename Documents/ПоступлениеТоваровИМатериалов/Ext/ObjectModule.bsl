﻿
Процедура ОбработкаПроведения(Отказ, Режим)   
	
	СтруктураУчетнаяПолитика = РегистрыСведений.УчетнаяПолитика.ПолучитьПоследнее(Дата);
	Если СтруктураУчетнаяПолитика.УчетнаяПолитика = Перечисления.ВидыУчетнойПолитики.FEFO Тогда
		ОтражатьСрокиГодности = Истина;
	Иначе ОтражатьСрокиГодности = Ложь;  
	КонецЕсли;
	
	Движения.ТоварыНаСкладах.Записывать = Истина;  
	Движения.Хозрасчетный.Записывать = Истина;

	Запрос = Новый Запрос; 
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Запрос.Текст = "ВЫБРАТЬ
	               |	ПоступлениеТоваровИМатериаловТоварыИМатериалы.Товар КАК Товар,
	               |	СУММА(ПоступлениеТоваровИМатериаловТоварыИМатериалы.Количество) КАК Количество,
	               |	ПоступлениеТоваровИМатериаловТоварыИМатериалы.Цена КАК Цена,
	               |	СУММА(ПоступлениеТоваровИМатериаловТоварыИМатериалы.Сумма) КАК Сумма,
	               |	ПоступлениеТоваровИМатериаловТоварыИМатериалы.СрокГодности КАК СрокГодности,
	               |	ПоступлениеТоваровИМатериаловТоварыИМатериалы.Товар.СчетБухгалтерскогоУчета КАК СчетБухгалтерскогоУчета
	               |ИЗ
	               |	Документ.ПоступлениеТоваровИМатериалов.ТоварыИМатериалы КАК ПоступлениеТоваровИМатериаловТоварыИМатериалы
	               |ГДЕ
	               |	ПоступлениеТоваровИМатериаловТоварыИМатериалы.Ссылка = &Ссылка
	               |
	               |СГРУППИРОВАТЬ ПО
	               |	ПоступлениеТоваровИМатериаловТоварыИМатериалы.Товар,
	               |	ПоступлениеТоваровИМатериаловТоварыИМатериалы.Цена,
	               |	ПоступлениеТоваровИМатериаловТоварыИМатериалы.СрокГодности";
	
	Выборка = Запрос.Выполнить().Выбрать(); 
	Пока Выборка.Следующий() Цикл
		Движение = Движения.ТоварыНаСкладах.ДобавитьПриход();
		Движение.Период = Дата; 
		Движение.Номенклатура = Выборка.Товар;
		Движение.Склад = Склад; 	
		Движение.Количество = Выборка.Количество;  
		Движение.Сумма = Выборка.Сумма;
		Если ОтражатьСрокиГодности Тогда
			Движение.СрокГодности = Выборка.СрокГодности;
		КонецЕсли;	 
	
		Движение = Движения.Хозрасчетный.Добавить();
		Движение.Период = Дата;
		Движение.Сумма = Выборка.Сумма; 
		Движение.Содержание = "Отражено поступление товарно-материальных ценностей от поставщика";
		Движение.СчетДт = Выборка.СчетБухгалтерскогоУчета;
		Движение.СчетКт = ПланыСчетов.Хозрасчетный.РасчетыСПоставщиками;
		Движение.СубконтоДт[ПланыВидовХарактеристик.ВидыСубконтоХозрасчетные.Номенклатура] = Выборка.Товар;
		Движение.СубконтоКт[ПланыВидовХарактеристик.ВидыСубконтоХозрасчетные.Контрагенты] = Поставщик;
    КонецЦикла;
		
КонецПроцедуры   

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения) 
	
	СуммаДокумента = ТоварыИМатериалы.Итог("Сумма");
	
КонецПроцедуры

