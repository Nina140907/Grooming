﻿
Процедура ПриЗаписи(Отказ)
	Если Не ЭтотОбъект.Клиент.Пустая() И ЭтотОбъект.ПометкаУдаления = Ложь Тогда
		БизнесПроцесс = БизнесПроцессы.ДорегистрацияПользователя.СоздатьБизнесПроцесс();
		БизнесПроцесс.Дата = ТекущаяДата();   
		БизнесПроцесс.Пользователь = Ссылка;
		БизнесПроцесс.Записать();
		БизнесПроцесс.Старт(); 
	КонецЕсли;

КонецПроцедуры


