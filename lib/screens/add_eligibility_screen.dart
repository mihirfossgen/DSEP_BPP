import 'dart:io' show Platform;

import 'package:dsep_bpp/widgets/text_widget.dart';

import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../widgets/form_widgets/validaton_icon.dart';
import './../widgets/form_widgets/form_caption_text.dart';
import '../widgets/form_widgets/form_custom_textfield.dart';
import '../models/create_scheme_model.dart';
import './../widgets/title_text.dart';
import './../widgets/value_text.dart';
import '../widgets/responsive_ui.dart';

class AddEligibility extends StatefulWidget {
  final String routeFrom;
  var data;
  var spocdata;
  AddEligibility({Key? key, required this.routeFrom, this.spocdata, this.data})
      : super(key: key);

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
  var data;
  var spocData;
  bool routeForUpdate = false;
  static TextEditingController gender = TextEditingController();
  static TextEditingController familyIncome = TextEditingController();
  static TextEditingController courseLevelName = TextEditingController();
  static TextEditingController scoreType = TextEditingController();

  void getUpdatedValueAndSubmitForm(Map<String, dynamic> values) {
    values['Family Income'] = familyIncome.text;
    values['Gender'] = gender.text;
    values['Course Level Name'] = courseLevelName.text;
    values['Score Type'] = scoreType.text;

    eligibility = Eligibility(
        // caste: values['Caste'],
        // cityOrBlockOrTaluka: values['CityOrBlockOrTaluka'],
        // district: values['District'],
        familyIncome: values['Family Income'],
        gender: values['Gender'],
        courseLevelID: values['Course Level ID'],
        courseLevelName: values['Course Level Name'],
        courseName: values['Course Name'],
        scoreType: values['Score Type'],
        scoreValue: values['Min Score Value'],
        spocName: values['Spoc Name'],
        spocEmail: values['Spoc Email'],
        helpdeskNo: values['Help Desk No'],
        passingYear: values['Passing Year']

        // nationality: values['Nationality'],
        //  pastEducation: details,
        // religon: values['Religon'],
        // state: values['State'],
        );
    Navigator.pop(context, {'details': eligibility});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.routeFrom == "update") {
      routeForUpdate = true;
      spocData = widget.spocdata;
      data = widget.data;
      gender.text = data['gender'];
      familyIncome.text = data['familyIncome'] ?? "";
      courseLevelName.text = data['acadDtls'][0]['courseLevelName'];
      scoreType.text = data['acadDtls'][0]['scoreType'];
    }
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
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet<dynamic>(
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext bc) {
                              return Bottomsheet(
                                onchanged: ((value) {
                                  gender.text = value;
                                  //Global.gender.text = gender.text;
                                  setState(() {});
                                }),
                                values: const [
                                  'Male',
                                  'Female',
                                  'Other',
                                ],
                                selectedvalue: gender.text,
                              );
                            });
                      },
                      child: AbsorbPointer(
                          child: TextFormField(
                        controller: gender,
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
                    ))
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
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet<dynamic>(
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext bc) {
                              return Bottomsheet(
                                onchanged: ((value) {
                                  familyIncome.text = value;
                                  // Global.familyIncome.text = value;
                                  setState(() {});
                                }),
                                values: const [
                                  'less than 100000',
                                  '100000 to 500000',
                                  'more than 500000',
                                ],
                                selectedvalue: familyIncome.text,
                              );
                            });
                      },
                      child: AbsorbPointer(
                          child: TextFormField(
                        controller: familyIncome,
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
                    ))
              ],
            ),
            Column(
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
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 10.0, top: 15.0),
                      child: FormCaptionText('Course Level ID', 0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 10.0),
                      child: FormCustomTextField(
                          initalValue: routeForUpdate
                              ? data['acadDtls'][0]['courseLevelID']
                              : "",
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
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 10.0, top: 15.0),
                      child: FormCaptionText('Course Level Name', 0),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet<dynamic>(
                                isScrollControlled: true,
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (BuildContext bc) {
                                  return Bottomsheet(
                                    onchanged: ((value) {
                                      courseLevelName.text = value;
                                      //Global.courseLevelName.text = value;
                                      setState(() {});
                                    }),
                                    values: const [
                                      'Higher Secondary',
                                      'Diploma',
                                      'Graduate',
                                      'Post Graduate'
                                    ],
                                    selectedvalue: courseLevelName.text,
                                  );
                                });
                          },
                          child: AbsorbPointer(
                              child: TextFormField(
                            controller: courseLevelName,
                            decoration: InputDecoration(
                              suffixIcon: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.arrow_drop_down,
                                    color: Colors.black),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              suffixIconConstraints:
                                  const BoxConstraints.tightFor(),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: Colors.blue, width: 0.0)),
                              //hintText: hint,
                            ),
                          )),
                        ))
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 10.0, top: 15.0),
                      child: FormCaptionText('Course Name', 0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 10.0),
                      child: FormCustomTextField(
                          initalValue: routeForUpdate
                              ? data['acadDtls'][0]['courseName']
                              : "",
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
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 10.0, top: 15.0),
                      child: FormCaptionText('Score Type', 0),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet<dynamic>(
                                isScrollControlled: true,
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (BuildContext bc) {
                                  return Bottomsheet(
                                    onchanged: ((value) {
                                      scoreType.text = value;
                                      // Global.scoreType.text = value;
                                      setState(() {});
                                    }),
                                    values: const [
                                      'Percentage',
                                      'CGPA',
                                    ],
                                    selectedvalue: scoreType.text,
                                  );
                                });
                          },
                          child: AbsorbPointer(
                              child: TextFormField(
                            controller: scoreType,
                            decoration: InputDecoration(
                              suffixIcon: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.arrow_drop_down,
                                    color: Colors.black),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              suffixIconConstraints:
                                  const BoxConstraints.tightFor(),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: Colors.blue, width: 0.0)),
                              //hintText: hint,
                            ),
                          )),
                        ))

                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 10.0, right: 10.0, top: 10.0),
                    //   child: FormCustomDropDown(
                    //     name: 'Score Type',
                    //     order: 8,
                    //     hint: routeForUpdate
                    //         ? data['acadDtls'][0]['scoreType']
                    //         : "",
                    //     validator: FormeValidates.notEmpty(errorText: ''),
                    //     items: const [
                    //       'Percentage',
                    //       'CGPA',
                    //     ],
                    //   ),
                    // )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 10.0, top: 15.0),
                      child: FormCaptionText('Score Value', 0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: FormCustomTextField(
                                initalValue: routeForUpdate
                                    ? data['acadDtls'][0]['scoreValue']
                                    : "",
                                name: 'Min Score Value',
                                order: 9,
                                hint: 'Min',
                                validator:
                                    FormeValidates.notEmpty(errorText: ''),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 10.0, top: 15.0),
                      child: FormCaptionText('Passing Year', 0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 10.0),
                      child: FormCustomTextField(
                          initalValue: routeForUpdate
                              ? data['acadDtls'][0]['passingYear']
                              : "",
                          name: 'Passing Year',
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
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 10.0, top: 20.0),
                    child: TextWidget(
                      text: 'Extra Data',
                      size: 25,
                      weight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 10.0, top: 15.0),
                      child: FormCaptionText('Spoc Name', 0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: FormCustomTextField(
                                name: "Spoc Name",
                                order: 4,
                                hint: '',
                                initalValue:
                                    routeForUpdate ? spocData['spocName'] : "",
                                validator:
                                    FormeValidates.notEmpty(errorText: ''),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 10.0, top: 15.0),
                      child: FormCaptionText('Spoc Email', 0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: FormCustomTextField(
                                initalValue:
                                    routeForUpdate ? spocData['spocEmail'] : "",
                                name: 'Spoc Email',
                                order: 4,
                                hint: '',
                                validator:
                                    FormeValidates.notEmpty(errorText: ''),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 10.0, top: 15.0),
                      child: FormCaptionText('Help Desk No', 0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: FormCustomTextField(
                                initalValue: routeForUpdate
                                    ? spocData['helpdeskNo']
                                    : "",
                                name: 'Help Desk No',
                                order: 9,
                                hint: 'Min',
                                validator:
                                    FormeValidates.notEmpty(errorText: ''),
                                keyboardType: TextInputType.number,
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
            const SizedBox(
              height: 10,
            ),
            Column(
              children: eligibilityDetailsWidgets.map((e) => e.widget).toList(),
            ),
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: TextButton(
            //     onPressed: (() async {
            //       Map<String, dynamic> object = await Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const AddQualification()),
            //       );
            //       List<PastEducation> educationDetails = object['details'];
            //       if (educationDetails.isNotEmpty) {
            //         appendDetails(educationDetails);
            //       }
            //     }),
            //     child: Padding(
            //       padding: const EdgeInsets.all(10),
            //       child: Center(
            //         child: Column(
            //           mainAxisSize: MainAxisSize.min,
            //           children: const [
            //             Icon(Icons.add),
            //             Text('Add Qualification')
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
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
                    routeForUpdate
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
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: FormeValidationListener(
                                      builder: (context, validation, child) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        getUpdatedValueAndSubmitForm(
                                            formKey.value);
                                      },
                                      child: const Text('Submit'),
                                    );
                                  }),
                                ),
                              ),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                                    color: Colors.black,
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
            color: Colors.grey[300],
            child: Row(
              children: [
                IconButton(
                    icon: const Icon(
                      Icons.clear,
                      size: 25,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 4,
                      right: MediaQuery.of(context).size.width / 3.6),
                  alignment: Alignment.center,
                  child: const TextWidget(
                    text: "Select ...",
                    color: Colors.black,
                    size: 15,
                    weight: FontWeight.bold,
                  ),
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
