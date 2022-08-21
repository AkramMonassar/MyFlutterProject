import 'age_calculator.dart';
import 'duration_model.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'age_model.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //BuildContext? context;

  MyAge _userAge = MyAge();

  MyDuration _nextBirthDay = MyDuration();

  final TextEditingController _dateOfBirthController =
      TextEditingController(text: "01-01-1990");

  final TextEditingController _todayDateController =
      TextEditingController(text: "01-01-2022");

  DateTime? dateOfBirth;

  DateTime? dateOfFuture;

  @override
  Widget build(BuildContext context) {
    //this.context = context;

    Widget dateOfBirthHeading = _buildHeading("Date of Birth");
    Widget birthDateTextField = _buildBirthDateTextField();
    Widget todayDateHeading = _buildHeading("Today Date");
    Widget todayDateTextField = _buildTodayDateTextField();

    Widget clearCalculateButtonsRow = _buildClearCalcButtonsRow();
    Widget ageOutputHeading = _buildHeading("Age is");
    Widget ageOutputRow = _buildAgeOutputRow();
    Widget nextBirthDayHeading = _buildHeading("Next Birth Day in");
    Widget nextBirthOutputRow = _buildNextBirthDayOutputRow();
    Widget emptyBox = const SizedBox(height: 20);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            dateOfBirthHeading,
            birthDateTextField,
            emptyBox,
            todayDateHeading,
            todayDateTextField,
            emptyBox,
            clearCalculateButtonsRow,
            emptyBox,
            ageOutputHeading,
            ageOutputRow,
            emptyBox,
            nextBirthDayHeading,
            nextBirthOutputRow,
          ],
        ),
      ),
    );
  }

  Widget _buildOutputField(String outputTitle, String outputData) {
    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).primaryColor,
          width: 100,
          height: 30,
          child: Center(
              child: Text(
            outputTitle,
            style: const TextStyle(color: Colors.white),
          )),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor)),
          width: 100,
          height: 30,
          child: Center(
              child: Text(
            outputData,
            style: const TextStyle(color: Colors.grey),
          )),
        )
      ],
    );
  }

  Widget _buildHeading(String headingTitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        headingTitle,
        style: const TextStyle(fontSize: 20, color: Colors.grey),
      ),
    );
  }

  InputDecoration _getTextFieldWithCalendarIconDecoration() {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
      ),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      suffixIcon: Icon(
        Icons.date_range,
        color: Theme.of(context).primaryColor,
      ),
      hintText: 'Example : 01-01-2022',
    );
  }

  Widget _buildBirthDateTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          showCursor: true,
          readOnly: true,
          onTap: () {
            showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1940),
                    lastDate: DateTime.now())
                .then((date) {
              //code to handle date
              dateOfBirth = date;
              // update Edit text

              if (date == null) {
                setState(() {
                  // _dateOfBirthController=TextEditingController(text: "${dateOfBirth!}");
                  _dateOfBirthController.text = "";
                });
              } else {
                setState(() {
                  // _dateOfBirthController=TextEditingController(text: "${dateOfBirth!}");
                  final DateFormat formatter = DateFormat('dd-MM-yyyy');
                  final String formatted = formatter.format(date);
                  _dateOfBirthController.text = formatted;
                });
              }

              print('Date in today:$dateOfBirth');
            });
          },
          controller: _dateOfBirthController,
          decoration: _getTextFieldWithCalendarIconDecoration(),
        )
      ],
    );
  }

  Widget _buildTodayDateTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          showCursor: true,
          readOnly: true,
          onTap: () {
            showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1940),
                    lastDate: DateTime.now())
                .then((date) {
              dateOfFuture = date;
              print('Date Future :${dateOfFuture}');
              // update show Date Picker
              if (date == null) {
                setState(() {
                  // _todayDateController=TextEditingController(text: "${dateOfFuture!}");
                  _todayDateController.text = "";
                });
              } else {
                setState(() {
                  // _todayDateController=TextEditingController(text: "${dateOfFuture!}");
                  final DateFormat formatter = DateFormat('dd-MM-yyyy');
                  final String formatted = formatter.format(date);
                  _todayDateController.text = formatted;
                });
              }

              print(date.runtimeType);
            });
          },
          controller: _todayDateController,
          decoration: _getTextFieldWithCalendarIconDecoration(),
        )
      ],
    );
  }

  Widget _buildClearButton(String text) {
    return ButtonTheme(
      minWidth: 150,
      height: 60,
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        onPressed: () {
          setState(() {
            _dateOfBirthController.text = "";
            _todayDateController.text = "";
            _userAge.years = 0;
            _userAge.months = 0;
            _userAge.days = 0;
            _nextBirthDay.months = 0;
            _nextBirthDay.days = 0;
          });
        },
        child: Text(text, style: const TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }

  Widget _buildCalculatorButton(String text) {
    return ButtonTheme(
      minWidth: 150,
      height: 60,
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        onPressed: () {
          setState(() {
            _userAge =
                MyAgeCalculator().MycalculateAge(dateOfBirth!, dateOfFuture!);
            _nextBirthDay = MyAgeCalculator()
                .calculateNextBirDayDuration(dateOfBirth!, dateOfFuture!);
          });
          print("User Age :${_userAge}");
          print("Next BirthDay :${_nextBirthDay}");
        },
        child: Text(text, style: const TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }

  Widget _buildClearCalcButtonsRow() {
    Widget clearOrangeButton = _buildClearButton('CLEAR');
    Widget calcOrangeButton = _buildCalculatorButton('CALCULATE');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        clearOrangeButton,
        calcOrangeButton,
      ],
    );
  }

  Widget _buildAgeOutputRow() {
    Widget ageYearsOutputField =
        _buildOutputField("Years", _userAge.years.toString());
    Widget ageMonthsOutputField =
        _buildOutputField("Months", _userAge.months.toString());
    Widget ageDaysOutputField =
        _buildOutputField("Days", _userAge.days.toString());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        ageYearsOutputField,
        ageMonthsOutputField,
        ageDaysOutputField,
      ],
    );
  }

  Widget _buildNextBirthDayOutputRow() {
    Widget nextBirthYearsOutputField = _buildOutputField("Years", "-");
    Widget nextBirthMonthsOutputField =
        _buildOutputField("Months", _nextBirthDay.months.toString());
    Widget nextBirthDaysOutputField =
        _buildOutputField("Days", _nextBirthDay.days.toString());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        nextBirthYearsOutputField,
        nextBirthMonthsOutputField,
        nextBirthDaysOutputField,
      ],
    );
  }
}
