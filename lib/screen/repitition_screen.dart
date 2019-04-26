import 'package:flutter/material.dart';
import 'package:goal_app/calendarlib/classes/event.dart';
import 'package:goal_app/calendarlib/flutter_calendar_carousel.dart';
import 'package:goal_app/model/day_item.dart';
import 'package:intl/intl.dart';

class RepititionScreen extends StatefulWidget {
  @override
  _RepititionScreenState createState() => new _RepititionScreenState();
}

class _RepititionScreenState extends State<RepititionScreen>
    with SingleTickerProviderStateMixin {
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = '';
  int _currentRepeatWidgetIndex = 0;

  CalendarCarousel _calendarCarouselNoHeader;

  bool _nextButtonEnabled;
  Color _tabZeroColor;
  Color _tabOneColor;
  TabController _tabController;

  final myController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _currentRepeatWidgetIndex = 0;
    _nextButtonEnabled = false;
    _tabZeroColor = Color(0xff013ca6);
    _tabOneColor = Colors.grey;
    _tabController = new TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        print('Tab changed to ${_tabController.index}');
        setState(() {
          if (_tabController.index == 0) {
            _tabZeroColor = Color(0xff013ca6);
            _tabOneColor = Colors.grey;
          } else {
            _tabOneColor = Color(0xff013ca6);
            _tabZeroColor = Colors.grey;
          }
        });
      }
    });
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
              Icons.arrow_back,
              color: Colors.black,
              size: 24,
            ),
            color: Colors.black,
            tooltip: '',
            onPressed: !_nextButtonEnabled ? null : onNextButtonPressed(),
          ),
          Center(
            child: Text("Repitition",
                style: const TextStyle(
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins",
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0)),
          ),
          new Text("Done",
              style: const TextStyle(
                  color: const Color(0xff77ca92),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0)),
        ]),
      ),
      body: Scaffold(
        appBar: TabBar(
          indicatorColor: Color(0xff013ca6),
          indicatorWeight: 1,
          controller: _tabController,
          tabs: [
            Tab(
                child: new Text("One - Time",
                    style: TextStyle(
                        color: _tabZeroColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0))),
            Tab(
                child: new Text("Repeat",
                    style: TextStyle(
                        color: _tabOneColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0))),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: [getOneTimeWidget(), getRepeatWidget()],
        ),
      ),
    );
  }

  onNextButtonPressed() {
    print('Next button pressed');
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => FinishRepititionScreen(
    //           goalName: myController.text,
    //         ),
    //   ),
    // );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    myController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  onNothing() {}

  Widget getOneTimeWidget() {
    /// Example Calendar Carousel without header and custom prev & next button
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Color(0xff77ca92),
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
      },
      inactiveWeekendTextStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins",
          fontStyle: FontStyle.normal,
          fontSize: 16.0),
      inactiveDaysTextStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins",
          fontStyle: FontStyle.normal,
          fontSize: 16.0),
      weekendTextStyle: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins",
          fontStyle: FontStyle.normal,
          fontSize: 16.0),
      weekdayTextStyle: TextStyle(
        color: Color(0xff9b9b9b),
      ),
      daysTextStyle: TextStyle(
          color: const Color(0xff000000),
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins",
          fontStyle: FontStyle.normal,
          fontSize: 16.0),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      height: 420.0,

      selectedDateTime: _currentDate2,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 2,
      selectedDayButtonColor: Color(0xff77ca92),
      markedDateMoreShowTotal:
          false, // null for not showing hidden events indicator
      showHeader: false,
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      todayTextStyle: TextStyle(
          color: const Color(0xff000000),
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins",
          fontStyle: FontStyle.normal,
          fontSize: 16.0),
      todayButtonColor: Colors.transparent,
      selectedDayTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins",
          fontStyle: FontStyle.normal,
          fontSize: 16.0),
      minSelectedDate: _currentDate,

      markedDateIconBorderColor: Colors.black,

      onCalendarChanged: (DateTime date) {
        this.setState(() => _currentMonth = DateFormat.yMMM().format(date));
      },
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //custom icon
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 16.0),
          //   child: _calendarCarousel,
          // ), // This trailing comma makes auto-formatting nicer for build methods.

          //custom icon without header
          Container(
            margin: EdgeInsets.only(
              top: 30.0,
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xff4a4a4a),
                        size: 18,
                      ),
                      color: Color(0xff4a4a4a),
                      tooltip: '',
                      onPressed: () => onPrevButtonPressed(),
                    ),
                    Text(_currentMonth,
                        style: const TextStyle(
                            color: const Color(0xff4a4a4a),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                            fontStyle: FontStyle.normal,
                            fontSize: 18.0)),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xff4a4a4a),
                        size: 18,
                      ),
                      color: Color(0xff4a4a4a),
                      tooltip: '',
                      onPressed: () => onNextButtonPressed(),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Sat",
                        style: const TextStyle(
                            color: const Color(0xff013ca6),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0)),
                    Padding(
                        child: Container(
                          width: 5.0,
                          height: 5.0,
                          decoration: new BoxDecoration(
                            color: Color(0xff013ca6),
                            shape: BoxShape.circle,
                          ),
                        ),
                        padding: EdgeInsets.all(5)),
                    Text("12 Dec 2019",
                        style: const TextStyle(
                            color: const Color(0xff013ca6),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0))
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: _calendarCarouselNoHeader,
          ), //
        ],
      ),
    );
  }

  Widget getRepeatWidget() {
    var daysList = [
      DayItem("Sun", false),
      DayItem("Mon", false),
      DayItem("Tue", false),
      DayItem("Wed", false),
      DayItem("Thu", false),
      DayItem("Fri", false),
      DayItem("Sat", false)
    ];
    var _repeatWidgetArray = [
      ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (context, position) {
          return Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(18.0),
                child: new Text("${position + 1} time per day",
                    style: const TextStyle(
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0)),
              ),
              Padding(
                child: Divider(
                  color: Colors.grey[300],
                  height: 0.3,
                ),
                padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
              )
            ],
          );
        },
      ),
      ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (context, position) {
          return Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(18.0),
                child: new Text("${position + 1} time per week",
                    style: const TextStyle(
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0)),
              ),
              Padding(
                child: Divider(
                  color: Colors.grey[300],
                  height: 0.3,
                ),
                padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
              )
            ],
          );
        },
      ),
      ListView.builder(
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, position) {
          return Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(18.0),
                child: new Text("${position + 1} time per day",
                    style: const TextStyle(
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0)),
              ),
              Padding(
                child: Divider(
                  color: Colors.grey[300],
                  height: 0.3,
                ),
                padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
              )
            ],
          );
        },
      ),
      Column(
        children: <Widget>[
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 7,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, position) {
                return new DayItemList(daysList[position]);
              },
            ),
            height: 90,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, position) {
              return Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    child: new Text("Every ${position + 1} week",
                        style: const TextStyle(
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0)),
                  ),
                  Padding(
                    child: Divider(
                      color: Colors.grey[300],
                      height: 0.3,
                    ),
                    padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
                  )
                ],
              );
            },
          ),
        ],
      )
    ];
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  child: Padding(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: new Border.all(
                            color: _currentRepeatWidgetIndex == 0
                                ? Color(0xff013ca6)
                                : Colors.grey,
                            width: 0.7,
                          ),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(5.0),
                          )),
                      child: Padding(
                        child: new Text("Daily",
                            style: TextStyle(
                                color: _currentRepeatWidgetIndex == 0
                                    ? Color(0xff013ca6)
                                    : Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0)),
                        padding: EdgeInsets.fromLTRB(14, 12, 14, 12),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(0, 0, 16, 20),
                  ),
                  onTap: () {
                    setState(() {
                      _currentRepeatWidgetIndex = 0;
                    });
                  },
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: Padding(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: new Border.all(
                            color: _currentRepeatWidgetIndex == 1
                                ? Color(0xff013ca6)
                                : Colors.grey,
                            width: 0.7,
                          ),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(5.0),
                          )),
                      child: Padding(
                        child: new Text("Weekly",
                            style: TextStyle(
                                color: _currentRepeatWidgetIndex == 1
                                    ? Color(0xff013ca6)
                                    : Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0)),
                        padding: EdgeInsets.fromLTRB(14, 12, 14, 12),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  ),
                  onTap: () {
                    setState(() {
                      _currentRepeatWidgetIndex = 1;
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  child: Padding(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: new Border.all(
                            color: _currentRepeatWidgetIndex == 2
                                ? Color(0xff013ca6)
                                : Colors.grey,
                            width: 0.7,
                          ),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(5.0),
                          )),
                      child: Padding(
                        child: new Text("Monthly",
                            style: TextStyle(
                                color: _currentRepeatWidgetIndex == 2
                                    ? Color(0xff013ca6)
                                    : Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0)),
                        padding: EdgeInsets.fromLTRB(14, 12, 14, 12),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(0, 0, 16, 16),
                  ),
                  onTap: () {
                    setState(() {
                      _currentRepeatWidgetIndex = 2;
                    });
                  },
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: Padding(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: new Border.all(
                            color: _currentRepeatWidgetIndex == 3
                                ? Color(0xff013ca6)
                                : Colors.grey,
                            width: 0.7,
                          ),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(5.0),
                          )),
                      child: Padding(
                        child: new Text("Specific Day",
                            style: TextStyle(
                                color: _currentRepeatWidgetIndex == 3
                                    ? Color(0xff013ca6)
                                    : Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0)),
                        padding: EdgeInsets.fromLTRB(14, 12, 14, 12),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                  ),
                  onTap: () {
                    setState(() {
                      _currentRepeatWidgetIndex = 3;
                    });
                  },
                ),
              )
            ],
          ),
          _repeatWidgetArray[_currentRepeatWidgetIndex],
        ],
      ),
    );
  }

  onPrevButtonPressed() {}

  onNextBtnPressed() {}
}

class DayItemList extends StatefulWidget {
  final DayItem dayItem;

  DayItemList(DayItem dayItem)
      : dayItem = dayItem,
        super(key: new ObjectKey(dayItem));

  @override
  DayItemState createState() {
    return new DayItemState(dayItem);
  }
}

class DayItemState extends State<DayItemList> {
  final DayItem dayItem;

  DayItemState(this.dayItem);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Padding(
          child: new Text(dayItem.dayName,
              style: const TextStyle(
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0)),
          padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              dayItem.isCheck = !dayItem.isCheck;
            });
          },
          child: Padding(
            child: Container(
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
                  color: dayItem.isCheck ? Color(0xff77ca92) : Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: dayItem.isCheck
                    ? Icon(
                        Icons.check,
                        size: 20.0,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.add_circle,
                        size: 20.0,
                        color: Colors.transparent,
                      ),
              ),
            ),
            padding: EdgeInsets.fromLTRB(6, 5, 6, 5),
          ),
        )
      ],
    );
  }
}
