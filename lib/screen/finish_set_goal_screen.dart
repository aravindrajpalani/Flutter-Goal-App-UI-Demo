import 'package:flutter/material.dart';
import 'package:goal_app/screen/repitition_screen.dart';

class FinishSetGoalScreen extends StatefulWidget {
  final String goalName;
  FinishSetGoalScreen({Key key, @required this.goalName}) : super(key: key) {
    print("Finish Goal Screen $goalName");
  }
  @override
  _FinishSetGoalScreenState createState() => new _FinishSetGoalScreenState();
}

class _FinishSetGoalScreenState extends State<FinishSetGoalScreen> {
  bool _nextButtonEnabled;
  Color _nextButtonColor;
  bool _addToCalendar = false;
  void _onAddCalendarChanged(bool addToCalendar) {
    setState(() {
      _addToCalendar = addToCalendar;
    });
  }

  @override
  void initState() {
    super.initState();
    _nextButtonEnabled = false;
    _nextButtonColor = Color(0xffa3a3a3);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
              size: 30,
            ),
            tooltip: '',
            onPressed: () {
              setState(() {});
              showDiscardAlertDialog();
            },
          ),
          Center(
            child: Row(
              children: <Widget>[
                Text("Set Goal",
                    style: const TextStyle(
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins",
                        fontStyle: FontStyle.normal,
                        fontSize: 20.0)),
                Padding(
                  child: Image.asset(
                    'images/goalfire.png',
                    height: 20,
                    width: 20,
                  ),
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                )
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: _nextButtonColor,
              size: 30,
            ),
            disabledColor: Colors.green,
            color: _nextButtonColor,
            tooltip: '',
            onPressed: !_nextButtonEnabled ? null : onNextButtonPressed(),
          ),
        ]),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            child: Container(
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: new Border.all(
                    color: Color(0xffa7a6a6),
                    width: 1.0,
                  ),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(3.0),
                  )),
              child: Padding(
                child: Text(widget.goalName,
                    style: const TextStyle(
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0)),
                padding: EdgeInsets.fromLTRB(14, 12, 14, 12),
              ),
            ),
            padding: EdgeInsets.fromLTRB(18, 34, 18, 26),
          ),
          Padding(
            child: Container(
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: new Border.all(
                    color: Color(0xffa7a6a6),
                    width: 1.0,
                  ),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(3.0),
                  )),
              child: new TextField(
                onChanged: (text) {
                  print("First text field: $text");
                  setState(() {
                    if (text.length > 0) {
                      _nextButtonEnabled = true;
                      _nextButtonColor = Color(0xff000000);
                    } else {
                      _nextButtonEnabled = false;
                      _nextButtonColor = Color(0xffa3a3a3);
                    }
                  });
                },
                textAlign: TextAlign.left,
                decoration: new InputDecoration(
                    hintText: 'Enter Note',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(14, 12, 14, 12)),
              ),
            ),
            padding: EdgeInsets.fromLTRB(18, 0, 18, 26),
          ),
          Padding(
            child: Container(
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: new Border.all(
                    color: Color(0xffa7a6a6),
                    width: 1.0,
                  ),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(3.0),
                  )),
              child: GestureDetector(
                  child: Padding(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("Repetition",
                            style: const TextStyle(
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                                fontStyle: FontStyle.normal,
                                fontSize: 14.0)),
                        new Text("22 Dec 2019",
                            style: const TextStyle(
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0))
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(14, 12, 14, 12),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RepititionScreen(),
                      ),
                    );
                  }),
            ),
            padding: EdgeInsets.fromLTRB(18, 0, 18, 26),
          ),
          Padding(
            child: Container(
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: new Border.all(
                    color: Color(0xffa7a6a6),
                    width: 1.0,
                  ),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(3.0),
                  )),
              child: Padding(
                child: new Text("Time",
                    style: const TextStyle(
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0)),
                padding: EdgeInsets.fromLTRB(14, 12, 14, 12),
              ),
            ),
            padding: EdgeInsets.fromLTRB(18, 0, 18, 26),
          ),
          Padding(
            child: Container(
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: new Border.all(
                    color: Color(0xffa7a6a6),
                    width: 1.0,
                  ),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(3.0),
                  )),
              child: Padding(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Add to Calendar",
                        style: const TextStyle(
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0)),
                    Switch(
                      activeColor: Color(0xff77CA92),
                      value: _addToCalendar,
                      onChanged: (bool value) {
                        _onAddCalendarChanged(value);
                      },
                    )
                  ],
                ),
                padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
              ),
            ),
            padding: EdgeInsets.fromLTRB(18, 0, 18, 26),
          )
        ],
      ),
    );
  }
 void showDiscardAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Discard Set Goal?"),
          content: new Text("Are you sure you want to discard Goal setting?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                print('popped');
                Navigator.of(context).pushReplacementNamed('/HomeScreen');
              },
            ),
          ],
        );
      },
    );
  }

  onNextButtonPressed() {
    print('Next button pressed');
  }
}
