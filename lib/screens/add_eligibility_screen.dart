import 'dart:io' show Platform;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../widgets/form_widgets/validaton_icon.dart';
import '../widgets/form_widgets/form_custom_dropdown.dart';
import '../widgets/form_widgets/form_custom_datepicker.dart';
import './../widgets/form_widgets/form_caption_text.dart';
import '../widgets/form_widgets/form_custom_textfield.dart';
import './add_qualification_screen.dart';
import '../models/create_scheme_model.dart';
import './../widgets/title_text.dart';
import './../widgets/value_text.dart';
import './../widgets/widget_utl.dart';
import '../widgets/responsive_ui.dart';

class AddEligibility extends StatefulWidget {
  const AddEligibility({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddEligibilityState();
}

class _AddEligibilityState extends State<AddEligibility> {
  late double _height;
  late double _width;
  late double _pixelRatio;
  late bool _large;
  late bool _medium;
  late double _bottom;
  late double _top;
  final FormeKey formKey = FormeKey();
  int courseDetailsIndex = 0;
  List<_EligibilityDetails> eligibilityDetailsWidgets = [];
  List<PastEducation> details = [];
  Eligibility eligibility = Eligibility();
  int _index = 0;

  void getUpdatedValueAndSubmitForm(Map<String, dynamic> values) {
    eligibility = Eligibility(
      caste: values['Caste'],
      cityOrBlockOrTaluka: values['CityOrBlockOrTaluka'],
      district: values['District'],
      familyIncome: values['Family Income'],
      gender: values['Gender'],
      nationality: values['Nationality'],
      pastEducation: details,
      religon: values['Religon'],
      state: values['State'],
    );
    Navigator.pop(context, {'details': eligibility});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                  child: FormCaptionText('Gender', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomDropDown(
                      name: 'Gender',
                      order: 6,
                      hint: '',
                      validator: FormeValidates.notEmpty(errorText: ''),
                      items: const [
                        'Male',
                        'Female',
                        'Other',
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
                  child: FormCaptionText('Family Income', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomDropDown(
                      name: 'Family Income',
                      order: 6,
                      hint: '',
                      validator: FormeValidates.notEmpty(errorText: ''),
                      items: const [
                        'less than 100000',
                        '100000 to 500000',
                        'more than 500000',
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
                  child: FormCaptionText('State', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomTextField(
                      name: 'State',
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
                  child: FormCaptionText('District', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomTextField(
                      name: 'District',
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
                  child: FormCaptionText('CityOrBlockOrTaluka', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomTextField(
                      name: 'CityOrBlockOrTaluka',
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
                  child: FormCaptionText('Nationality', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomTextField(
                      name: 'Nationality',
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
                  child: FormCaptionText('Religon', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomTextField(
                      name: 'Religon',
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
                  child: FormCaptionText('Caste', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomTextField(
                      name: 'Caste',
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
            const SizedBox(
              height: 10,
            ),
            Column(
              children: eligibilityDetailsWidgets.map((e) => e.widget).toList(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                onPressed: (() async {
                  Map<String, dynamic> object = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddQualification()),
                  );
                  List<PastEducation> educationDetails = object['details'];
                  if (educationDetails.isNotEmpty) {
                    appendDetails(educationDetails);
                  }
                }),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.add),
                        Text('Add Qualification')
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
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

  InputBorder? getEnabledBorder(FormeFieldValidation? validation,
      {double width = 1}) {
    return (validation?.isInvalid ?? false)
        ? OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).errorColor, width: width),
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = Responsive.isScreenLarge(_width, _pixelRatio);
    _medium = Responsive.isScreenMedium(_width, _pixelRatio);
    _bottom = MediaQuery.of(context).viewPadding.bottom;
    _top = MediaQuery.of(context).viewPadding.top;
    return PlatformScaffold(
      appBar: PlatformAppBar(
        leading: PlatformIconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context, {'details': null}),
        ),
        cupertino: (_, __) => CupertinoNavigationBarData(
          // If this is enabled and set to true then the IconButton above will complain of no parent Material widget
          noMaterialParent: true,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Add Eligibility',
            style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
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
                    const SizedBox(height: 10),
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
                                onPressed:
                                    isValueChanged ? formKey.reset : null,
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
                                        if (details.isNotEmpty) {
                                          getUpdatedValueAndSubmitForm(
                                              formKey.value);
                                        } else {
                                          _showerrorDialog(context,
                                              'Add Qualification details.');
                                        }
                                      }
                                    : null,
                                child: const Text('Submit'),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void appendDetails(List<PastEducation> eDetails) {
    for (var item in eDetails) {
      details.add(item);
    }
    final Widget widget = SizedBox(
      height: 350,
      width: _width / 0.05,
      child: ListView.builder(
          itemCount: details.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12, left: 12),
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
                                  details.remove(details[index]);
                                  courseDetailsIndex = details.length;
                                  print(courseDetailsIndex);
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
                            (details[index].courseLevelID ?? ''),
                            0,
                          ),
                        )
                      ],
                    ),
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
                            (details[index].courseLevelName ?? ''),
                            0,
                          ),
                        )
                      ],
                    ),
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
                            (details[index].courseID ?? ''),
                            0,
                          ),
                        )
                      ],
                    ),
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
                            (details[index].courseName ?? ''),
                            0,
                          ),
                        )
                      ],
                    ),
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
                            (details[index].instituteName ?? ''),
                            0,
                          ),
                        )
                      ],
                    ),
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
                            (details[index].instituteState ?? ''),
                            0,
                          ),
                        )
                      ],
                    ),
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
                            (details[index].universityOrBoard ?? ''),
                            0,
                          ),
                        )
                      ],
                    ),
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
                            (details[index].scoreType ?? ''),
                            0,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 12, bottom: 10),
                          child: TitleText(
                            ('Score Value:'),
                            0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, bottom: 10),
                          child: ValueText(
                            (details[index].scoreValue ?? ''),
                            0,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
    setState(() {
      eligibilityDetailsWidgets = [_EligibilityDetails(widget)];
    });
  }

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
}

class _EligibilityDetails {
  final Widget widget;
  _EligibilityDetails(this.widget);
}
