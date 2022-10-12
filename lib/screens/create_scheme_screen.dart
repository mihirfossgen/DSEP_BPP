import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:sticky_headers/sticky_headers.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:forme/forme.dart';
import '../screens/add_eligibility_screen.dart';
import '../widgets/form_widgets/validaton_icon.dart';
import '../widgets/form_widgets/form_custom_datepicker.dart';
import '../widgets/form_widgets/form_custom_textfield.dart';
import '../widgets/form_widgets/form_custom_dropdown.dart';
import './../widgets/form_widgets/form_caption_text.dart';
import '../models/create_scheme_model.dart';
import './../widgets/title_text.dart';
import './../widgets/value_text.dart';
import './../widgets/widget_utl.dart';
import '../widgets/responsive_ui.dart';

class CreateScheme extends StatefulWidget {
  const CreateScheme({Key? key}) : super(key: key);

  @override
  _CreateSchemeState createState() => _CreateSchemeState();
}

class _CreateSchemeState extends State<CreateScheme> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //qualificationCriteriaWidgets.add(addQualificationCriteria());
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
        child: _buildForm(context),
      ),
    );
  }

  void getUpdatedValueAndSubmit(
      BuildContext context, Map<String, dynamic> values) {
    String Scheme_ID = values["Scheme ID"];
    String Scheme_Name = values["Scheme Name"] as String;
    String Scheme_Description = values["Scheme Description"] as String;
    String Scheme_Provider_ID = values["Scheme Provider ID"] as String;
    String Scheme_Provider_Name = values["Scheme Provider Name"] as String;
    String Scheme_Provider_Description =
        values["Scheme Provider Description"] as String;
    String Scheme_Type = values["Scheme Type"] as String;
    String Financial_Year = values["Financial Year"] as String;
    String Scheme_For = values["Scheme For"] as String;
    String Scheme_Amount = values["Scheme Amount"] as String;
    String Start_date = values["Start date"].toString();
    String End_date = values["End date"].toString();
    schemeValue = {
      'Scheme ID': Scheme_ID,
      'Scheme Name': Scheme_Name,
      'Scheme Description': Scheme_Description,
      'Scheme Provider ID': Scheme_Provider_ID,
      'Scheme Provider Name': Scheme_Provider_Name,
      'Scheme Provider Description': Scheme_Provider_Description,
      'Scheme Type': Scheme_Type,
      'Financial Year': Financial_Year,
      'Scheme For': Scheme_For,
      'Scheme Amount': Scheme_Amount,
      'Start date': Start_date,
      'End date': End_date
    };
    //  _submit(context, schemeValue);
  }

  List<Widget> loadFormFieldSection() {
    final children = <Widget>[];
    Widget widget = Container(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 12,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
                  child: FormCaptionText('Scheme ID', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomTextField(
                      name: 'Scheme ID',
                      order: 1,
                      hint: '',
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
                      validator: FormeValidates.notEmpty(errorText: ''),
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
                  child: FormCaptionText('Scheme Provider ID', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomTextField(
                      name: 'Scheme Provider ID',
                      order: 1,
                      hint: '',
                      validator: FormeValidates.notEmpty(
                          errorText: 'Scheme provider ID is required'),
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
                  child: FormCaptionText('Scheme Provider Name', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomTextField(
                      name: 'Scheme Provider Name',
                      order: 2,
                      hint: '',
                      validator: FormeValidates.notEmpty(
                          errorText: 'Scheme Provider Name is required'),
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
                  child: FormCaptionText('Scheme Provider Description', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomTextField(
                      name: 'Scheme Provider Description',
                      order: 3,
                      hint: '',
                      validator: FormeValidates.notEmpty(errorText: ''),
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
                  child: FormCaptionText('Scheme Type', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomDropDown(
                      name: 'Scheme Type',
                      order: 2,
                      hint: '',
                      validator: FormeValidates.notEmpty(
                          errorText: 'Scheme Type is required'),
                      items: const ['Scholarship', 'Grant']),
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
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomTextField(
                      name: 'Financial Year',
                      order: 4,
                      hint: '',
                      validator: FormeValidates.notEmpty(errorText: ''),
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
                  child: FormCaptionText('Scheme For', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomDropDown(
                      name: 'Scheme For',
                      order: 5,
                      hint: '',
                      validator: FormeValidates.notEmpty(
                          errorText: ' Scheme For is required'),
                      items: const [
                        'Under Graduate',
                        'Post Graduate',
                        'Phd',
                        'Professional/Skill Course'
                      ]),
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
                      name: 'Start date',
                      order: 7,
                      hint: '',
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
                      name: 'End date',
                      order: 7,
                      hint: '',
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
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
                                      builder: (context) =>
                                          const AddEligibility()),
                                );
                                Eligibility details = object['details'];
                                appendDetails(details);
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
      final Widget widget = Center(
        child: StickyHeader(
          header: Container(
            height: 50.0,
            color: Colors.blueGrey[700],
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
              _isPastEducationAdded
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 340,
                        width: _width / 0.05,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              for (var item
                                  in eligibilityDetails.pastEducation ?? [])
                                Container(
                                    child: appendQualificaionDetails(item)),
                            ]),
                      ),
                    )
                  : const SizedBox(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: TitleText(
                      ('State:'),
                      0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: ValueText(
                      (eligibilityDetails.state ?? ''),
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
                      ('District:'),
                      0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: ValueText(
                      (eligibilityDetails.district ?? ''),
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
                      ('CityOrBlockOrTaluka:'),
                      0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: ValueText(
                      (eligibilityDetails.cityOrBlockOrTaluka ?? ''),
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
                      ('Nationality:'),
                      0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: ValueText(
                      (eligibilityDetails.nationality ?? ''),
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
                      ('Religon:'),
                      0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: ValueText(
                      (eligibilityDetails.religon ?? ''),
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
                      ('Caste:'),
                      0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: ValueText(
                      (eligibilityDetails.caste ?? ''),
                      0,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
      setState(() {
        _isEligibilityAdded = true;
        eligibilityDetailsWidgets.add(_EligibilityDetails(widget));
      });
    }
  }

  Widget appendQualificaionDetails(PastEducation eDetails) {
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
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: FormeIsValueChangedListener(
                              builder: (context, isValueChanged) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.orangeAccent),
                              onPressed: isValueChanged ? formKey.reset : null,
                              child: const Text('Reset'),
                            );
                          }),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: FormeValidationListener(
                              builder: (context, validation, child) {
                            return ElevatedButton(
                              onPressed: validation.isValid
                                  ? () {
                                      getUpdatedValueAndSubmit(
                                          context, formKey.value);
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
