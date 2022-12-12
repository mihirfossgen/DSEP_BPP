import 'dart:convert';

import 'package:dsep_bpp/provides/ApiServices.dart';
import 'package:dsep_bpp/screens/tabbar.dart';
import 'package:dsep_bpp/utils/api.dart';
import 'package:dsep_bpp/utils/colors_widget.dart';
import 'package:dsep_bpp/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:sticky_headers/sticky_headers.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:forme/forme.dart';
import '../models/scheme_provider_list_model.dart';
import '../screens/add_eligibility_screen.dart';
import '../widgets/form_widgets/validaton_icon.dart';
import '../widgets/form_widgets/form_custom_datepicker.dart';
import '../widgets/form_widgets/form_custom_textfield.dart';
import '../widgets/form_widgets/form_custom_dropdown.dart';
import '../widgets/text_widget.dart';
import './../widgets/form_widgets/form_caption_text.dart';
import '../models/create_scheme_model.dart';
import './../widgets/title_text.dart';
import './../widgets/value_text.dart';
import './../widgets/widget_utl.dart';
import '../widgets/responsive_ui.dart';
import 'package:intl/intl.dart';

class CreateSchemeScreen extends StatefulWidget {
  final String routeFrom;
  var data;
  CreateSchemeScreen({Key? key, required this.routeFrom, this.data})
      : super(key: key);

  @override
  _CreateSchemeState createState() => _CreateSchemeState();
}

class _CreateSchemeState extends State<CreateSchemeScreen> {
  late double _height;
  late double _width;
  late double _pixelRatio;
  late bool _large;
  late bool _medium;
  late double _bottom;
  late double _top;
  final FormeKey formKey = FormeKey();
  late CreateScheme scheme;
  int trainingDetailsIndex = 0;
  late Eligibility eligibilityDetails;
  final List<_EligibilityDetails> eligibilityDetailsWidgets = [];
  final List<_QualificationDetails> qualificationWidgets = [];
  int _index = 0;
  int _focusedIndex = 0;
  bool _isEligibilityAdded = false;
  bool _isPastEducationAdded = false;
  GlobalKey<ScrollSnapListState> sslKey = GlobalKey();
  Map<String, String> schemeValue = {};
  late Eligibility details;
  late PastEducation pastEducation;
  late List<SchemeProviderListModel> list;
  bool _isLoading = false;
  List<String> schemeProvidername = [];
  bool _buttonisLoading = false;
  String schemeProviderId = '';
  List response = [];
  var editableData;
  bool routeFromUpdate = false;
  List<String> schemeType = ['Scholarship', 'Grant'];
  TextEditingController schemeProviderIdController = TextEditingController();
  TextEditingController schemeTypeController = TextEditingController();
  TextEditingController schemeForController = TextEditingController();
  TextEditingController financialYearController = TextEditingController();
  String _selectedSchemeFor = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //qualificationCriteriaWidgets.add(addQualificationCriteria());
    //  callschemedata();
    //_isLoading = true;
    if (widget.routeFrom == "update") {
      routeFromUpdate = true;
      editableData = widget.data;
      schemeProviderIdController.text = editableData['schemeProviderID'];
      schemeTypeController.text = editableData['schemeType'];
      financialYearController.text = editableData['financialYear'];
      if (editableData['schemeFor'] == 'ug') {
        _selectedSchemeFor = 'ug';
        schemeForController.text = "Under Graduate";
      } else if (editableData['schemeFor'] == 'pg') {
        _selectedSchemeFor = 'pg';
        schemeForController.text = 'Post Graduate';
      } else {
        _selectedSchemeFor = 'gr';
        schemeForController.text = 'Grade';
      }
    }
  }

  void callschemedata() {
    ApiServices().listSchemeProviderList().then((value) {
      setState(() {
        _isLoading = false;

        response = json.decode(value);

        for (var i = 0; i < response.length; i++) {
          if (response[i]['active']) {
            schemeProvidername.add(response[i]['schemeProviderName']);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        leading: PlatformIconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () =>
              Navigator.of(context, rootNavigator: true).pop(context),
        ),
        cupertino: (_, __) => CupertinoNavigationBarData(
          // If this is enabled and set to true then the IconButton above will complain of no parent Material widget
          noMaterialParent: true,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title:
            const Text('Create Scheme', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: _isLoading ? Loader() : _buildForm(context),
      ),
    );
  }

  DateTime dateformatter1(String dt) {
    // var date = DateTime.fromMicrosecondsSinceEpoch(dt);
    DateTime parseDt = DateTime.parse(dt);
    return parseDt;
  }

  String dateformatter(String dt) {
    DateTime parseDt = DateTime.parse(dt);
    var newFormat = DateFormat("yyyy-MM-dd");
    String updatedDt = newFormat.format(parseDt);
    // 20-
    return updatedDt;
  }

  void getUpdatedValueAndSubmit(
      BuildContext context, Map<String, dynamic> values) {
    values["Scheme Provider ID"] = schemeProviderIdController.text;
    values["Scheme Type"] = schemeTypeController.text;
    values['Financial Year'] = financialYearController.text;
    if (schemeForController.text == 'Under Graduate') {
      values["Scheme For"] = 'ug';
    } else if (schemeForController.text == 'Post Graduate') {
      values["Scheme For"] = 'pg';
    } else {
      values["Scheme For"] = 'gr';
    }
    //String Scheme_ID = values["Scheme ID"];
    String Scheme_Name = values["Scheme Name"] as String;
    String Scheme_Description = values["Scheme Description"] as String;
    String Scheme_Provider_ID = values["Scheme Provider ID"] as String;
    // String Scheme_Provider_Name = values["Scheme Provider Name"] as String;
    // String Scheme_Provider_Description =
    //     values["Scheme Provider Description"] as String;
    String Scheme_Type = values["Scheme Type"] as String;
    String Financial_Year = values["Financial Year"] as String;
    String Scheme_For = values["Scheme For"] as String;
    String Scheme_Amount = values["Scheme Amount"] as String;
    String Start_date = values["Start date"].toString();
    String End_date = values["End date"].toString();
    schemeValue = {
      //'Scheme ID': Scheme_ID,
      'Scheme Name': Scheme_Name,
      'Scheme Description': Scheme_Description,
      'Scheme Provider ID': Scheme_Provider_ID,
      // 'Scheme Provider Name': Scheme_Provider_Name,
      // 'Scheme Provider Description': Scheme_Provider_Description,
      'Scheme Type': schemeTypeController.text,
      'Financial Year': Financial_Year,
      'Scheme For': schemeForController.text,
      'Scheme Amount': Scheme_Amount,
      'Start date': Start_date,
      'End date': End_date
    };

    for (var i = 0; i < response.length; i++) {
      if (response[i]['schemeProviderName'] ==
          schemeProviderIdController.text) {
        schemeProviderId = (response[i]['id']);
      }
    }

    var req = {
      "schemeName": Scheme_Name,
      "schemeDescription": Scheme_Description,
      "schemeType": Scheme_Type,
      //"schemeProviderID": schemeProviderId,
      "schemeFor": Scheme_For,
      "financialYear": Financial_Year,
      "schemeAmount": Scheme_Amount,
      "startDate": dateformatter(Start_date),
      "endDate": dateformatter(End_date),
      "eligibility": {
        "acadDtls": details.academicDetails,
        "gender": details.gender,
        "familyIncome": details.familyIncome
      },
      "addtnlInfoReq": "e8923y2jbu32848ab",
      "spocName": details.spocName,
      "spocEmail": details.spocEmail,
      "helpdeskNo": details.helpdeskNo
    };
    print(jsonEncode(req));
    if (widget.routeFrom == "home") {
      ApiServices().createScheme(req).then((values) {
        if (values['status'] == "SUCCESS") {
          setState(() {
            _buttonisLoading = false;
          });
          Fluttertoast.showToast(
                  msg: "Scheme created successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0)
              .then((value) {
            Future.delayed(
              const Duration(seconds: 3),
              () => navigation(),
            );
          });
          setState(() {});
        } else {
          setState(() {
            _buttonisLoading = false;
          });
          Fluttertoast.showToast(
              msg: "Failed to create scheme",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      });
    }
    if (widget.routeFrom == "update") {
      ApiServices().updateScheme(req, editableData['schemeID']).then((value) {
        if (value['status'] == true) {
          setState(() {
            _buttonisLoading = false;
          });
          Fluttertoast.showToast(
                  msg: "Scheme updated successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0)
              .then((value) {
            Future.delayed(
              const Duration(seconds: 3),
              () => navigation(),
            );
          });
          setState(() {});
        } else {
          setState(() {
            _buttonisLoading = false;
          });
          Fluttertoast.showToast(
              msg: "Failed to update scheme",
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

  navigation() {
    Navigator?.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Tabbar()));
  }

  List<Widget> loadFormFieldSection() {
    final children = <Widget>[];
    Widget widget = Container(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 12,
        child: Column(
          children: [
            this.widget.routeFrom == "home"
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 10.0, top: 15.0),
                        child: FormCaptionText('Scheme ID', 0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0),
                        child: FormCustomTextField(
                            name: 'Scheme ID',
                            order: 1,
                            hint: '',
                            readOnly: true,
                            initalValue:
                                routeFromUpdate ? editableData['schemeID'] : "",
                            validator: FormeValidates.notEmpty(
                                errorText: 'Scheme ID is required'),
                            keyboardType: TextInputType.name,
                            cornerRadius: 15.0,
                            cursorColor: Colors.blue,
                            borderColor: Colors.grey,
                            icon: const ValidationIcon()),
                      )
                    ],
                  ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
                  child: FormCaptionText('Scheme Name', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomTextField(
                      name: 'Scheme Name',
                      order: 2,
                      hint: '',
                      initalValue:
                          routeFromUpdate ? editableData['schemeName'] : "",
                      validator: FormeValidates.notEmpty(
                          errorText: 'Scheme Name is required'),
                      keyboardType: TextInputType.name,
                      cornerRadius: 15.0,
                      cursorColor: Colors.blue,
                      borderColor: Colors.grey,
                      icon: const ValidationIcon()),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
                  child: FormCaptionText('Scheme Description', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomTextField(
                      name: 'Scheme Description',
                      order: 3,
                      hint: '',
                      initalValue: routeFromUpdate
                          ? editableData['schemeDescription']
                          : "",
                      validator: FormeValidates.notEmpty(errorText: ''),
                      keyboardType: TextInputType.name,
                      cornerRadius: 15.0,
                      cursorColor: Colors.blue,
                      borderColor: Colors.grey,
                      icon: const ValidationIcon()),
                )
              ],
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Padding(
            //       padding:
            //           const EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
            //       child: FormCaptionText('Scheme Provider ID', 0),
            //     ),
            //     Padding(
            //         padding: const EdgeInsets.only(
            //             left: 10.0, right: 10.0, top: 10.0),
            //         child: InkWell(
            //           onTap: () {
            //             FocusScope.of(context).unfocus();
            //             showModalBottomSheet<dynamic>(
            //                 isScrollControlled: true,
            //                 context: context,
            //                 backgroundColor: Colors.transparent,
            //                 builder: (BuildContext bc) {
            //                   return Bottomsheet(
            //                     onchanged: ((value) {
            //                       schemeProviderIdController.text = value;
            //                       setState(() {});
            //                     }),
            //                     values: schemeProvidername,
            //                     selectedvalue: schemeProviderIdController.text,
            //                   );
            //                 });
            //           },
            //           child: AbsorbPointer(
            //               child: TextFormField(
            //             controller: schemeProviderIdController,
            //             decoration: InputDecoration(
            //               suffixIcon: const Padding(
            //                 padding: EdgeInsets.all(8.0),
            //                 child: Icon(Icons.arrow_drop_down,
            //                     color: Colors.black),
            //               ),
            //               floatingLabelBehavior: FloatingLabelBehavior.never,
            //               suffixIconConstraints:
            //                   const BoxConstraints.tightFor(),
            //               border: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(15),
            //                   borderSide: const BorderSide(
            //                       color: Colors.blue, width: 0.0)),
            //               //hintText: hint,
            //             ),
            //           )),
            //         )

            //         // FormCustomDropDown(
            //         //     initialValue: schemeProvidername[0],
            //         //     name: 'Scheme Provider ID',
            //         //     order: 2,
            //         //     hint: routeFromUpdate
            //         //         ? editableData['schemeProviderID']
            //         //         : "",
            //         //     validator: FormeValidates.notEmpty(
            //         //         errorText: 'Scheme Provider ID is required'),
            //         //     items: schemeProvidername),
            //         )
            //   ],
            // ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Padding(
            //       padding:
            //           const EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
            //       child: FormCaptionText('Scheme Provider Name', 0),
            //     ),
            //     Padding(
            //       padding:
            //           const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            //       child: FormCustomTextField(
            //           name: 'Scheme Provider Name',
            //           order: 2,
            //           hint: '',
            //           initalValue: '',
            //           validator: FormeValidates.notEmpty(
            //               errorText: 'Scheme Provider Name is required'),
            //           keyboardType: TextInputType.name,
            //           cornerRadius: 15.0,
            //           cursorColor: Colors.blue,
            //           borderColor: Colors.grey,
            //           icon: const ValidationIcon()),
            //     )
            //   ],
            // ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Padding(
            //       padding:
            //           const EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
            //       child: FormCaptionText('Scheme Provider Description', 0),
            //     ),
            //     Padding(
            //       padding:
            //           const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            //       child: FormCustomTextField(
            //           name: 'Scheme Provider Description',
            //           order: 3,
            //           hint: '',
            //           initalValue: '',
            //           validator: FormeValidates.notEmpty(errorText: ''),
            //           keyboardType: TextInputType.name,
            //           cornerRadius: 15.0,
            //           cursorColor: Colors.blue,
            //           borderColor: Colors.grey,
            //           icon: const ValidationIcon()),
            //     )
            //   ],
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
                  child: FormCaptionText('Scheme Type', 0),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0),
                    child: InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        showModalBottomSheet<dynamic>(
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext bc) {
                              return Bottomsheet(
                                onchanged: ((value) {
                                  schemeTypeController.text = value;
                                  setState(() {});
                                }),
                                values: const ['Scholarship', 'Grant'],
                                selectedvalue: schemeTypeController.text,
                              );
                            });
                      },
                      child: AbsorbPointer(
                          child: TextFormField(
                        controller: schemeTypeController,
                        decoration: InputDecoration(
                          suffixIcon: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_drop_down,
                                color: Colors.black),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          suffixIconConstraints:
                              const BoxConstraints.tightFor(),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 0.0)),
                          //hintText: hint,
                        ),
                      )),
                    )

                    // FormCustomDropDown(
                    //     name: 'Scheme Type',
                    //     order: 2,
                    //     hint: routeFromUpdate ? editableData['schemeType'] : "",
                    //     validator: FormeValidates.notEmpty(
                    //         errorText: 'Scheme Type is required'),
                    //     items: const ['Scholarship', 'Grant']),
                    )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
                  child: FormCaptionText('Financial Year', 0),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0),
                    child: InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        showModalBottomSheet<dynamic>(
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext bc) {
                              return Bottomsheet(
                                onchanged: ((value) {
                                  financialYearController.text = value;
                                  setState(() {});
                                }),
                                values: const [
                                  '2021-2022',
                                  '2022-2023',
                                  '2023-2024'
                                ],
                                selectedvalue: financialYearController.text,
                              );
                            });
                      },
                      child: AbsorbPointer(
                          child: TextFormField(
                        controller: financialYearController,
                        decoration: InputDecoration(
                          suffixIcon: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_drop_down,
                                color: Colors.black),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          suffixIconConstraints:
                              const BoxConstraints.tightFor(),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 0.0)),
                          //hintText: hint,
                        ),
                      )),
                    )

                    // FormCustomDropDown(
                    //     name: 'Scheme Type',
                    //     order: 2,
                    //     hint: routeFromUpdate ? editableData['schemeType'] : "",
                    //     validator: FormeValidates.notEmpty(
                    //         errorText: 'Scheme Type is required'),
                    //     items: const ['Scholarship', 'Grant']),
                    )

                // Padding(
                //   padding:
                //       const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                //   child: FormCustomTextField(
                //       name: 'Financial Year',
                //       order: 4,
                //       hint: '',
                //       initalValue:
                //           routeFromUpdate ? editableData['financialYear'] : "",
                //       validator: FormeValidates.notEmpty(errorText: ''),
                //       keyboardType: TextInputType.name,
                //       cornerRadius: 15.0,
                //       cursorColor: Colors.blue,
                //       borderColor: Colors.grey,
                //       icon: const ValidationIcon()),
                // )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
                  child: FormCaptionText('Scheme For', 0),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0),
                    child: InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        showModalBottomSheet<dynamic>(
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext bc) {
                              return Bottomsheet(
                                onchanged: ((value) {
                                  schemeForController.text = value;
                                  if (schemeForController.text ==
                                      'Under Graduate') {
                                    _selectedSchemeFor = 'ug';
                                  } else if (schemeForController.text ==
                                      'Post Graduate') {
                                    _selectedSchemeFor = 'pg';
                                  } else {
                                    _selectedSchemeFor = 'gr';
                                  }
                                  setState(() {});
                                }),
                                values: const [
                                  'Under Graduate',
                                  'Post Graduate',
                                  'Grade'
                                ],
                                selectedvalue: schemeForController.text,
                              );
                            });
                      },
                      child: AbsorbPointer(
                          child: TextFormField(
                        controller: schemeForController,
                        decoration: InputDecoration(
                          suffixIcon: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_drop_down,
                                color: Colors.black),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          suffixIconConstraints:
                              const BoxConstraints.tightFor(),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 0.0)),
                          //hintText: hint,
                        ),
                      )),
                    )
                    // FormCustomDropDown(
                    //     name: 'Scheme For',
                    //     order: 5,
                    //     hint: routeFromUpdate ? editableData['schemeFor'] : "",
                    //     validator: FormeValidates.notEmpty(
                    //         errorText: ' Scheme For is required'),
                    //     items: const [
                    //       'Under Graduate',
                    //       'Post Graduate',
                    //       'Phd',
                    //       'Professional/Skill Course'
                    //     ]),
                    )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
                  child: FormCaptionText('Scheme Amount', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomTextField(
                      name: 'Scheme Amount',
                      order: 6,
                      hint: '',
                      initalValue: routeFromUpdate
                          ? editableData['schemeAmount'].toString()
                          : "",
                      validator: FormeValidates.notEmpty(errorText: ''),
                      keyboardType: TextInputType.number,
                      cornerRadius: 15.0,
                      cursorColor: Colors.blue,
                      borderColor: Colors.grey,
                      icon: const ValidationIcon()),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
                  child: FormCaptionText('Start Date', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomDatePicker(
                      initialValue: routeFromUpdate
                          ? dateformatter1(editableData['startDate'])
                          : null,
                      name: 'Start date',
                      order: 7,
                      hint: routeFromUpdate ? editableData['schemeID'] : "",
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                      icon: Icons.calendar_month),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
                  child: FormCaptionText('End Date', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomDatePicker(
                      initialValue: routeFromUpdate
                          ? dateformatter1(editableData['endDate'])
                          : null,
                      name: 'End date',
                      order: 7,
                      hint: "",
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                      icon: Icons.calendar_month),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: eligibilityDetailsWidgets
                          .map((e) => e.widget)
                          .toList(),
                    ),
                    !_isEligibilityAdded
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextButton(
                              onPressed: (() async {
                                Map<String, dynamic> object =
                                    await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddEligibility(
                                            selectedSchemeFor:
                                                _selectedSchemeFor,
                                            spocdata: editableData,
                                            routeFrom: routeFromUpdate
                                                ? "update"
                                                : "home",
                                            data: routeFromUpdate
                                                ? editableData['eligibility']
                                                : [],
                                          )),
                                );
                                if (object['details'] != null) {
                                  details = object['details'];
                                  appendDetails(details);
                                }
                              }),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.add),
                                      Text('Add Past Education Details')
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(
                            height: 10,
                          ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ],
        ),
      ),
    );
    setState(() {
      children.add(widget);
    });
    return children;
  }

  void appendDetails(Eligibility? details) {
    if (details != null) {
      eligibilityDetails = details;
      var educationDetials = eligibilityDetails.pastEducation;
      if (educationDetials != null && educationDetials.isNotEmpty) {
        if (educationDetials.isNotEmpty) {
          setState(() {
            _isPastEducationAdded = true;
          });
        }
      }
      List<Widget> academicDetails = [];
      for (var i = 0; i < details.academicDetails!.length; i++) {
        academicDetails.add(Column(children: [
          // WidgetUtl.getVerticalSpace(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: <Widget>[
          //     Padding(
          //       padding: const EdgeInsets.only(left: 12),
          //       child: TitleText(
          //         ('Course Level ID:'),
          //         0,
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(left: 5, right: 5),
          //       child: ValueText(
          //         (eligibilityDetails.courseLevelID ?? ''),
          //         0,
          //       ),
          //     )
          //   ],
          // ),
          WidgetUtl.getVerticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: TitleText(
                  ('Course Level Name:'),
                  0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: ValueText(
                  (details.academicDetails![i]['courseLevelName'] ?? ''),
                  0,
                ),
              )
            ],
          ),
          WidgetUtl.getVerticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: TitleText(
                  ('Course Name:'),
                  0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: ValueText(
                  (details.academicDetails![i]['courseName'] ?? ''),
                  0,
                ),
              )
            ],
          ),
          WidgetUtl.getVerticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: TitleText(
                  ('Score Type:'),
                  0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: ValueText(
                  (details.academicDetails![i]['scoreType'] ?? ''),
                  0,
                ),
              )
            ],
          ),
          WidgetUtl.getVerticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: TitleText(
                  ('Score Value:'),
                  0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: ValueText(
                  (details.academicDetails![i]['scoreValue'] ?? ''),
                  0,
                ),
              )
            ],
          ),
          WidgetUtl.getVerticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: TitleText(
                  ('Passing year:'),
                  0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: ValueText(
                  (details.academicDetails![i]['passingYear'] ?? ''),
                  0,
                ),
              )
            ],
          ),
          WidgetUtl.getVerticalSpace(),
        ]));
      }
      final Widget widget = Center(
        child: Column(
          children: [
            StickyHeader(
              header: Container(
                height: 50.0,
                color: secondaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        'Eligibility Criteria',
                        style: TextStyle(color: Colors.white),
                      ),
                    ]),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //add qualification details
                  // _isPastEducationAdded
                  //     ? Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: SizedBox(
                  //           height: 340,
                  //           width: _width / 0.05,
                  //           child: ListView(
                  //               scrollDirection: Axis.horizontal,
                  //               children: <Widget>[
                  //                 for (var item
                  //                     in eligibilityDetails.pastEducation ?? [])
                  //                   Container(
                  //                       child: appendQualificaionDetails(item)),
                  //               ]),
                  //         ),
                  //       )
                  //     : const SizedBox(),
                  WidgetUtl.getVerticalSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: TitleText(
                          ('Gender:'),
                          0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: ValueText(
                          (eligibilityDetails.gender ?? ''),
                          0,
                        ),
                      )
                    ],
                  ),
                  WidgetUtl.getVerticalSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: TitleText(
                          ('Family Income:'),
                          0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: ValueText(
                          (eligibilityDetails.familyIncome ?? ''),
                          0,
                        ),
                      )
                    ],
                  ),
                  WidgetUtl.getVerticalSpace(),
                ],
              ),
            ),
            StickyHeader(
                header: Container(
                  height: 50.0,
                  color: secondaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text(
                          'Academic Details',
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                ),
                content: Column(
                  children: academicDetails,
                )),
            StickyHeader(
              header: Container(
                height: 50.0,
                color: secondaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        'Additional Information',
                        style: TextStyle(color: Colors.white),
                      ),
                    ]),
              ),
              content: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      WidgetUtl.getVerticalSpace(),
                      WidgetUtl.getVerticalSpace(),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: TitleText(
                          ('Spoc Name:'),
                          0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: ValueText(
                          (eligibilityDetails.spocName ?? ''),
                          0,
                        ),
                      )
                    ],
                  ),
                  WidgetUtl.getVerticalSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: TitleText(
                          ('Spoc Email:'),
                          0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: ValueText(
                          (eligibilityDetails.spocEmail ?? ''),
                          0,
                        ),
                      )
                    ],
                  ),
                  WidgetUtl.getVerticalSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: TitleText(
                          ('Help Desk No:'),
                          0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: ValueText(
                          (eligibilityDetails.helpdeskNo ?? ''),
                          0,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
      setState(() {
        _isEligibilityAdded = true;
        eligibilityDetailsWidgets.add(_EligibilityDetails(widget));
      });
    }
  }

  Widget appendQualificaionDetails(PastEducation eDetails) {
    pastEducation = eDetails;
    final Widget widget = Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 15),
                child: Text(
                  'Qualification Details',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor),
                ),
              ),
              SizedBox(
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        // trainingDetails.removeWhere(
                        //     (element) => element.index == index);
                        // trainingDetailsIndex = trainingDetails.length;
                      });
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.blue,
                    )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: TitleText(
                  ('Course Level ID:'),
                  0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: ValueText(
                  (eDetails.courseLevelID ?? ''),
                  0,
                ),
              )
            ],
          ),
          WidgetUtl.getVerticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: TitleText(
                  ('Course Level Name:'),
                  0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: ValueText(
                  (eDetails.courseLevelName ?? ''),
                  0,
                ),
              )
            ],
          ),
          WidgetUtl.getVerticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: TitleText(
                  ('Course ID:'),
                  0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: ValueText(
                  (eDetails.courseID ?? ''),
                  0,
                ),
              )
            ],
          ),
          WidgetUtl.getVerticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: TitleText(
                  ('Course Name:'),
                  0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: ValueText(
                  (eDetails.courseName ?? ''),
                  0,
                ),
              )
            ],
          ),
          WidgetUtl.getVerticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: TitleText(
                  ('Institute Name:'),
                  0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: ValueText(
                  (eDetails.instituteName ?? ''),
                  0,
                ),
              )
            ],
          ),
          WidgetUtl.getVerticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: TitleText(
                  ('Institute State:'),
                  0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: ValueText(
                  (eDetails.instituteState ?? ''),
                  0,
                ),
              )
            ],
          ),
          WidgetUtl.getVerticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: TitleText(
                  ('UniversityOrBoard:'),
                  0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: ValueText(
                  (eDetails.universityOrBoard ?? ''),
                  0,
                ),
              )
            ],
          ),
          WidgetUtl.getVerticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: TitleText(
                  ('Score Type:'),
                  0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: ValueText(
                  (eDetails.scoreType ?? ''),
                  0,
                ),
              )
            ],
          ),
          WidgetUtl.getVerticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: TitleText(
                  ('Score Value:'),
                  0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: ValueText(
                  (eDetails.scoreValue ?? ''),
                  0,
                ),
              ),
              WidgetUtl.getVerticalSpace(),
            ],
          ),
        ],
      ),
    );
    return widget;
  }

  Widget _buildForm(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = Responsive.isScreenLarge(_width, _pixelRatio);
    _medium = Responsive.isScreenMedium(_width, _pixelRatio);
    _bottom = MediaQuery.of(context).viewPadding.bottom;
    _top = MediaQuery.of(context).viewPadding.top;
    return SingleChildScrollView(
      child: Column(
        children: [
          Forme(
            autovalidateByOrder: false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: <Widget>[
                  for (var item in loadFormFieldSection())
                    Container(child: item),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(height: 15),
                  _buttonisLoading
                      ? Container(
                          child: Loader(),
                          height: 50,
                        )
                      : routeFromUpdate
                          ? Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: FormeIsValueChangedListener(
                                        builder: (context, isValueChanged) {
                                      return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: secondaryColor),
                                        onPressed: isValueChanged
                                            ? formKey.reset
                                            : null,
                                        child: const Text('Reset'),
                                      );
                                    }),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: FormeValidationListener(
                                        builder: (context, validation, child) {
                                      return ElevatedButton(
                                        onPressed: () {
                                          getUpdatedValueAndSubmit(
                                              context, formKey.value);
                                          _buttonisLoading = true;
                                          setState(() {});
                                        },
                                        child: const Text('Submit'),
                                      );
                                    }),
                                  ),
                                ),
                                const SizedBox(height: 30),
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: FormeIsValueChangedListener(
                                        builder: (context, isValueChanged) {
                                      return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: secondaryColor),
                                        onPressed: isValueChanged
                                            ? formKey.reset
                                            : null,
                                        child: const Text('Reset'),
                                      );
                                    }),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: FormeValidationListener(
                                        builder: (context, validation, child) {
                                      return ElevatedButton(
                                        onPressed: validation.isValid
                                            ? () {
                                                getUpdatedValueAndSubmit(
                                                    context, formKey.value);
                                                _buttonisLoading = true;
                                                setState(() {});
                                              }
                                            : null,
                                        child: const Text('Submit'),
                                      );
                                    }),
                                  ),
                                ),
                                const SizedBox(height: 30),
                              ],
                            ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Future _submit(BuildContext context, Map<String, String> entity) async {
  //   formKey.currentState?.save();
  //   _onLoading(context);
  //   try {
  //     await Provider.of<Auth>(context, listen: false)
  //         .createEmployerEntity(entity)
  //         .then((value) => {
  //               _hideDialog(context),
  //               if (value['success'] == true)
  //                 {
  //                   Fluttertoast.showToast(
  //                       msg: "Employer registred successfully.",
  //                       toastLength: Toast.LENGTH_SHORT,
  //                       gravity: ToastGravity.BOTTOM,
  //                       timeInSecForIosWeb: 1,
  //                       backgroundColor: Colors.black,
  //                       textColor: Colors.white,
  //                       fontSize: 16.0),
  //                   Navigator.of(context).pop()
  //                 }
  //               else
  //                 {
  //                   _showerrorDialog(context, value['result']),
  //                 }
  //             });
  //   } on HttpException catch (e) {
  //     var errorMessage = 'Authentication Failed';
  //     if (e.toString().contains('INVALID_EMAIL')) {
  //       errorMessage = 'Invalid email';
  //       _showerrorDialog(context, errorMessage);
  //     } else if (e.toString().contains('EMAIL_NOT_FOUND')) {
  //       errorMessage = 'This email not found';
  //       _showerrorDialog(context, errorMessage);
  //     } else if (e.toString().contains('INVALID_PASSWORD')) {
  //       errorMessage = 'Invalid Password';
  //       _showerrorDialog(context, errorMessage);
  //     }
  //   } catch (error) {
  //     //var errorMessage = 'Plaese try again later';
  //     _showerrorDialog(context, error.toString());
  //   }
  // }

  void _showerrorDialog(BuildContext dialogContext, String message) {
    showPlatformDialog(
      context: dialogContext,
      builder: (_) => PlatformAlertDialog(
        title: const Text('Alert'),
        content: Text(message),
        actions: <Widget>[
          PlatformDialogAction(
            material: (_, __) => MaterialDialogActionData(),
            cupertino: (_, __) => CupertinoDialogActionData(),
            child: PlatformText('Cancel'),
            onPressed: () => Navigator.pop(dialogContext),
          ),
          PlatformDialogAction(
            child: PlatformText('OK'),
            onPressed: () => Navigator.pop(dialogContext),
          ),
        ],
      ),
    );
  }

  void _onLoading(BuildContext context) {
    showPlatformDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: PlatformCircularProgressIndicator(),
          );
        });
  }

  void _hideDialog(BuildContext context) {
    Navigator.pop(context);
  }
}

class _EligibilityDetails {
  final Widget widget;
  _EligibilityDetails(this.widget);
}

class _QualificationDetails {
  final Widget widget;
  _QualificationDetails(this.widget);
}

class Bottomsheet extends StatefulWidget {
  final List<String> values;
  final selectedvalue;
  final Function(dynamic) onchanged;
  Bottomsheet(
      {Key? key,
      required this.values,
      this.selectedvalue,
      required this.onchanged})
      : super(key: key);

  @override
  State<Bottomsheet> createState() => _BottomsheetState();
}

class _BottomsheetState extends State<Bottomsheet> {
  @override
  void initState() {
    value = widget.selectedvalue;

    values = widget.values;
    super.initState();
  }

  String value = "";
  List<String> values = [];
  @override
  Widget build(BuildContext context) {
    List<Widget> sizelist() {
      List<Widget> products = [];
      for (var i = 0; i < (values.length); i++) {
        products.add(GestureDetector(
          onTap: () {
            value = values[i];

            widget.onchanged(value);

            setState(() {});
            Navigator.pop(context);
          },
          child: Container(
            height: 45,
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey.shade300))),
            padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: Colors.black)),
                      child: value == ""
                          ? Container()
                          : value == values[i]
                              ? Container(
                                  height: 10,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: secondaryColor,
                                  ),
                                )
                              : Container(),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextWidget(
                      text: values[i],
                      color: Colors.black,
                      size: 15,
                    )
                  ],
                ),
                const Spacer(),
                // TextWidget(
                // text: "Just 2 left",
                // size: text_font_size_small,
                // ),
                // Icon(Icons.call_missed_outgoing)
              ],
            ),
          ),
        ));
      }
      return products;
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            color: secondaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: const Icon(
                      Icons.clear,
                      size: 25,
                      color: whiteColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Container(
                  alignment: Alignment.center,
                  child: const TextWidget(
                    text: "Select ...",
                    color: whiteColor,
                    size: 15,
                    weight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 30,
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: sizelist(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
