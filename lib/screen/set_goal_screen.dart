import 'package:flutter/material.dart';
import 'package:goal_app/screen/finish_set_goal_screen.dart';

class SetGoalScreen extends StatefulWidget {
  @override
  _SetGoalScreenState createState() => new _SetGoalScreenState();
}

class _SetGoalScreenState extends State<SetGoalScreen> {
  bool _nextButtonEnabled;
  Color _nextButtonColor;

  final myController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _nextButtonEnabled = false;
    _nextButtonColor = Color(0xffa3a3a3);
  }

  @override
  Widget build(BuildContext context) {
    var goalNamesList = [
      "Exercise",
      "Read",
      "Drink Water",
      "Sleep",
      "Weight",
      "Save money",
      "Eat some fruit",
      "Medication",
      "Go for walk",
      "Pay bill",
      "Watch movie",
      "Clean"
    ];
    var goalImgPathList = [
      'images/exercise.png',
      'images/read.png',
      'images/water.png',
      'images/bed.png',
      'images/weight.png',
      'images/pig.png',
      'images/fruit.png',
      'images/hospital.png',
      'images/walk.png',
      'images/paybill.png',
      'images/popcorn.png',
      'images/clean.png'
    ];

    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
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
            onPressed: () =>
                !_nextButtonEnabled ? onNothing() : onNextButtonPressed(),
          ),
        ]),
      ),
      body: Column(
        children: <Widget>[
          Align(
            child: Padding(
              child: new Text("What do you want to track?",
                  style: const TextStyle(
                      color: const Color(0xff013ca6),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                      fontStyle: FontStyle.normal,
                      fontSize: 14.0)),
              padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
            ),
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
                controller: myController,
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
                    hintText: 'Name of your goal or habbit',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(14, 12, 14, 12)),
              ),
            ),
            padding: EdgeInsets.fromLTRB(18, 0, 18, 10),
          ),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            crossAxisSpacing: 1,
            mainAxisSpacing: 16,
            padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
            children: List.generate(12, (index) {
              return GestureDetector(child: Padding(
                padding: EdgeInsets.fromLTRB(1, 1, 1, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      flex: 10,
                      child: Padding(
                        child: Container(
                            child: new CircleAvatar(
                                maxRadius: 28,
                                minRadius: 28,
                                child: Image.asset(
                                  goalImgPathList[index],
                                  height: 32,
                                  width: 32,
                                ),
                                backgroundColor: Colors.white),
                            padding: const EdgeInsets.all(0.5), // borde width
                            decoration: new BoxDecoration(
                              color: const Color(0xffc6c6c6), // border color
                              shape: BoxShape.circle,
                            )),
                        padding: EdgeInsets.all(2),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        child: new Text(goalNamesList[index],
                            style: const TextStyle(
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins",
                                fontStyle: FontStyle.normal,
                                fontSize: 11.2)),
                        padding: EdgeInsets.fromLTRB(0, 2, 0, 30),
                      ),
                    )
                  ],
                ),
              ),onTap: (){
                onGoalPressed(goalNamesList[index]);
              },);
            }),
          )
        ],
      ),
    );
  }

  onNextButtonPressed() {
    print('Next button pressed');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => FinishSetGoalScreen(
              goalName: myController.text,
            ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    myController.dispose();
    super.dispose();
  }

  onNothing() {}
  onGoalPressed(String goalName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FinishSetGoalScreen(
              goalName: goalName,
            ),
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
}
