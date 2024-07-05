import 'package:flutter/material.dart';
import 'package:visitplusapp/appointments-widgets/calendar_utils.dart';
import 'package:visitplusapp/appointments-widgets/date_picker.dart';
import 'package:visitplusapp/doctor-widgets/patient_details_screen.dart';

class CalendarSection extends StatefulWidget {
  final String doctorId; // Add doctorId to constructor

  const CalendarSection({Key? key, required this.doctorId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CalendarSectionState createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  late DateTime currentWeekStart;
  DateTime? selectedDate;
  String? selectedVisitHour;

  @override
  void initState() {
    super.initState();
    currentWeekStart = CalendarUtils.startOfWeek(DateTime.now());
    selectedDate = null;
    selectedVisitHour = null;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                        CalendarUtils.getMonthName(currentWeekStart.month),
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
                  onTap: () => _selectDate(currentDate),
                  child: _buildDateContainer(currentDate, screenWidth),
                );
              }),
            ),
            const SizedBox(height: 20),
            const Text(
              'Visit Hour',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 2.0,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                List<String> hours = [
                  '11:00AM',
                  '12:00PM',
                  '01:00PM',
                  '02:00PM',
                  '03:00PM',
                  '04:00PM',
                  '05:00PM',
                  '06:00PM'
                ];
                return _buildHourContainer(hours[index], screenWidth);
              },
            ),
            const SizedBox(height: 40),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF73C2EF),
                minimumSize: Size(screenWidth * 0.9, 58),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                if (selectedDate == null || selectedVisitHour == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a date and time.'),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientDetailsScreen(
                      selectedDate: selectedDate!,
                      selectedTime: selectedVisitHour!,
                      doctorId: widget.doctorId,
                    ),
                  ),
                );
              },
              child: const Text(
                "Book Appointment",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateContainer(DateTime date, double screenWidth) {
    final isSelected = selectedDate != null && selectedDate!.day == date.day;
    return Container(
      width: screenWidth * 0.15,
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

  Widget _buildHourContainer(String hour, double screenWidth) {
    final isSelected = selectedVisitHour == hour;
    return GestureDetector(
      onTap: () => _selectVisitHour(hour),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF73C2EF) : Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        child: Center(
          child: Text(
            hour,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 12,
            ),
          ),
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
        selectedDate = null;
      });
    }
  }

  void _selectDate(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  void _selectVisitHour(String hour) {
    setState(() {
      selectedVisitHour = hour;
    });
  }
}
