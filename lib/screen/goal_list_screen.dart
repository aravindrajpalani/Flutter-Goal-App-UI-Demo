import 'package:flutter/material.dart';
import 'package:goal_app/model/dateItem.dart';
import 'package:goal_app/model/goal_item.dart';
import 'package:intl/intl.dart';

class GoalListScreen extends StatefulWidget {
  var goalsList = [
    GoalItem("Learn Violin", false),
    GoalItem("Math Assignment", false),
    GoalItem("Swim", false),
    GoalItem("Read", true),
    GoalItem("Drink Water", true),
  ];
  @override
  _GoalListScreenState createState() => new _GoalListScreenState();
}

class _GoalListScreenState extends State<GoalListScreen> {
  List<DateItem> items;
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = new ScrollController();
    items = new List();

    var now = new DateTime.now();
    var fiveDaysBefore = now.subtract(new Duration(days: 20));
    for (int i = 0; i < 41; i++) {
      var date = fiveDaysBefore.add(new Duration(days: i));

      items.add(DateItem(DateFormat.E().format(date).toUpperCase(), date.day,
          date.compareTo(now) == 0 ? true : false));
    }

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => {_scrollController.jumpTo((56 * 21).toDouble())});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(10),
                  width: 56,
                  height: 56,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    border: new Border.all(
                      color: items[index].isCurrentDate
                          ? Colors.green
                          : Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: new Text(items[index].day,
                            style: TextStyle(
                                color: items[index].isCurrentDate
                                    ? Colors.green
                                    : Color(0xff013ca6),
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: new Text(items[index].date.toString(),
                            style: TextStyle(
                                color: items[index].isCurrentDate
                                    ? Colors.green
                                    : Color(0xff013ca6),
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0)),
                      )
                    ],
                  ),
                );
              },
              itemCount: items.length,
            ),
          ),
          Padding(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("Today",
                    style: const TextStyle(
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                        fontStyle: FontStyle.normal,
                        fontSize: 20.0)),
                Stack(
                  children: <Widget>[
                    Container(
                      //width: 100.0,
                      height: 14.0,
                      decoration: new BoxDecoration(
                        color: Color(0xffe2e2e2),
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child: SizedBox(
                        height: 20,
                        width: 100,
                      ),
                    ),
                    Container(
                      //width: 100.0,
                      height: 14.0,
                      decoration: new BoxDecoration(
                        color: Color(0xffffc300),
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child: SizedBox(
                        height: 20,
                        width: 40,
                      ),
                    ),
                  ],
                )
              ],
            ),
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          ),
          Expanded(
            child: Container(
              child: Padding(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GoalItemList(widget.goalsList[index]);
                  },
                  itemCount: widget.goalsList.length,
                ),
                padding: EdgeInsets.fromLTRB(0, 28, 0, 10),
              ),
              color: Color(0xfff8f8f8),
            ),
          )
        ],
      ),
    );
  }
}

class GoalItemList extends StatefulWidget {
  final GoalItem goalItem;

  GoalItemList(GoalItem goalItem)
      : goalItem = goalItem,
        super(key: new ObjectKey(goalItem));

  @override
  GoalItemState createState() {
    return new GoalItemState(goalItem);
  }
}

class GoalItemState extends State<GoalItemList> {
  final GoalItem dayItem;

  GoalItemState(this.dayItem);

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Container(
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  dayItem.isCheck = !dayItem.isCheck;
                });
              },
              child: Padding(
                child: Container(
                  height: 26,
                  width: 26,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: dayItem.isCheck
                          ? new Border.all(
                              color: Color(0xff77ca92),
                              width: 1.5,
                              style: BorderStyle.solid)
                          : new Border.all(
                              color: Colors.grey,
                              width: 1.5,
                              style: BorderStyle.solid),
                      shape: BoxShape.circle,
                      color:
                          dayItem.isCheck ? Color(0xff77ca92) : Colors.white),
                  child: Center(
                    child: dayItem.isCheck
                        ? Icon(
                            Icons.check,
                            size: 24.0,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.add_circle,
                            size: 20.0,
                            color: Colors.transparent,
                          ),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(26, 5, 20, 5),
              ),
            ),
            Padding(
              child: new Text(dayItem.goalName,
                  style: const TextStyle(
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                      fontStyle: FontStyle.normal,
                      fontSize: 14.0)),
              padding: EdgeInsets.fromLTRB(0, 16, 5, 16),
            ),
          ],
        ),
        color: Colors.white,
      ),
      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
    );
  }
}
