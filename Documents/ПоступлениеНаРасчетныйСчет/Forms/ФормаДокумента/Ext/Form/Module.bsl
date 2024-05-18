﻿
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	УстановитьВидимость();
КонецПроцедуры  

&НаКлиенте
Процедура УстановитьВидимость()
	ЭтоВзносНаличными = (Объект.ВидОперации = ПредопределенноеЗначение("Перечисление.ВидыОперацийПоступленияНаРасчетныйСчет.ВзносНаличными"));
	ЭтоОплатаОтПокупателя = (Объект.ВидОперации = ПредопределенноеЗначение("Перечисление.ВидыОперацийПоступленияНаРасчетныйСчет.ОплатаОтПокупателя"));
	ЭтоВозвратОтПоставщика = (Объект.ВидОперации = ПредопределенноеЗначение("Перечисление.ВидыОперацийПоступленияНаРасчетныйСчет.ВозвратОтПоставщика"));
	ЭтоОплатаПоБанковскимКартам = (Объект.ВидОперации = ПредопределенноеЗначение("Перечисление.ВидыОперацийПоступленияНаРасчетныйСчет.ОплатаПоБанковскимКартам"));   
	ЭтоПоступлениеСДругогоСчета = (Объект.ВидОперации = ПредопределенноеЗначение("Перечисление.ВидыОперацийПоступленияНаРасчетныйСчет.ПоступлениеСДругогоСчетаПредприятия"));
	КонтрагентЯвляетсяПоставщиком = КонтрагентЯвляетсяПоставщиком(Объект.Плательщик);
	
	Элементы.ЭквайринговыйТерминал.Видимость = ЭтоОплатаПобанковскимКартам;
	Элементы.Касса.Видимость = ЭтоВзносНаличными;
	Элементы.Плательщик.Видимость = ЭтоОплатаОтПокупателя ИЛИ ЭтоВозвратОтПоставщика;
	Элементы.ДоговорКонтрагента.Видимость = (ЭтоОплатаОтПокупателя ИЛИ ЭтоВозвратОтПоставщика) И КонтрагентЯвляетсяПоставщиком(Объект.Плательщик);  
	Элементы.СчетИсточник.Видимость = ЭтоПоступлениеСДругогоСчета;

КонецПроцедуры

&НаСервереБезКонтекста
Функция КонтрагентЯвляетсяПоставщиком(КонтрагентСсылка)
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("КонтрагентСсылка", КонтрагентСсылка);
	Запрос.УстановитьПараметр("ТипКонтрагентаКлиент",Перечисления.ТипыКонтрагентов.Клиент);
	Запрос.Текст = "ВЫБРАТЬ
	               |	Контрагенты.Ссылка КАК Ссылка
	               |ИЗ
	               |	Справочник.Контрагенты КАК Контрагенты
	               |ГДЕ
	               |	Контрагенты.Ссылка = &КонтрагентСсылка
	               |	И Контрагенты.ТипКонтрагента = &ТипКонтрагентаКлиент";
	Результат = Запрос.Выполнить();
	Возврат Результат.Пустой();
	
КонецФункции


&НаКлиенте
Процедура ВидОперацииПриИзменении(Элемент)
	Установитьвидимость();
КонецПроцедуры


&НаКлиенте
Процедура ПлательщикПриИзменении(Элемент)
	Установитьвидимость(); 
КонецПроцедуры


&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если НЕ ЗначениеЗаполнено(Объект.Ответственный)Тогда
		Объект.Ответственный = ПараметрыСеанса.ТекущийПользователь;
	КонецЕсли;
КонецПроцедуры
	
