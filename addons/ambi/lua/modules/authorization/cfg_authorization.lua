Ambi.General.CreateModule( 'Authorization', '1', 'https://steamcommunity.com/id/titanovsky/' )

-- --------------------------------------------------------------------------------------------------------------------------------------
Ambi.Authorization.Config.can_kick = true -- Кикать при срабатываний анти чита?

Ambi.Authorization.Config.background = { -- Таблица с данными для фона
    color = Color( 19, 19, 19),
    sound_url = 'https://github.com/Titanovsky/ambition_sites/raw/main/Lemmino%20-%20Cipher.mp3',
    sound_volume = 0.6,
}

Ambi.Authorization.Config.header = {-- Таблица с данными для самого верхнего заголовка
    text = 'Мистик РП', -- текст
    font = '64 Ambi', -- шрифт
    color = Color( 145, 33, 33 ), -- цвет
}

Ambi.Authorization.Config.subheader = { -- Таблица с данными для подзаголовка
    text = '', -- текст
    font = '38 Vinnytsia Sans Bold', -- шрифт
    color = Color( 81, 168, 211), -- цвет
}

Ambi.Authorization.Config.logo = { -- Таблица с данными для логотипа
    name = 'mystic_rp_logo', -- Название файла и материала (Желательно должен быть уникальным)
    url = 'https://i.ibb.co/MZtT2xh/logo1-mystic.png', -- Ссылка на лого
    color = Color( 255, 255, 255),
}

Ambi.Authorization.Config.genders = { -- Таблица с гендерами
    'Мужской',
    'Женский',
    'Трансгендер',
}

Ambi.Authorization.Config.nationalities = { -- Таблица с национальностями
    'Американец',
    'Русский',
    'Француз',
    'Немец',
    'Итальянец',
    'Японец',
    'Украинец',
    'Чеченец',
}

Ambi.Authorization.Config.headers_post_authorization = { -- Цитаты после того, как игрок авторизуется
    'Вы чувствуете чьё то злобное внимание',
}

-- --------------------------------------------------------------------------------------------------------------------------------------
Ambi.Authorization.Config.check_name_min_len = 2 -- Минимальная длина Имени и Фамилий (UTF-8)
Ambi.Authorization.Config.check_name_max_len = 28 -- Максимальная длина Имени и Фамилий (UTF-8)
Ambi.Authorization.Config.check_name_bad_symbols = true -- Проверять на запретные символы

Ambi.Authorization.Config.check_age_min = 16 -- Минимальный возраст
Ambi.Authorization.Config.check_age_max = 100 -- Максимальный возраст

-- --------------------------------------------------------------------------------------------------------------------------------------
Ambi.Authorization.Config.default_name = 'Безымянный'
Ambi.Authorization.Config.default_last_name = 'Бесфамильный'
Ambi.Authorization.Config.default_age = 18
Ambi.Authorization.Config.default_gender = 'Бесполый'
Ambi.Authorization.Config.default_nationality = 'Безнациональный'