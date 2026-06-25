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
}
