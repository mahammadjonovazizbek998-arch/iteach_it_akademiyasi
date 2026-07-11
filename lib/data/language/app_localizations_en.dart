// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get iTeach => 'ITeach';

  @override
  String get iT => 'IT';

  @override
  String get akademiyasi => 'Academy';

  @override
  String get logotext =>
      'Unified management system for students, teachers, and administrators.';

  @override
  String get tizimga => 'Sign in';

  @override
  String get hisobingizgaKiring => 'Log in to your account';

  @override
  String get login => 'Log In';

  @override
  String get password => 'Password';

  @override
  String get enterLogin => 'Enter login';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get contactAdmin => 'Contact admin';

  @override
  String get loginCannotBeEmpty => 'Login field cannot be empty';

  @override
  String get passwordCannotBeEmpty => 'Password field cannot be empty';

  @override
  String get passwordTooShort => 'Password cannot be less than 6 characters';

  @override
  String get userNotFound => 'User not found, please try again';

  @override
  String get serverConnectionError =>
      'No connection to the server! Please check your internet or the server might be down.';

  @override
  String get unstableNetworkOrServerError => 'Unstable network or server error';

  @override
  String get home => 'Home';

  @override
  String get groups => 'Groups';

  @override
  String get tasks => 'Tasks';

  @override
  String get rating => 'Rating';

  @override
  String get profile => 'Profile';

  @override
  String get myGroups => 'My Groups';

  @override
  String get emptyGroups => 'No groups available yet.';

  @override
  String get emptyTasks => 'No tasks available yet.';

  @override
  String get todaysLessons => 'Today\'s lessons';

  @override
  String lessonsCount(Object count) {
    return 'You have $count lessons today';
  }

  @override
  String timeAt(Object time) {
    return 'at $time';
  }

  @override
  String get started => 'Started';

  @override
  String lessonTime(Object time) {
    return '$time started';
  }

  @override
  String get activeGroups => 'Active groups';

  @override
  String get inactiveGroups => 'Inactive groups';

  @override
  String get active => 'Active';

  @override
  String get inactive => 'Inactive';

  @override
  String get profileLoading => 'Loading profile details...';

  @override
  String get data => 'Data';

  @override
  String get loginLabel => 'Login';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get biography => 'Biography';

  @override
  String get biographyFieldEmpty => 'Biography field is empty';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get editBio => 'Edit biography';

  @override
  String get personalInfo => 'Personal information';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get noChangesDetected => 'No changes detected';

  @override
  String get editPersonalInfo => 'Edit personal information';

  @override
  String get fullName => 'Full name';

  @override
  String get username => 'Username';

  @override
  String get invalidFullName => 'Name field is empty or invalid';

  @override
  String get invalidPhoneNumber => 'Phone number is empty or invalid';

  @override
  String get ratingLoading => 'Loading rating page data...';

  @override
  String get ratingLoadError =>
      'An error occurred while loading rating page data';

  @override
  String get all => 'All';

  @override
  String get month => 'Month';

  @override
  String get week => 'Week';

  @override
  String get score => 'Score';

  @override
  String get tasksLoading => 'Loading tasks page data...';

  @override
  String get tasksLoadError =>
      'An error occurred while loading tasks page data';

  @override
  String get noDataFound => 'No data found at the moment';

  @override
  String greetingWithName(Object name) {
    return 'Peace be upon you, $name!';
  }

  @override
  String get greatDayToLearn => 'Today is a great day to learn.';

  @override
  String fourItems(Object n) {
    return '$n items';
  }

  @override
  String get newTasks => 'New tasks';

  @override
  String get sentItems => 'Sent';

  @override
  String get submitTask => 'Submit task';

  @override
  String get noTasksAvailable => 'You have no tasks';

  @override
  String get taskFiles => 'Task files';

  @override
  String get gradedItems => 'Graded';
}
