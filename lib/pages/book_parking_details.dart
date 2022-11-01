import 'package:flutter/material.dart';
// import 'package:date_format/date_format.dart';
// import 'package:parking_project/pages/calendar_page.dart' show CalendarPage;
import 'package:table_calendar/table_calendar.dart';
// import 'package:intl/intl.dart';

class BookParkingDetails extends StatefulWidget {
  const BookParkingDetails({super.key});

  @override
  State<BookParkingDetails> createState() => _BookParkingDetailsState();
}

class _BookParkingDetailsState extends State<BookParkingDetails> {
  String? _selectedTime;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  double _hours = 4;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? result = await showTimePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
                primaryColor: Colors.white,
                splashColor: Colors.black,
                brightness: Brightness.light),
            child: child ?? Text(""),
          );
        },
        initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _selectedTime = result.format(context);
      });
    }
  }
  // void changeEndTime(TimeOfDay )

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Book Parking Details",
            style: TextStyle(color: Colors.black),
          ),
          leading: BackButton(color: Colors.black),
        ),
        body: SingleChildScrollView(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child:
                          Text("Select Date", style: TextStyle(fontSize: 17))),
                  SizedBox(height: 10),
                  Container(
                    color: Color(0xffF0F8FF),
                    margin: EdgeInsets.only(left: 10, right: 15),
                    child: TableCalendar(
                      firstDay: DateTime(1900),
                      lastDay: DateTime(2050),
                      focusedDay: _focusedDay,
                      calendarFormat: _calendarFormat,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        if (!isSameDay(_selectedDay, selectedDay)) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        }
                      },
                      onFormatChanged: (format) {
                        if (_calendarFormat != format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        }
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text("Duration", style: TextStyle(fontSize: 17))),
                  SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          valueIndicatorColor: Color(0xff2756FF),
                          thumbColor: Colors.white),
                      child: Slider(
                        value: _hours,
                        max: 24,
                        divisions: 24,
                        label: "${_hours.round().toString()} hrs",
                        activeColor: Color(0xff2756FF),
                        inactiveColor: Color(0xffcccccc),
                        onChanged: (double newvalue) {
                          setState(() {
                            _hours = newvalue;
                          });
                        },
                      )),
                  Row(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text("Start Hour",
                              style: TextStyle(fontSize: 17))),
                      SizedBox(width: 125),
                      Align(
                          // alignment: Alignment.topRight,
                          child:
                              Text("End Hour", style: TextStyle(fontSize: 17))),
                      SizedBox(width: 15)
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.0),
                            color: Color(0xffF5F5F5)),
                        child: InkWell(
                            onTap: () => _selectTime(context),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        _selectedTime != null
                                            ? _selectedTime!
                                            : '${TimeOfDay.now().format(context)}',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )),
                                Expanded(
                                    child: Icon(
                                  Icons.access_time,
                                  color: Colors.black,
                                  size: 20,
                                ))
                              ],
                            )),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_right, size: 50),
                      SizedBox(width: 10),
                      Container(
                        height: 50,
                        width: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.0),
                            color: Color(0xffF5F5F5)),
                        child: InkWell(
                            onTap: () => _selectTime(context),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        _selectedTime != null
                                            ? _selectedTime!
                                            : '${TimeOfDay.fromDateTime(DateTime.now().add(Duration(hours: _hours.toInt()))).format(context)}',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )),
                                Expanded(
                                    child: Icon(
                                  Icons.access_time,
                                  color: Colors.black,
                                  size: 20,
                                ))
                              ],
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text("Total", style: TextStyle(fontSize: 17))),
                  SizedBox(height: 10),
                  Row(children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text('\u{20B9}${90.0}',
                            style: TextStyle(
                                fontSize: 25, color: Color(0xff2756FF)))),
                    Text("/ ${_hours.toInt()} hours",
                        style: TextStyle(color: Colors.grey, fontSize: 13))
                  ]),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Continue"),
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(
                              MediaQuery.of(context).size.width * 0.90, 50)),
                          maximumSize: MaterialStateProperty.all(Size(
                              MediaQuery.of(context).size.width * 0.90, 50)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff2756FF)),
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  side: BorderSide(color: Color(0xff2756FF))))),
                    ),
                  )
                ],
              )),
        
        );
  }
}






// TextButton.icon(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.timer,
//                       ),
//                       label: Text(
//                         "8 AM - 10 PM",
//                         style: GoogleFonts.poppins(
//                             fontSize: 14, fontWeight: FontWeight.w500),
//                       ),
//                       style: ButtonStyle(
//                           overlayColor:
//                               MaterialStateProperty.all(Colors.transparent),
//                           minimumSize: MaterialStateProperty.all(Size(0, 50)),
//                           maximumSize: MaterialStateProperty.all(Size(
//                               MediaQuery.of(context).size.width * 0.90, 50)),
//                           foregroundColor:
//                               MaterialStateProperty.all(Color(0xff2756FF)),
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                                   RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(50.0),
//                                       side:
//                                           BorderSide(color: primaryColour)))))
