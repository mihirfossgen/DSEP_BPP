import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'utils/colors_widget.dart';

typedef void StringCallback(String selectedType, String selectedStatus,
    String selectedStartDate, String selectedEndDate);

class AdvanceSearchPage extends StatefulWidget {
  final StringCallback onAdvanceSearchTypeSelect;

  AdvanceSearchPage({Key? key, required this.onAdvanceSearchTypeSelect});

  @override
  _AdvanceSearchPageState createState() => _AdvanceSearchPageState();
}

class _AdvanceSearchPageState extends State<AdvanceSearchPage> {
  String schemeType = "Select any option";
  String status = "Select any option";
  bool progress = false;
  String startDate = "Start Date";
  String endDate = "End Date";
  DateTime startSelectedDate = DateTime.now();
  DateTime endSelectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenFontMedium = screenHeight * 0.017;
    final screenFontSmall = screenHeight * 0.014;
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
        ),
        onPressed: () {
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0))),
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter mystate) {
                  return Container(
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, right: 18.0, top: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Advance Search :",
                                style: TextStyle(
                                    fontSize: screenFontMedium,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              ElevatedButton(
                                child: Text("Apply"),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          primaryColor),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  widget.onAdvanceSearchTypeSelect(
                                      schemeType, status, startDate, endDate);
                                },
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    filled: true,
                                    //fillColor: Hexcolor('#ecedec'),
                                    labelText: 'Scheme Type',
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: primaryColor, width: 2.0),
                                    ),
                                  ),
                                  items: const [
                                    DropdownMenuItem<String>(
                                      value: "Select any option",
                                      child: Center(
                                        child: Text("Select any option"),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: "Scholarship",
                                      child: Center(
                                        child: Text("Scholarship"),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: "Grant",
                                      child: Center(
                                        child: Text("Grant"),
                                      ),
                                    )
                                  ],
                                  onChanged: (_value) {
                                    typeFunction(_value.toString(), mystate);
                                  },
                                  hint: Text(
                                    "$schemeType",
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    filled: true,
                                    //fillColor: Hexcolor('#ecedec'),
                                    labelText: 'Staus',
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: primaryColor, width: 2.0),
                                    ),
                                  ),
                                  items: const [
                                    DropdownMenuItem<String>(
                                      value: "Select any option",
                                      child: Center(
                                        child: Text("Select any option"),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: "Publish",
                                      child: Center(
                                        child: Text("Publish"),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: "UnPublish",
                                      child: Center(
                                        child: Text("UnPublish"),
                                      ),
                                    )
                                  ],
                                  onChanged: (_value) {
                                    statusFunction(_value.toString(), mystate);
                                  },
                                  hint: Text(
                                    "$status",
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 53,
                                      width: screenWidth * 0.4,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: TextField(
                                          readOnly: true,

                                          //  onChanged: (value) {trxnProvider.changecontractDate(value);
                                          //,loggedInUid);},
                                          decoration: InputDecoration(
                                            hintText: startDate,
                                            hintStyle: const TextStyle(
                                              color: Colors.black,
                                            ),
                                            border: const OutlineInputBorder(),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: primaryColor,
                                                  width: 2.0),
                                            ),
                                            suffixIcon: IconButton(
                                              icon: const Icon(
                                                Icons.calendar_today,
                                              ),
                                              onPressed: () {
                                                if (Platform.isAndroid) {
                                                  showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: (DateTime.now())
                                                        .add(Duration(days: 7)),
                                                  ).then((value) {
                                                    setState(() {
                                                      startSelectedDate =
                                                          value!;
                                                      startDate =
                                                          startSelectedDate
                                                              .toString()
                                                              .split(' ')[0];
                                                      print(startSelectedDate);
                                                    });
                                                    mystate(() {
                                                      startSelectedDate =
                                                          value!;
                                                      startDate =
                                                          startSelectedDate
                                                              .toString()
                                                              .split(' ')[0];
                                                      print(startSelectedDate);
                                                    });
                                                  });
                                                } else {
                                                  _showCupertinoDatePicker(
                                                      context, "startDate");
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 53,
                                      width: screenWidth * 0.4,
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: TextField(
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            hintText: endDate,
                                            hintStyle: const TextStyle(
                                              color: Colors.black,
                                            ),
                                            border: const OutlineInputBorder(),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: primaryColor,
                                                  width: 2.0),
                                            ),
                                            suffixIcon: IconButton(
                                              icon: const Icon(
                                                Icons.calendar_today,
                                              ),
                                              onPressed: () {
                                                if (Platform.isAndroid) {
                                                  showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: (DateTime.now())
                                                        .add(Duration(days: 7)),
                                                  ).then((value) {
                                                    setState(() {
                                                      endSelectedDate = value!;
                                                      endDate = endSelectedDate
                                                          .toString()
                                                          .split(' ')[0];
                                                    });
                                                    mystate(() {
                                                      endSelectedDate = value!;
                                                      endDate = endSelectedDate
                                                          .toString()
                                                          .split(' ')[0];
                                                    });
                                                  });
                                                } else {
                                                  _showCupertinoDatePicker(
                                                      context, "endDate");
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
              });
        },
        child: Text('Advance Search',
            style: TextStyle(
              color: Colors.white,
              fontSize: screenFontSmall,
            )));
  }

  void typeFunction(String value, StateSetter mystate) {
    if (value.contains("Select any option")) {
      setState(() {
        schemeType = value.toString();
      });
      mystate(() {
        schemeType = value.toString();
      });
    } else {
      setState(() {
        schemeType = value.toString();
      });
      mystate(() {
        schemeType = value.toString();
      });
    }
  }

  void statusFunction(String value, StateSetter mystate) {
    if (value.contains("Select any option")) {
      setState(() {
        status = value.toString();
      });
      mystate(() {
        status = value.toString();
      });
    } else {
      setState(() {
        status = value.toString();
      });
      mystate(() {
        status = value.toString();
      });
    }
  }

  void _showCupertinoDatePicker(BuildContext context, String dateType) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        setState(() {
                          if (dateType == "startDate") {
                            startSelectedDate = DateTime.now();
                            startDate =
                                startSelectedDate.toString().split(' ')[0];
                          } else {
                            endSelectedDate = DateTime.now();
                            endDate = endSelectedDate.toString().split(' ')[0];
                          }
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: const Text('Done'),
                      onPressed: () {
                        if (dateType == "startDate") {
                          if (startDate == "" || startDate == "Select a Date") {
                            setState(() {
                              startSelectedDate = DateTime.now();
                              startDate =
                                  startSelectedDate.toString().split(' ')[0];
                            });
                          }
                          Navigator.of(context).pop();
                        } else {
                          if (endDate == "" || endDate == "Select a Date") {
                            setState(() {
                              endSelectedDate = DateTime.now();
                              endDate =
                                  endSelectedDate.toString().split(' ')[0];
                            });
                          }
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (DateTime newDate) {
                      setState(() {
                        if (dateType == "startDate") {
                          startSelectedDate = newDate;
                          startDate =
                              startSelectedDate.toString().split(' ')[0];
                          print(startSelectedDate);
                        } else {
                          endSelectedDate = newDate;
                          endDate = endSelectedDate.toString().split(' ')[0];
                          print(endSelectedDate);
                        }
                      });
                    },
                    minimumYear: 2015,
                    maximumYear: 2050,
                    mode: CupertinoDatePickerMode.dateAndTime,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
