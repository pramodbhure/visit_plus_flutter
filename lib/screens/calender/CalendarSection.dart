import 'package:flutter/material.dart';
import 'package:visitplusapp/screens/calender/calendar_utils.dart';
import 'package:visitplusapp/screens/calender/date_picker.dart';

class CalendarSection extends StatefulWidget {
  // ignore: use_super_parameters
  const CalendarSection({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CalendarSectionState createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  late DateTime currentWeekStart;
  late List<DateTime?> selectedDates;

  @override
  void initState() {
    super.initState();
    currentWeekStart = CalendarUtils.startOfWeek(DateTime.now());
    selectedDates = List.generate(5, (_) => null);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Schedules',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () => _openDatePickerForMonth(context),
                  child: Row(
                    children: [
                      Text(
                        '${CalendarUtils.getMonthName(currentWeekStart.month)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(5, (index) {
                final currentDate = currentWeekStart.add(Duration(days: index));
                return GestureDetector(
                  onTap: () => _selectDate(index, currentDate),
                  child: _buildDateContainer(currentDate, index),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateContainer(DateTime date, int index) {
    final isSelected =
        selectedDates[index] != null && selectedDates[index]!.day == date.day;
    return Container(
      width: 60,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF73C2EF) : Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${date.day}',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 14,
              ),
            ),
            Text(
              CalendarUtils.getDayOfWeek(date),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openDatePickerForMonth(BuildContext context) async {
    final DateTime? picked =
        await DatePicker.openDatePickerForMonth(context, currentWeekStart);
    if (picked != null) {
      setState(() {
        currentWeekStart = CalendarUtils.startOfWeek(picked);
        selectedDates = List.generate(5, (_) => null); // Reset selected dates
      });
      // Handle date selection
      print('Selected date: $picked');
    }
  }

  void _selectDate(int index, DateTime date) {
    setState(() {
      // Deselect previously selected date
      for (int i = 0; i < selectedDates.length; i++) {
        if (i != index) {
          selectedDates[i] = null;
        }
      }
      // Select the new date
      selectedDates[index] = date;
    });
    // Save selected date somewhere
    print('Selected date: $date');
  }
}
