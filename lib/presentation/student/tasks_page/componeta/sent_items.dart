import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iteach_it_akademiyasi/data/language/app_localizations.dart';
import 'package:iteach_it_akademiyasi/data/theme/theme_class.dart';
import 'package:iteach_it_akademiyasi/logon/student/tasks/tasks_cubit.dart';

class SentItems extends StatefulWidget {
  const SentItems({super.key});

  @override
  State<SentItems> createState() => _SentItemsState();
}

class _SentItemsState extends State<SentItems> {
  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    final myLanguage = AppLocalizations.of(context)!;
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: .min,
          children: [
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  myLanguage.sentItems,
                  style: TextStyle(fontSize: 20.sp, fontWeight: .bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    myLanguage.all,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: myTheme.profilColor,
                    ),
                  ),
                ),
              ],
            ),
            // ListView.builder(itemCount: state,
            //     itemBuilder: itemBuilder)
          ],
        );
      },
    );
  }
}
