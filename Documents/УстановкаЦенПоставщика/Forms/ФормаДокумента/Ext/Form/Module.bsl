﻿&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Не ЗначениеЗаполнено(Объект.Ответственный) Тогда
		Объект.Ответственный = Параметрысеанса.ТекущийПользователь;
	КонецЕсли; 
КонецПроцедуры
