import 'dart:io' show Platform;
import 'package:dsep_bpp/models/create_scheme_model.dart';
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

class AddQualification extends StatefulWidget {
  const AddQualification({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddQualificationState();
}

class _AddQualificationState extends State<AddQualification> {
  final FormeKey formKey = FormeKey();
  int courseDetailsIndex = 0;
  List<PastEducation> details = [];
  var qualificationWidgets = <Widget>[];

  void getUpdatedValueAndSubmitForm(Map<String, dynamic> values) {
    PastEducation education = PastEducation(
        courseID: values['Course ID'],
        courseLevelID: values['Course Level ID'],
        courseLevelName: values['Course Level Name'],
        courseName: values['Course Name'],
        instituteName: values['Institute Name'],
        instituteState: values['Institute State'],
        scoreType: values['Score Type'],
        scoreValue: values['Score Value'],
        universityOrBoard: values['UniversityOrBoard']);
    details.add(education);
    Navigator.pop(context, {'details': details});
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
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: getFormField(),
            // ),
            // const SizedBox(
            //   height: 5,
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
                  child: FormCaptionText('Course Level ID', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomTextField(
                      name: 'Course Level ID',
                      order: 1,
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
                  child: FormCaptionText('Course Level Name', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomDropDown(
                    name: 'Course Level Name',
                    order: 2,
                    hint: '',
                    validator: FormeValidates.notEmpty(errorText: ''),
                    items: const [
                      'Higher Secondary',
                      'Diploma',
                      'Graduate',
                      'Post Graduate'
                    ],
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
                  child: FormCaptionText('Course ID', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomTextField(
                      name: 'Course ID',
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
                  child: FormCaptionText('Course Name', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomTextField(
                      name: 'Course Name',
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
                  child: FormCaptionText('Institute Name', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomTextField(
                      name: 'Institute Name',
                      order: 5,
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
                  child: FormCaptionText('Institute State', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomTextField(
                      name: 'Institute State',
                      order: 6,
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
                  child: FormCaptionText('UniversityOrBoard', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomTextField(
                      name: 'UniversityOrBoard',
                      order: 7,
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
                  child: FormCaptionText('Score Type', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: FormCustomDropDown(
                    name: 'Score Type',
                    order: 8,
                    hint: '',
                    validator: FormeValidates.notEmpty(errorText: ''),
                    items: const [
                      'Percentage',
                      'CGPA',
                    ],
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
                  child: FormCaptionText('Score Value', 0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: FormCustomTextField(
                            name: 'Min Score Value',
                            order: 9,
                            hint: 'Min',
                            validator: FormeValidates.notEmpty(errorText: ''),
                            keyboardType: TextInputType.name,
                            cornerRadius: 15.0,
                            cursorColor: Colors.blue,
                            borderColor: Colors.grey,
                            icon: const ValidationIcon()),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: FormCustomTextField(
                            name: 'Max Score Value',
                            order: 9,
                            hint: 'Max',
                            validator: FormeValidates.notEmpty(errorText: ''),
                            keyboardType: TextInputType.name,
                            cornerRadius: 15.0,
                            cursorColor: Colors.blue,
                            borderColor: Colors.grey,
                            icon: const ValidationIcon()),
                      ),
                    ],
                  ),
                )
              ],
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
    return PlatformScaffold(
      appBar: PlatformAppBar(
        leading: PlatformIconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context, {'details': details}),
        ),
        cupertino: (_, __) => CupertinoNavigationBarData(
          // If this is enabled and set to true then the IconButton above will complain of no parent Material widget
          noMaterialParent: true,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Add Qualification',
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
                                        getUpdatedValueAndSubmitForm(
                                            formKey.value);
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
}

class _CourseDetails {
  final Widget widget;
  final int index;
  _CourseDetails(this.widget, this.index);
}
