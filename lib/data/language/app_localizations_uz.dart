// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get iTeach => 'ITeach';

  @override
  String get iT => 'IT';

  @override
  String get akademiyasi => 'Akademiyasi';

  @override
  String get logotext =>
      'O\'quvchilar, ustozlar va adminlar uchun yagona boshqaruv tizimi';

  @override
  String get tizimga => 'Tizimga kirish';

  @override
  String get hisobingizgaKiring => 'Hisobingizga kiring';

  @override
  String get login => 'Kirish';

  @override
  String get password => 'Parol';

  @override
  String get enterLogin => 'Loginni kiriting';

  @override
  String get enterPassword => 'Parolni kiriting';

  @override
  String get contactAdmin => 'Admin bilan bog\'lanish';

  @override
  String get loginCannotBeEmpty => 'Login maydoni bo\'sh qolishi mumkin emas';

  @override
  String get passwordCannotBeEmpty =>
      'Parol maydoni bo\'sh qolishi mumkin emas';

  @override
  String get passwordTooShort => 'Parol 6 belgidan kam bo\'lishi mumkin emas';

  @override
  String get userNotFound =>
      'Bunday foydalanuvchi topilmadi, iltimos qayta urinib ko\'ring';

  @override
  String get serverConnectionError =>
      'Server bilan aloqa yo\'q! Internetni tekshiring yoki server ishlamayapti.';

  @override
  String get unstableNetworkOrServerError =>
      'Tarmoq barqaror emas yoki server xatoligi';

  @override
  String get home => 'Asosiy';

  @override
  String get groups => 'Guruhlar';

  @override
  String get tasks => 'Topshiriqlar';

  @override
  String get rating => 'Reyting';

  @override
  String get profile => 'Profil';

  @override
  String get myGroups => 'Guruhlarim';

  @override
  String get emptyGroups => 'Hozircha guruhlar mavjud emas.';

  @override
  String get emptyTasks => 'Hozircha topshiriqlar yo\'q.';

  @override
  String get todaysLessons => 'Bugungi darslar';

  @override
  String lessonsCount(Object count) {
    return 'Bugun sizda $count ta dars bor';
  }

  @override
  String timeAt(Object time) {
    return '$time da';
  }

  @override
  String get started => 'Boshlandi';

  @override
  String lessonTime(Object time) {
    return '$time da boshlandi';
  }

  @override
  String get activeGroups => 'Faol guruhlar';

  @override
  String get inactiveGroups => 'Faol bo‘lmagan guruhlar';

  @override
  String get active => 'Faol';

  @override
  String get inactive => 'Nofaol';
}
