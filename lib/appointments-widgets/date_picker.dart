import 'package:flutter/material.dart';
import 'calendar_utils.dart';

class DatePicker {
  static Future<DateTime?> openDatePickerForMonth(
      BuildContext context, DateTime currentWeekStart) async {
    return await showDatePicker(
      context: context,
      initialDate: currentWeekStart,
      firstDate: DateTime(DateTime.now().year, DateTime.now().month, 1),
      lastDate: DateTime(DateTime.now().year, DateTime.now().month + 2, 0),
    );
  }
}
