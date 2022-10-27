import 'dart:convert';

import 'package:dsep_bpp/screens/create_scheme_screen.dart';
import 'package:dsep_bpp/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter/services.dart'
    show SystemChrome, SystemUiOverlayStyle, rootBundle;
import 'package:is_first_run/is_first_run.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import '../advance_search.dart';
import 'package:showcaseview/showcaseview.dart';
import '../utils/api.dart';
import '../utils/colors_widget.dart';
import '../utils/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_drawer/drawer_user_controller.dart';
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
  var schemeDatanew;
  bool _isloading = false;

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
            ShowCaseWidget.of(context).startShowCase([_one, _two, _three]);
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

    print("type schemedata $schemeData.runtimeType");
    print("type schemedatanew $schemeDatanew.runtimeType");

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
          SizedBox(
            height: 50,
            child: Showcase(
              key: _one,
              title: "Search",
              description: 'Search schemas',
              overlayPadding: const EdgeInsets.all(10),
              child: TextFormField(
                //controller: searchController,
                //onChanged: searchFalse(),
                cursorColor: primaryColor,
                style: const TextStyle(
                  color: Colors.black,
                ),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  contentPadding: const EdgeInsets.only(top: 15),
                  counterText: "",
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  hintText: "Search...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: primaryColor, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: primaryColor, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SchemeTypeSelectedStatus
                            ? TextButton(
                                onPressed: () {
                                  setState(() {
                                    SchemeTypeSelectedStatus = false;
                                    selectedSchemeType = "Select any option";
                                    //  gender = value.toString();
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Text(selectedSchemeType,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: screenFontSmall,
                                            )),
                                        SizedBox(
                                          width: screenWidth * 0.01,
                                        ),
                                        const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                            : const SizedBox(),
                        StatusSelectedStatus
                            ? TextButton(
                                onPressed: () {
                                  setState(() {
                                    StatusSelectedStatus = false;
                                    selectedStatus = "Select any option";
                                    //  gender = value.toString();
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Text(selectedStatus,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: screenFontSmall,
                                            )),
                                        SizedBox(
                                          width: screenWidth * 0.01,
                                        ),
                                        const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                            : const SizedBox(),
                        StartDateSelectedStatus
                            ? TextButton(
                                onPressed: () {
                                  setState(() {
                                    StartDateSelectedStatus = false;
                                    selectedStartDate = "Select any option";
                                    //  gender = value.toString();
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Text(selectedStartDate,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: screenFontSmall,
                                            )),
                                        SizedBox(
                                          width: screenWidth * 0.01,
                                        ),
                                        const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                            : const SizedBox(),
                        EndDateSelectedStatus
                            ? TextButton(
                                onPressed: () {
                                  setState(() {
                                    EndDateSelectedStatus = false;
                                    selectedEndDate = "Select any option";
                                    //  gender = value.toString();
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Text(selectedEndDate,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: screenFontSmall,
                                            )),
                                        SizedBox(
                                          width: screenWidth * 0.01,
                                        ),
                                        const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
                AdvanceSearchPage(onAdvanceSearchTypeSelect:
                    (String selectedSchemeType, String selectedStatus,
                        String selectedStartDate, String selectedEndDate) {
                  updateId(selectedSchemeType, selectedStatus,
                      selectedStartDate, selectedEndDate);
                })
              ],
            ),
          ),
          Expanded(
              child: Showcase(
            key: _three,
            description: 'List of all created schemas',
            overlayPadding: const EdgeInsets.all(10),
            child: _isloading
                ? Loader()
                : ReusbaleRow(
                    indexOnject: schemeData,
                    optionTypeSelect: (String selectedOption, int index) async {
                      // print("abc " + selectedOption + index.toString());
                      if (selectedOption == "Publish") {
                        var result = await FlutterPlatformAlert.showCustomAlert(
                          windowTitle: 'Do you want to Publish this?',
                          text: '',
                          positiveButtonTitle: "Yes",
                          negativeButtonTitle: "No",
                          options: FlutterPlatformAlertOption(
                              additionalWindowTitleOnWindows: 'Window title',
                              showAsLinksOnWindows: true),
                        );
                        print(result);
                            if (result == CustomButton.positiveButton) {
                          var data = {};
                          ApiServices()
                              .publishScheme(
                                  data, schemeData[index]["schemeID"])
                              .then((value) {
                            if (value["status"] == true) {
                              schemeData[index]["published"] = true;
                              setState(() {
                                
                              });
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
                        var result = await FlutterPlatformAlert.showCustomAlert(
                          windowTitle: 'Do you want to UnPublish this?',
                          text: '',
                          positiveButtonTitle: "Yes",
                          negativeButtonTitle: "No",
                          options: FlutterPlatformAlertOption(
                              additionalWindowTitleOnWindows: 'Window title',
                              showAsLinksOnWindows: true),
                        );
                        print(result);
                           if (result == CustomButton.positiveButton) {
                          var data = {};
                          ApiServices()
                              .unpublishScheme(
                                  data, schemeData[index]["schemeID"])
                              .then((value) {
                            if (value["status"] == true) {
                              schemeData[index]["published"] = false;
                              setState(() {
                                
                              });
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
                        var result = await FlutterPlatformAlert.showCustomAlert(
                          windowTitle: 'Do you want to Edit this?',
                          text: '',
                          positiveButtonTitle: "Yes",
                          negativeButtonTitle: "No",
                          options: FlutterPlatformAlertOption(
                              additionalWindowTitleOnWindows: 'Window title',
                              showAsLinksOnWindows: true),
                        );

                        if (result == CustomButton.positiveButton) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CreateSchemeScreen(
                                    routeFrom: "update",
                                    data: schemeData[index],
                                  )));
                        }
                        print("result ------ $result");
                      } else if (selectedOption == "Delete") {
                        var result = await FlutterPlatformAlert.showCustomAlert(
                          windowTitle: 'Do you want to delete this?',
                          text: '',
                          positiveButtonTitle: "Yes",
                          negativeButtonTitle: "No",
                          options: FlutterPlatformAlertOption(
                              additionalWindowTitleOnWindows: 'Window title',
                              showAsLinksOnWindows: true),
                        );
                        print(result);
                                if (result == CustomButton.positiveButton) {
                          var data = {};
                          ApiServices()
                              .Delete(
                                  data, schemeData[index]["schemeID"])
                              .then((value) {
                            if (value["status"] == true) {
                              schemeData[index]["deleted"] = true;
                              setState(() {
                                
                              });
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
      print("ResponseCode : ${response.statusCode}");
      if (response.statusCode == 200) {
        setState(() {
          _isloading = false;
        });
        schemeData = json.decode(response.body);
        print("GetScheme_Response :$schemeData");
        var j = 0;
      } else if (response.statusCode == 401) {
        // Fluttertoast.showToast(
        //     msg: "Incorrect Username Or Password",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 3,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white,
        //     fontSize: 16.0);

      } else {
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

  DateTime dateformatter1(int dt) {
    var date = DateTime.fromMicrosecondsSinceEpoch(dt);
    DateTime parseDt = DateTime.parse(date.toString());
    return parseDt;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
        itemCount: widget.indexOnject.length,
        itemBuilder: (context2, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child:widget.indexOnject[index]['deleted'] ? Card() : Card(
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
                      const EdgeInsets.only(left: 18.0, top: 18, bottom: 18),
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
                                    fontSize: screenWidth * 0.034,
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
                                       
                                      },
                                    )
                                  : PopupMenuItem(
                                      child: const Text(
                                        "Publish",
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      onTap: () {
                                        
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Offered By " +
                                widget.indexOnject[index]['schemeProviderID']
                                    .toString(),
                            style: TextStyle(
                                fontSize: screenWidth * 0.033,
                                fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: Text(
                              "ScholarShip Amount -" +
                                  widget.indexOnject[index]['schemeAmount']
                                      .toString(),
                              style: TextStyle(
                                  fontSize: screenWidth * 0.033,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Text(
                                "Scheme Type: " +
                                    widget.indexOnject[index]['schemeType']
                                        .toString(),
                                style: TextStyle(
                                    fontSize: screenWidth * 0.033,
                                    fontWeight: FontWeight.w500),
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Text(
                                "Scheme For :" +
                                    widget.indexOnject[index]["schemeFor"]
                                        .toString(),
                                style: TextStyle(
                                    fontSize: screenWidth * 0.033,
                                    fontWeight: FontWeight.w500),
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Text(
                                "Applicable For Financial Year: " +
                                    widget.indexOnject[index]['financialYear']
                                        .toString(),
                                style: TextStyle(
                                    fontSize: screenWidth * 0.033,
                                    fontWeight: FontWeight.w500),
                              )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Start Date: ",
                                  style: TextStyle(
                                      fontSize: screenWidth * 0.033,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    dateformatter1(widget.indexOnject[index]
                                            ['startDate'])
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: screenWidth * 0.033,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "End Date: ",
                                  style: TextStyle(
                                      fontSize: screenWidth * 0.033,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    dateformatter1(widget.indexOnject[index]
                                            ['endDate'])
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: screenWidth * 0.033,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextButton(
                                  child: const Text(
                                    "Eligiblity Criteria (Academics)",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {},
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 5.0, bottom: 8),
                                child: Text(
                                  "Minimum Graduation Level Required : " +
                                      widget.indexOnject[index]["eligibility"]
                                              ["acadDtls"][0]["courseLevelName"]
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: screenWidth * 0.033,
                                      fontWeight: FontWeight.w500),
                                )),
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 8),
                                child: Text(
                                  "Accepted Score Type : " +
                                      widget.indexOnject[index]["eligibility"]
                                              ["acadDtls"][0]["scoreType"]
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: screenWidth * 0.033,
                                      fontWeight: FontWeight.w500),
                                )),
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 8),
                                child: Text(
                                  "Minimum Score Required : " +
                                      widget.indexOnject[index]["eligibility"]
                                              ["acadDtls"][0]["scoreValue"]
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: screenWidth * 0.033,
                                      fontWeight: FontWeight.w500),
                                )),
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 10),
                                child: Text(
                                  "Passing Year  : " +
                                      widget.indexOnject[index]["eligibility"]
                                              ["acadDtls"][0]["passingYear"]
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: screenWidth * 0.033,
                                      fontWeight: FontWeight.w500),
                                )),
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 8),
                                child: Text(
                                  "Eligibility Criteria (Other)",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 8),
                                child: Text(
                                  "Minimum Age Required : " +
                                      widget.indexOnject[index]["eligibility"]
                                              ["age"]
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: screenWidth * 0.033,
                                      fontWeight: FontWeight.w500),
                                )),
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 8),
                                child: Text(
                                  "Gender : " +
                                      widget.indexOnject[index]["eligibility"]
                                          ["gender"],
                                  style: TextStyle(
                                      fontSize: screenWidth * 0.033,
                                      fontWeight: FontWeight.w500),
                                )),
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 8),
                                child: Text(
                                  "Family Income : ",
                                  style: TextStyle(
                                      fontSize: screenWidth * 0.033,
                                      fontWeight: FontWeight.w500),
                                )),
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 8),
                                child: Text(
                                  "Caste : ",
                                  style: TextStyle(
                                      fontSize: screenWidth * 0.033,
                                      fontWeight: FontWeight.w500),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          );
        });
  }
}
