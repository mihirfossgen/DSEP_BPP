import 'dart:convert';

import 'package:dsep_bpp/screens/create_scheme_screen.dart';
import 'package:dsep_bpp/widgets/custom_loader.dart';
import 'package:dsep_bpp/widgets/text_widget.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe

import 'package:showcaseview/showcaseview.dart';
import '../utils/api.dart';
import '../utils/colors_widget.dart';
import '../utils/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_drawer/home_drawer.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dsep_bpp/provides/ApiServices.dart';

class HomePage extends StatefulWidget {
  int? value;
  //var schemeData;
  HomePage({Key? key, this.value}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = -1;
  DrawerIndex? drawerIndex;
  Widget? screenView;
  String selectedSchemeType = "";
  String selectedStatus = "";
  String selectedStartDate = "";
  String selectedEndDate = "";
  bool SchemeTypeSelectedStatus = false;
  bool StatusSelectedStatus = false;
  bool StartDateSelectedStatus = false;
  bool EndDateSelectedStatus = false;
  var color = 0xffe3f2fd;

  bool _isloading = false;
  bool _isExpand = false;

  var schemeData;
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  final GlobalKey _three = GlobalKey();

  startShowCase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("first_login") == null) {
      prefs.setBool("first_login", true);
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Future.delayed(
          const Duration(milliseconds: 400),
          () {
            ShowCaseWidget.of(context).startShowCase([_two, _three]);
          },
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _isloading = true;
    GetAllSchemeList();

    if (Global.isfirstlogin == true) {
    } else {
      startShowCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenFontMedium = screenHeight * 0.017;
    final screenFontSmall = screenHeight * 0.014;

    var i = 0;

    return SafeArea(
      top: false,
      child: Scaffold(
          floatingActionButton: Showcase(
            key: _two,
            title: 'Create Schema',
            description: 'Click here to create schemas',
            shapeBorder: const CircleBorder(),
            overlayPadding: const EdgeInsets.all(10),
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateSchemeScreen(
                          routeFrom: "home",
                        )));
              },
              child: const Icon(
                Icons.add,
              ),
            ),
          ),
          body: _body(screenFontSmall, screenWidth)),
    );

    // return PlatformScaffold(
    //   body: DrawerUserController(
    //     screenIndex: drawerIndex,
    //     drawerWidth: MediaQuery.of(context).size.width * 0.75,
    //     onDrawerCall: (DrawerIndex drawerIndexdata) {
    //       changeIndex(drawerIndexdata);
    //       //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
    //     },
    //     screenView:,
    //   ),
    //   //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
    // );
  }

  Widget _body(double screenFontSmall, double screenWidth) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: Column(
        children: [
          // SizedBox(
          //   height: 50,
          //   child: Showcase(
          //     key: _one,
          //     title: "Search",
          //     description: 'Search schemas',
          //     overlayPadding: const EdgeInsets.all(10),
          //     child: TextFormField(
          //       //controller: searchController,
          //       //onChanged: searchFalse(),
          //       cursorColor: primaryColor,
          //       style: const TextStyle(
          //         color: Colors.black,
          //       ),
          //       keyboardType: TextInputType.text,
          //       decoration: InputDecoration(
          //         alignLabelWithHint: true,
          //         contentPadding: const EdgeInsets.only(top: 15),
          //         counterText: "",
          //         prefixIcon: const Icon(Icons.search, color: Colors.black),
          //         hintText: "Search...",
          //         hintStyle: const TextStyle(color: Colors.grey),
          //         enabledBorder: OutlineInputBorder(
          //             borderSide:
          //                 const BorderSide(color: primaryColor, width: 2),
          //             borderRadius: BorderRadius.circular(10)),
          //         focusedBorder: OutlineInputBorder(
          //             borderSide:
          //                 const BorderSide(color: primaryColor, width: 2),
          //             borderRadius: BorderRadius.circular(10)),
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Expanded(
          //         child: SingleChildScrollView(
          //           scrollDirection: Axis.horizontal,
          //           child: Row(
          //             children: [
          //               SchemeTypeSelectedStatus
          //                   ? TextButton(
          //                       onPressed: () {
          //                         setState(() {
          //                           SchemeTypeSelectedStatus = false;
          //                           selectedSchemeType = "Select any option";
          //                           //  gender = value.toString();
          //                         });
          //                       },
          //                       child: Container(
          //                         decoration: BoxDecoration(
          //                           borderRadius: BorderRadius.circular(5.0),
          //                           color: Theme.of(context).primaryColor,
          //                         ),
          //                         child: Padding(
          //                           padding: const EdgeInsets.all(5.0),
          //                           child: Row(
          //                             children: [
          //                               Text(selectedSchemeType,
          //                                   style: TextStyle(
          //                                     color: Colors.white,
          //                                     fontSize: screenFontSmall,
          //                                   )),
          //                               SizedBox(
          //                                 width: screenWidth * 0.01,
          //                               ),
          //                               const Icon(
          //                                 Icons.close,
          //                                 color: Colors.white,
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                       ))
          //                   : const SizedBox(),
          //               StatusSelectedStatus
          //                   ? TextButton(
          //                       onPressed: () {
          //                         setState(() {
          //                           StatusSelectedStatus = false;
          //                           selectedStatus = "Select any option";
          //                           //  gender = value.toString();
          //                         });
          //                       },
          //                       child: Container(
          //                         decoration: BoxDecoration(
          //                           borderRadius: BorderRadius.circular(5.0),
          //                           color: Theme.of(context).primaryColor,
          //                         ),
          //                         child: Padding(
          //                           padding: const EdgeInsets.all(5.0),
          //                           child: Row(
          //                             children: [
          //                               Text(selectedStatus,
          //                                   style: TextStyle(
          //                                     color: Colors.white,
          //                                     fontSize: screenFontSmall,
          //                                   )),
          //                               SizedBox(
          //                                 width: screenWidth * 0.01,
          //                               ),
          //                               const Icon(
          //                                 Icons.close,
          //                                 color: Colors.white,
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                       ))
          //                   : const SizedBox(),
          //               StartDateSelectedStatus
          //                   ? TextButton(
          //                       onPressed: () {
          //                         setState(() {
          //                           StartDateSelectedStatus = false;
          //                           selectedStartDate = "Select any option";
          //                           //  gender = value.toString();
          //                         });
          //                       },
          //                       child: Container(
          //                         decoration: BoxDecoration(
          //                           borderRadius: BorderRadius.circular(5.0),
          //                           color: Theme.of(context).primaryColor,
          //                         ),
          //                         child: Padding(
          //                           padding: const EdgeInsets.all(5.0),
          //                           child: Row(
          //                             children: [
          //                               Text(selectedStartDate,
          //                                   style: TextStyle(
          //                                     color: Colors.white,
          //                                     fontSize: screenFontSmall,
          //                                   )),
          //                               SizedBox(
          //                                 width: screenWidth * 0.01,
          //                               ),
          //                               const Icon(
          //                                 Icons.close,
          //                                 color: Colors.white,
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                       ))
          //                   : const SizedBox(),
          //               EndDateSelectedStatus
          //                   ? TextButton(
          //                       onPressed: () {
          //                         setState(() {
          //                           EndDateSelectedStatus = false;
          //                           selectedEndDate = "Select any option";
          //                           //  gender = value.toString();
          //                         });
          //                       },
          //                       child: Container(
          //                         decoration: BoxDecoration(
          //                           borderRadius: BorderRadius.circular(5.0),
          //                           color: Theme.of(context).primaryColor,
          //                         ),
          //                         child: Padding(
          //                           padding: const EdgeInsets.all(5.0),
          //                           child: Row(
          //                             children: [
          //                               Text(selectedEndDate,
          //                                   style: TextStyle(
          //                                     color: Colors.white,
          //                                     fontSize: screenFontSmall,
          //                                   )),
          //                               SizedBox(
          //                                 width: screenWidth * 0.01,
          //                               ),
          //                               const Icon(
          //                                 Icons.close,
          //                                 color: Colors.white,
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                       ))
          //                   : const SizedBox(),
          //             ],
          //           ),
          //         ),
          //       ),
          //       AdvanceSearchPage(onAdvanceSearchTypeSelect:
          //           (String selectedSchemeType, String selectedStatus,
          //               String selectedStartDate, String selectedEndDate) {
          //         updateId(selectedSchemeType, selectedStatus,
          //             selectedStartDate, selectedEndDate);
          //       })
          //     ],
          //   ),
          // ),
          Expanded(
              child: Showcase(
            key: _three,
            description: 'List of all created schemas',
            overlayPadding: const EdgeInsets.all(10),
            child: _isloading
                ? Loader()
                : schemeData == null
                    ? Container(
                        alignment: Alignment.center,
                        child: const TextWidget(
                          text: "No schemes created",
                          size: 15,
                          weight: FontWeight.bold,
                        ),
                      )
                    : ReusbaleRow(
                        indexOnject: schemeData,
                        optionTypeSelect:
                            (String selectedOption, int index) async {
                          if (selectedOption == "Publish") {
                            var result =
                                await FlutterPlatformAlert.showCustomAlert(
                              windowTitle: 'Do you want to Publish this?',
                              text: '',
                              positiveButtonTitle: "Yes",
                              negativeButtonTitle: "No",
                              options: FlutterPlatformAlertOption(
                                  additionalWindowTitleOnWindows:
                                      'Window title',
                                  showAsLinksOnWindows: true),
                            );

                            if (result == CustomButton.positiveButton) {
                              var data = {};
                              ApiServices()
                                  .publishScheme(
                                      data, schemeData[index]["schemeID"])
                                  .then((value) {
                                if (value["status"] == true) {
                                  schemeData[index]["published"] = true;
                                  setState(() {});
                                  Fluttertoast.showToast(
                                      msg: "Scheme Published SuccessFully",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Failed To Publish Scheme...Try After Sometime",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              });
                            }
                          } else if (selectedOption == "UnPublish") {
                            var result =
                                await FlutterPlatformAlert.showCustomAlert(
                              windowTitle: 'Do you want to UnPublish this?',
                              text: '',
                              positiveButtonTitle: "Yes",
                              negativeButtonTitle: "No",
                              options: FlutterPlatformAlertOption(
                                  additionalWindowTitleOnWindows:
                                      'Window title',
                                  showAsLinksOnWindows: true),
                            );

                            if (result == CustomButton.positiveButton) {
                              var data = {};
                              ApiServices()
                                  .unpublishScheme(
                                      data, schemeData[index]["schemeID"])
                                  .then((value) {
                                if (value["status"] == true) {
                                  schemeData[index]["published"] = false;
                                  setState(() {});
                                  Fluttertoast.showToast(
                                      msg: "Scheme unPublished SuccessFully",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Failed To Publish Scheme...Try After Sometime",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              });
                            }
                          } else if (selectedOption == "Edit") {
                            var result =
                                await FlutterPlatformAlert.showCustomAlert(
                              windowTitle: 'Do you want to Edit this?',
                              text: '',
                              positiveButtonTitle: "Yes",
                              negativeButtonTitle: "No",
                              options: FlutterPlatformAlertOption(
                                  additionalWindowTitleOnWindows:
                                      'Window title',
                                  showAsLinksOnWindows: true),
                            );

                            if (result == CustomButton.positiveButton) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CreateSchemeScreen(
                                        routeFrom: "update",
                                        data: schemeData[index],
                                      )));
                            }
                          } else if (selectedOption == "Delete") {
                            var result =
                                await FlutterPlatformAlert.showCustomAlert(
                              windowTitle: 'Do you want to delete this?',
                              text: '',
                              positiveButtonTitle: "Yes",
                              negativeButtonTitle: "No",
                              options: FlutterPlatformAlertOption(
                                  additionalWindowTitleOnWindows:
                                      'Window title',
                                  showAsLinksOnWindows: true),
                            );
                            if (result == CustomButton.positiveButton) {
                              var data = {};
                              ApiServices()
                                  .Delete(data, schemeData[index]["schemeID"])
                                  .then((value) {
                                if (value["status"] == true) {
                                  schemeData[index]["deleted"] = true;
                                  setState(() {});
                                  Fluttertoast.showToast(
                                      msg: "Scheme Deleted SuccessFully",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Failed To Delete Scheme...Try After Sometime",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              });
                            }
                          }
                        }),
          )),
        ],
      ),
    );
  }

  // void changeIndex(DrawerIndex drawerIndexdata) {
  //   if (drawerIndex != drawerIndexdata) {
  //     drawerIndex = drawerIndexdata;
  //     switch (drawerIndex) {
  //       case DrawerIndex.scholership:
  //         break;
  //       case DrawerIndex.createScheme:
  //         setState(() {
  //           screenView = const CreateScheme();
  //         });
  //         break;
  //       default:
  //         break;
  //     }
  //   }
  // }

  updateId(String schemeType, String status, String startDate, String endDate) {
    // _searchResult.clear();

    if (schemeType != "Select any option") {
      setState(() {
        selectedSchemeType = schemeType;
        SchemeTypeSelectedStatus = true;
      });
    } else {
      setState(() {
        selectedSchemeType = "";
        SchemeTypeSelectedStatus = false;
      });
    }
    if (status != "Select any option") {
      setState(() {
        selectedStatus = status;
        StatusSelectedStatus = true;
      });
    } else {
      setState(() {
        selectedStatus = "";
        StatusSelectedStatus = false;
      });
    }
    if (startDate != "Start Date") {
      setState(() {
        selectedStartDate = startDate;
        StartDateSelectedStatus = true;
      });
    } else {
      setState(() {
        selectedStartDate = "";
        StartDateSelectedStatus = false;
      });
    }
    if (endDate != "End Date") {
      setState(() {
        selectedEndDate = endDate;
        EndDateSelectedStatus = true;
      });
    } else {
      setState(() {
        selectedEndDate = "";
        EndDateSelectedStatus = false;
      });
    }
  }

  GetAllSchemeList() async {
    await Future.delayed(Duration(seconds: 0));
    // final catalogJson =3
    //     await rootBundle.33loadString("assets/files/catalog.json");
    try {
      // Api for Login user3name or Password Verification

      Map<String, String> headers1 = {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${Global.token}'
      };
      //  "Content-Leng3th": "<calculated when request is sent>",
      //   "Host": "<33calculated when request is sent>",
      //   "User-Age3nt": "PostmanRuntime/7.29.2",
      //   "Accept"3: "*/*",
      //   "Accep33t-Encoding": "gzip, deflate, br",
      //   "Conn3ection": "keep-alive",
      var response =
          await http.get(Uri.parse(Api.getSchemeList), headers: headers1);
      var i = 0;

      if (response.statusCode == 200) {
        setState(() {
          _isloading = false;
        });
        schemeData = json.decode(response.body);
      } else if (response.statusCode == 401) {
        setState(() {
          _isloading = false;
        });
        // Fluttertoast.showToast(
        //     msg: "Incorrect Username Or Password",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 3,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white,
        //     fontSize: 16.0);
      } else {
        setState(() {
          _isloading = false;
        });
        // Fluttertoast.showToast(
        //     msg: "Something went wrong please try after sometime",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 3,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white,
        //     fontSize: 16.0);
      }
      //_showerrorDialog('Invalid UID');
    } catch (e) {
      return e.toString();
    }
  }
}

typedef void StringCallback(String selectedOption, int index);

class ReusbaleRow extends StatefulWidget {
  var indexOnject;

  final StringCallback optionTypeSelect;
  ReusbaleRow(
      {Key? key, required this.indexOnject, required this.optionTypeSelect})
      : super(key: key);

  @override
  State<ReusbaleRow> createState() => _ReusbaleRowState();
}

class _ReusbaleRowState extends State<ReusbaleRow> {
  bool publish = false;
  static bool _isExpand = false;
  static var map = <int, bool>{};
  static bool _isiterateflag = true;
  List a = [];

  DateTime dateformatter1(int dt) {
    var date = DateTime.fromMicrosecondsSinceEpoch(dt);
    DateTime parseDt = DateTime.parse(date.toString());
    return parseDt;
  }

  @override
  void initState() {
    super.initState();
    a = widget.indexOnject;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    if (_isiterateflag) {
      for (var i = 0; i <= a.length; i++) {
        map.putIfAbsent(i, () => false);
      }
      _isiterateflag = false;
    }

    return ListView.builder(
        itemCount: a.length,
        itemBuilder: (context2, index) {
          return Padding(
            padding: widget.indexOnject[index]['deleted']
                ? const EdgeInsets.only(top: 0)
                : const EdgeInsets.only(top: 10),
            child: widget.indexOnject[index]['deleted']
                ? Container(
                    height: 0,
                  )
                : Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: const BorderSide(
                        color: primaryColor,
                        width: 2,
                      ),
                    ),
                    color: Colors.white,
                    elevation: 10,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, top: 18, bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/images/default_profile.jpeg',
                                width: screenWidth * 0.13,
                                height: screenHeight * 0.07,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: SizedBox(
                                  width: screenWidth * 0.55,
                                  child: Text(
                                    widget.indexOnject[index]['schemeName']
                                        .toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: screenWidth * 0.037,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              PopupMenuButton(
                                itemBuilder: (ctx) => [
                                  widget.indexOnject[index]['published']
                                      ? PopupMenuItem(
                                          child: const Text(
                                            "UnPublish",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          onTap: () {
                                            widget.optionTypeSelect(
                                                "UnPublish", index);
                                          },
                                        )
                                      : PopupMenuItem(
                                          child: const Text(
                                            "Publish",
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                          onTap: () {
                                            widget.optionTypeSelect(
                                                "Publish", index);
                                          },
                                        ),
                                  PopupMenuItem(
                                    child: const Text("Edit"),
                                    onTap: () {
                                      widget.optionTypeSelect("Edit", index);
                                    },
                                  ),
                                  PopupMenuItem(
                                    child: const Text("Delete"),
                                    onTap: () {
                                      widget.optionTypeSelect("Delete", index);
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0,
                                      bottom: 8,
                                      left: 12,
                                      right: 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Status  ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            ":  " +
                                                (widget.indexOnject[index]
                                                        ['published']
                                                    ? "Published"
                                                    : "Unpublished"),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: widget.indexOnject[index]
                                                        ['published']
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ))
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0,
                                      bottom: 8,
                                      left: 12,
                                      right: 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "ScholarShip Amount ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.037,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            ":  " +
                                                widget.indexOnject[index]
                                                        ['schemeAmount']
                                                    .toString(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.037,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ))
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0,
                                      bottom: 8,
                                      left: 12,
                                      right: 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Scheme Type ",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.037,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            ": " +
                                                widget.indexOnject[index]
                                                        ['schemeType']
                                                    .toString(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ))
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0,
                                      bottom: 8,
                                      left: 12,
                                      right: 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Scheme For  ",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.037,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            ": " +
                                                widget.indexOnject[index]
                                                        ['schemeFor']
                                                    .toString(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ))
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0,
                                      bottom: 8,
                                      left: 12,
                                      right: 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Applicable For Financial Year ",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.037,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            ": " +
                                                widget.indexOnject[index]
                                                        ['financialYear']
                                                    .toString(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ))
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0,
                                      bottom: 8,
                                      left: 12,
                                      right: 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Start Date",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.037,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            ": ${widget.indexOnject[index]['startDate']} ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ))
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0,
                                      bottom: 8,
                                      left: 12,
                                      right: 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "End Date",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.037,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            ": ${widget.indexOnject[index]['endDate']}",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ))
                                    ],
                                  )),
// /---------------------------------------------------------------------------------
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: TextButton(
                                      // ignore: unnecessary_cast
                                      child: map[index] as bool
                                          ? Container(
                                              height: 0,
                                            )
                                          : const Text(
                                              "Read More",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                      onPressed: () {
                                        setState(() {
                                          map.update(index, (value) => true);
                                        });
                                      },
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: map[index] as bool ? 430 : 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: TextButton(
                                      child: const Text(
                                        "Eligiblity Criteria (Academics)",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {},
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0,
                                        bottom: 10,
                                        left: 12,
                                        right: 12),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Minimum Graduation Level Required ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              ": " +
                                                  widget.indexOnject[index]
                                                          ["eligibility"]
                                                          ["acadDtls"][0]
                                                          ["courseLevelName"]
                                                      .toString(),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.037,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ],
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0,
                                        bottom: 10,
                                        left: 12,
                                        right: 12),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Accepted Score Type ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              ": " +
                                                  widget.indexOnject[index]
                                                          ["eligibility"]
                                                          ["acadDtls"][0]
                                                          ["scoreType"]
                                                      .toString(),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.037,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ],
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0,
                                        bottom: 10,
                                        left: 12,
                                        right: 12),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Minimum Score Required ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              ": " +
                                                  widget.indexOnject[index]
                                                          ["eligibility"]
                                                          ["acadDtls"][0]
                                                          ["scoreValue"]
                                                      .toString(),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.037,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ],
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0,
                                        bottom: 10,
                                        left: 12,
                                        right: 12),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Passing Year ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              ": " +
                                                  widget.indexOnject[index]
                                                          ["eligibility"]
                                                          ["acadDtls"][0]
                                                          ["passingYear"]
                                                      .toString(),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.037,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ],
                                    )),
                                const Padding(
                                    padding:
                                        EdgeInsets.only(top: 12.0, bottom: 12),
                                    child: Text(
                                      "Eligibility Criteria (Other)",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0,
                                        bottom: 10,
                                        left: 12,
                                        right: 12),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Minimum Age Required ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              ": " +
                                                  widget.indexOnject[index]
                                                          ["eligibility"]["age"]
                                                      .toString(),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.037,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ],
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0,
                                        bottom: 10,
                                        left: 12,
                                        right: 12),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Gender ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              children: [
                                                Text(
                                                  ": ",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize:
                                                          screenWidth * 0.037,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  widget.indexOnject[index][
                                                                  "eligibility"]
                                                              ["gender"] !=
                                                          null
                                                      ? widget.indexOnject[
                                                                  index]
                                                              ["eligibility"]
                                                          ["gender"]
                                                      : 'NA',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize:
                                                          screenWidth * 0.037,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            )),
                                      ],
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0,
                                        bottom: 10,
                                        left: 12,
                                        right: 12),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Family Income  ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              ": ${widget.indexOnject[index]["eligibility"]["familyIncome"]}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.037,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ],
                                    )),
                                // Padding(
                                //     padding: const EdgeInsets.only(
                                //         top: 5.0,
                                //         bottom: 10,
                                //         left: 12,
                                //         right: 12),
                                //     child: Row(
                                //       children: [
                                //         Expanded(
                                //           flex: 1,
                                //           child: Text(
                                //             "Caste ",
                                //             textAlign: TextAlign.start,
                                //             style: TextStyle(
                                //                 fontSize: screenWidth * 0.037,
                                //                 fontWeight: FontWeight.w500),
                                //           ),
                                //         ),
                                //         Expanded(
                                //             flex: 1,
                                //             child: Text(
                                //               ": NA",
                                //               style: TextStyle(
                                //                   fontSize: screenWidth * 0.037,
                                //                   fontWeight: FontWeight.w500),
                                //             )),
                                //       ],
                                //     )),

                                Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: TextButton(
                                      child: const Text(
                                        "Read less",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          map.update(index, (value) => false);
                                        });
                                      },
                                    )),

// /-----------------------------------------------------------------------------------
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
          );
        });
  }
}
