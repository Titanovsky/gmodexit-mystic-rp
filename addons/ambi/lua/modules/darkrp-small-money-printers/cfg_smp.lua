Ambi.General.CreateModule( 'SmallMoneyPrinters' )

-- ====================================================================================================================================================== --
Ambi.SmallMoneyPrinters.Config.enable = true -- Будут работать Small Money Printers?
Ambi.SmallMoneyPrinters.Config.draw_distance = 600 -- Дистанция при которой будет отрисовываться информация принтера
Ambi.SmallMoneyPrinters.Config.repair = 50 -- Сколько здоровья восстановит Ремонтный Комплект
Ambi.SmallMoneyPrinters.Config.repair_class = 'darkrp_repair_kit' -- Класс энтити, которая починит Денежный Принтер
Ambi.SmallMoneyPrinters.Config.upgrader_class = 'smp_upgrader' -- Класс энтити, которая улучшит принтер и потом уничтожится
Ambi.SmallMoneyPrinters.Config.create_shop_item = false -- Создать в DarkRP магазине? [НУЖЕН РЕСТАРТ]

-- ====================================================================================================================================================== --
-- Max 4 upgrades
Ambi.SmallMoneyPrinters.Config.zero_printer_delay = 60      -- Задержка производства денег в секундах
Ambi.SmallMoneyPrinters.Config.zero_printer_minus_delay = 20 -- Уменьшение задержки за каждый уровень (Умножается на улучшение)
Ambi.SmallMoneyPrinters.Config.zero_printer_amount = 25      -- Количество денег за оборот (Умножается на улучшение)
Ambi.SmallMoneyPrinters.Config.zero_printer_health = 300     -- Максимальное количество и его здоровье при спавне

-- ====================================================================================================================================================== --
-- Max 3 upgrades
Ambi.SmallMoneyPrinters.Config.colourful_printer_delay = 30       -- Задержка производства денег в секундах
Ambi.SmallMoneyPrinters.Config.colourful_printer_minus_delay = 10 -- Уменьшение задержки за каждый уровень (Умножается на улучшение)
Ambi.SmallMoneyPrinters.Config.colourful_printer_amount = 50      -- Количество денег за оборот (Умножается на улучшение)
Ambi.SmallMoneyPrinters.Config.colourful_printer_health = 500     -- Максимальное количество и его здоровье при спавне

-- ====================================================================================================================================================== --
-- Max 2 upgrades
Ambi.SmallMoneyPrinters.Config.quantum_printer_delay = 10       -- Задержка производства денег в секундах
Ambi.SmallMoneyPrinters.Config.quantum_printer_minus_delay = 10 -- Уменьшение задержки за каждый уровень (Умножается на улучшение)
Ambi.SmallMoneyPrinters.Config.quantum_printer_amount = 80      -- Количество денег за оборот (Умножается на улучшение)
Ambi.SmallMoneyPrinters.Config.quantum_printer_health = 600     -- Максимальное количество и его здоровье при спавне

-- ====================================================================================================================================================== --
-- No any upgrade
Ambi.SmallMoneyPrinters.Config.vip_printer_delay = 5             -- Задержка производства денег в секундах
Ambi.SmallMoneyPrinters.Config.vip_printer_min_random_amount = 10 -- Минимальное количество рандомных денег
Ambi.SmallMoneyPrinters.Config.vip_printer_max_random_amount = 45 -- Минимальное количество рандомных денег
Ambi.SmallMoneyPrinters.Config.vip_printer_health = 600           -- Максимальное количество и его здоровье при спавне

-- ====================================================================================================================================================== --
-- No any upgrade
Ambi.SmallMoneyPrinters.Config.premium_printer_delay = 1              -- Задержка производства денег в секундах
Ambi.SmallMoneyPrinters.Config.premium_printer_min_random_amount = 25 -- Минимальное количество рандомных денег
Ambi.SmallMoneyPrinters.Config.premium_printer_max_random_amount = 75 -- Минимальное количество рандомных денег
Ambi.SmallMoneyPrinters.Config.premium_printer_health = 800           -- Максимальное количество и его здоровье при спавне