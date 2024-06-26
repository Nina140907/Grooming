﻿
Функция getUserget(Запрос)
	Логин = Строка(Запрос.ПараметрыЗапроса.Получить("username")); 
	
	ЗапросПользователи = Новый Запрос;
	ЗапросПользователи.Текст = "ВЫБРАТЬ
	|    УНИКАЛЬНЫЙИДЕНТИФИКАТОР(Пользователи.Ссылка) КАК Ссылка,
	|    Пользователи.Наименование КАК Наименование,
	|    Пользователи.Код КАК Код
	|ИЗ
	|    Справочник.Пользователи КАК Пользователи
	|ГДЕ
	|    НЕ Пользователи.ПометкаУдаления
	|    И Пользователи.Наименование = &Наименование
	|
	|УПОРЯДОЧИТЬ ПО
	|    Наименование";
	
	ЗапросПользователи.УстановитьПараметр("Наименование", Логин); 
	
	РезультатЗапроса = ЗапросПользователи.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	Пока Выборка.Следующий() Цикл
		
		ДанныеПользователя = Новый Структура; 
		ДанныеПользователя.Вставить("guid", Строка(Выборка.Ссылка));
		ДанныеПользователя.Вставить("name", Строка(Выборка.Наименование));
		ДанныеПользователя.Вставить("code", Строка(Выборка.Код)); 
				
	КонецЦикла;
	
	Ответ = Новый HTTPСервисОтвет(200); 
	
	ЗаписьJSON = Новый ЗаписьJSON; 
	ЗаписьJSON.УстановитьСтроку();
	ЗаписатьJSON(ЗаписьJSON, ДанныеПользователя);
	СтрокаОтвета = ЗаписьJSON.Закрыть();
	
	Ответ.УстановитьТелоИзСтроки(СтрокаОтвета); 	
	Возврат Ответ; 
	
КонецФункции

