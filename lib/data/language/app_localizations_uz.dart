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

  @override
  String get profileLoading => 'Profil ma’lumotlari tayyorlanmoqda...';

  @override
  String get data => 'Ma’lumotlar';

  @override
  String get loginLabel => 'Login';

  @override
  String get phoneNumber => 'Telefon raqami';

  @override
  String get biography => 'Biografiya';

  @override
  String get biographyFieldEmpty => 'Biografiya maydoni bo‘sh';

  @override
  String get editProfile => 'Profilni tahrirlash';

  @override
  String get editBio => 'Biografiyani tahrirlash';

  @override
  String get personalInfo => 'Shaxsiy ma’lumotlar';

  @override
  String get save => 'Saqlash';

  @override
  String get cancel => 'Bekor qilish';

  @override
  String get noChangesDetected => 'O\'zgarish mavjud emas';

  @override
  String get editPersonalInfo => 'Shaxsiy ma\'lumotlarni tahrirlash';

  @override
  String get fullName => 'To‘liq ism';

  @override
  String get username => 'Foydalanuvchi nomi';

  @override
  String get invalidFullName => 'Ism maydoni bo‘sh yoki noto‘g‘ri to‘ldirilgan';

  @override
  String get invalidPhoneNumber =>
      'Telefon raqami bo‘sh yoki noto‘g‘ri kiritilgan';

  @override
  String get ratingLoading =>
      'Reyting sahifasi ma\'lumotlari tayyorlanmoqda...';

  @override
  String get ratingLoadError =>
      'Reyting sahifasi ma\'lumotlarini olishda xatolik yuz berdi';

  @override
  String get all => 'Barchasi';

  @override
  String get month => 'Oy';

  @override
  String get week => 'Hafta';

  @override
  String get score => 'Ball';

  @override
  String get tasksLoading =>
      'Topshiriqlar sahifasi ma\'lumotlari tayyorlanmoqda...';

  @override
  String get tasksLoadError =>
      'Topshiriqlar sahifasi ma\'lumotlarini olishda xatolik yuz berdi';

  @override
  String get noDataFound => 'Hozircha ma\'lumotlar mavjud emas';

  @override
  String greetingWithName(Object name) {
    return 'Assalomu alaykum, $name!';
  }

  @override
  String get greatDayToLearn => 'Bugun o\'rganish uchun ajoyib kun.';

  @override
  String fourItems(Object n) {
    return '$n ta';
  }

  @override
  String get newTasks => 'Yangi topshiriqlar';

  @override
  String get sentItems => 'Yuborilganlar';

  @override
  String get submitTask => 'Topshiriq topshirish';

  @override
  String get noTasksAvailable => 'Sizning topshiriqlaringiz mavjud emas';

  @override
  String get taskFiles => 'Vazifa fayllari';

  @override
  String get gradedItems => 'Baholanganlar';
}
