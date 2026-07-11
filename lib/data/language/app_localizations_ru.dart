// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get iTeach => 'ITeach';

  @override
  String get iT => 'ИТ';

  @override
  String get akademiyasi => 'Академия';

  @override
  String get logotext =>
      'Единая система управления для студентов, преподавателей и администраторов.';

  @override
  String get tizimga => 'Войти';

  @override
  String get hisobingizgaKiring => 'Войдите в свой аккаунт';

  @override
  String get login => 'Войти';

  @override
  String get password => 'Пароль';

  @override
  String get enterLogin => 'Введите логин';

  @override
  String get enterPassword => 'Введите пароль';

  @override
  String get contactAdmin => 'Связаться с админом';

  @override
  String get loginCannotBeEmpty => 'Поле логина не может быть пустым';

  @override
  String get passwordCannotBeEmpty => 'Поле пароля не может быть пустым';

  @override
  String get passwordTooShort => 'Пароль не должен быть менее 6 символов';

  @override
  String get userNotFound =>
      'Пользователь не найден, пожалуйста, попробуйте еще раз';

  @override
  String get serverConnectionError =>
      'Нет связи с сервером! Проверьте интернет или сервер временно недоступен.';

  @override
  String get unstableNetworkOrServerError =>
      'Нестабильное соединение или ошибка сервера';

  @override
  String get home => 'Главная';

  @override
  String get groups => 'Группы';

  @override
  String get tasks => 'Задания';

  @override
  String get rating => 'Рейтинг';

  @override
  String get profile => 'Профиль';

  @override
  String get myGroups => 'Guruhlarim';

  @override
  String get emptyGroups => 'Группы пока отсутствуют.';

  @override
  String get emptyTasks => 'Заданий пока нет.';

  @override
  String get todaysLessons => 'Уроки на сегодня';

  @override
  String lessonsCount(Object count) {
    return 'У вас сегодня $count урока(ов)';
  }

  @override
  String timeAt(Object time) {
    return 'в $time';
  }

  @override
  String get started => 'Началось';

  @override
  String lessonTime(Object time) {
    return '$time началось';
  }

  @override
  String get activeGroups => 'Активные группы';

  @override
  String get inactiveGroups => 'Неактивные группы';

  @override
  String get active => 'Активный';

  @override
  String get inactive => 'Неактивный';

  @override
  String get profileLoading => 'Загрузка профиля...';

  @override
  String get data => 'Данные';

  @override
  String get loginLabel => 'Войти';

  @override
  String get phoneNumber => 'Номер телефона';

  @override
  String get biography => 'Биография';

  @override
  String get biographyFieldEmpty => 'Поле биографии пусто';

  @override
  String get editProfile => 'Редактировать профиль';

  @override
  String get editBio => 'Редактировать биографию';

  @override
  String get personalInfo => 'Личная информация';

  @override
  String get save => 'Сохранить';

  @override
  String get cancel => 'Отмена';

  @override
  String get noChangesDetected => 'Изменений нет';

  @override
  String get editPersonalInfo => 'Редактировать личную информацию';

  @override
  String get fullName => 'ФИО';

  @override
  String get username => 'Имя пользователя';

  @override
  String get invalidFullName => 'Поле имени пустое или заполнено неверно';

  @override
  String get invalidPhoneNumber => 'Номер телефона пуст или введен неверно';

  @override
  String get ratingLoading => 'Загрузка данных страницы рейтинга...';

  @override
  String get ratingLoadError =>
      'Произошла ошибка при загрузке данных страницы рейтинга';

  @override
  String get all => 'Все';

  @override
  String get month => 'Месяц';

  @override
  String get week => 'Неделя';

  @override
  String get score => 'Балл';

  @override
  String get tasksLoading => 'Загрузка данных страницы заданий...';

  @override
  String get tasksLoadError =>
      'Произошла ошибка при загрузке данных страницы заданий';

  @override
  String get noDataFound => 'На данный момент данных нет';

  @override
  String greetingWithName(Object name) {
    return 'Мир вам, $name!';
  }

  @override
  String get greatDayToLearn => 'Сегодня отличный день для обучения.';

  @override
  String fourItems(Object n) {
    return '$n шт';
  }

  @override
  String get newTasks => 'Новые задания';

  @override
  String get sentItems => 'Отправленные';

  @override
  String get submitTask => 'Сдать задание';

  @override
  String get noTasksAvailable => 'У вас нет заданий';

  @override
  String get taskFiles => 'Файлы задания';

  @override
  String get gradedItems => 'Оцененные';
}
