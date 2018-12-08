import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'schedule_expanded.dart';

typedef void RefreshCallback1();

class NewScheduleItem extends StatefulWidget {
  NewScheduleItem({Key key, this.refreshCallback1}) : super(key: key);

  final RefreshCallback1 refreshCallback1;
  @override
  NewScheduleItemState createState() {
    return new NewScheduleItemState(refreshCallback1: refreshCallback1);
  }
}

class NewScheduleItemState extends State<NewScheduleItem> {
  NewScheduleItemState({Key key, this.refreshCallback1});
  final RefreshCallback1 refreshCallback1;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add new Item Schedule"),
      ),
      body: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  MyCustomForm({Key key, this.refreshCallback1});
  final RefreshCallback1 refreshCallback1;
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  TimeOfDay _fromTime = TimeOfDay.now();
  TimeOfDay _toTime = TimeOfDay.now();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Goals Item Name'),
            controller: myController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
            },
          ),
          _DateTimePicker(
            labelText: 'From',
            selectedDate: DateTime.now(),
            selectedTime: _fromTime,
            selectDate: (DateTime date) {},
            selectTime: (TimeOfDay time) {
              setState(() {
                _fromTime = time;
              });
            },
          ),
          _DateTimePicker(
            labelText: 'To',
            selectedDate: DateTime.now(),
            selectedTime: _toTime,
            selectDate: (DateTime date) {},
            selectTime: (TimeOfDay time) {
              setState(() {
                _toTime = time;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, we want to show a Snackbar
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Saving Data in firebase')));
                  DateTime now = new DateTime.now();
                  DateTime _from = new DateTime(now.year, now.month, now.day,
                      _fromTime.hour, _fromTime.minute);
                  DateTime _to = new DateTime(now.year, now.month, now.day,
                      _toTime.hour, _toTime.minute);
                  print("from");
                  print(_from.millisecondsSinceEpoch);
                  Firestore.instance.collection('goals').document().setData(
                      {'title': myController.text, 'from': _from, 'to': _to});
                  widget.refreshCallback1();
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker(
      {Key key,
      this.labelText,
      this.selectedDate,
      this.selectedTime,
      this.selectDate,
      this.selectTime})
      : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) selectDate(picked);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null && picked != selectedTime) selectTime(picked);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.title;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        // Expanded(
        //   flex: 4,
        //   child: _InputDropdown(
        //     labelText: labelText,
        //     valueText: DateFormat.yMMMd().format(selectedDate),
        //     valueStyle: valueStyle,
        //     onPressed: () {
        //       _selectDate(context);
        //     },
        //   ),
        // ),
        const SizedBox(width: 12.0),
        Expanded(
          flex: 3,
          child: _InputDropdown(
            valueText: selectedTime.format(context),
            valueStyle: valueStyle,
            onPressed: () {
              _selectTime(context);
            },
          ),
        ),
      ],
    );
  }
}

class _InputDropdown extends StatelessWidget {
  const _InputDropdown(
      {Key key,
      this.child,
      this.labelText,
      this.valueText,
      this.valueStyle,
      this.onPressed})
      : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(valueText, style: valueStyle),
            Icon(Icons.arrow_drop_down,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
          ],
        ),
      ),
    );
  }
}
