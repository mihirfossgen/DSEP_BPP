// ignore_for_file: avoid_unnecessary_containers

import 'dart:convert';

import 'package:dsep_bpp/utils/colors_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/text_widget.dart';

class SchemeQuestions extends StatefulWidget {
  const SchemeQuestions({Key? key}) : super(key: key);

  @override
  State<SchemeQuestions> createState() => _SchemeQuestionsState();
}

class _SchemeQuestionsState extends State<SchemeQuestions> {
  int noOfQuestons = 1;
  List fieldsType = [
    {"name": "Text", "key": "text"},
    {"name": "Number", "key": "number"},
    {"name": "File", "key": "file"},
    {"name": "Date", "key": "date"},
    {"name": "Radio Buttons", "key": "radiobuttons"},
    {"name": "Check Boxes", "key": "checkboxes"},
    {"name": "Select", "key": "select"}
  ];
  List<TextEditingController> a = [];
  List<TextEditingController> enteredtitles = [];
  List<TextEditingController> enteredOptions = [];
  // List<TextEditingController> enteredOptions2 = [];
  @override
  void initState() {
    super.initState();
    initalData();
  }

  void initalData() {
    for (var i = 0; i < noOfQuestons; i++) {
      a.add(TextEditingController());
    }
  }

  void addingData() {
    enteredtitles.add(TextEditingController());
  }

  void sendFinaljson() {
    List additionalSchemes = [];
    String name(String txt) {
      //debugPrint(txt);
      switch (txt) {
        case "Text":
          return "txtName";
        case "Number":
          return "txtNumberField";
        case "File":
          return "fileField";
        case "Date":
          return "dateField";
        case "Radio Buttons":
          return "radiobuttons";
        case "Check Boxes":
          return "checkboxes";
        case "Select":
          return "select";
        default:
          {
            return "";
          }
      }
    }

    String type(String txt) {
      //debugPrint(txt);
      switch (txt) {
        case "Text":
          return "text";
        case "Number":
          return "number";
        case "File":
          return "file";
        case "Date":
          return "date";
        case "Radio Buttons":
          return "radiobuttons";
        case "Check Boxes":
          return "checkboxes";
        case "Select":
          return "select";
        default:
          {
            return "";
          }
      }
    }

    optionsData() {
      print("here");
      List options = [];
      List o = [];
      for (var i = 0; i < enteredOptions.length; i++) {
        o = enteredOptions[i].text.split(" ");
      }
      for (var i = 0; i < o.length; i++) {
        options.add({"key": o[i], "value": o[i], "checked": "false", "id": ""});
      }
      return options;
    }

    for (var i = 0; i < noOfQuestons; i++) {
      print(enteredOptions[i].text);

      additionalSchemes.add(
        {
          "id": name(a[i].text),
          "name": name(a[i].text),
          "type": type(a[i].text),
          "title": enteredtitles[i].text,
          "value": "",
          "options": enteredOptions[i].text == "" ? "" : optionsData()
        },
      );
    }
    var json = {"xInput": additionalSchemes};
    debugPrint(jsonEncode(json));
    Navigator.pop(context, json);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
          top: false,
          child: Scaffold(
            bottomNavigationBar: a[0].text == ""
                ? Container(
                    height: 0,
                  )
                : InkWell(
                    onTap: (() {
                      sendFinaljson();
                    }),
                    child: Container(
                      height: 50,
                      width: 200,
                      margin: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                      color: primaryColor,
                      alignment: Alignment.center,
                      child: const TextWidget(
                        text: "Submit",
                        size: 15,
                        color: whiteColor,
                      ),
                    ),
                  ),
            floatingActionButton: a[0].text == ""
                ? Container(
                    height: 0,
                  )
                : FloatingActionButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      noOfQuestons++;
                      initalData();
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
            appBar: AppBar(
              title: const TextWidget(
                text: "Additional Questions",
              ),
            ),
            backgroundColor: whiteColor,
            body: _body(),
          )),
    );
  }

  Widget _body() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(children: [
          _title("Please select questions type and enter their data"),
          Container(
            padding: const EdgeInsets.all(15),
            child: Card(
              elevation: a[0].text == "" ? 0 : 12,
              child: Column(
                children: options(),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  List<Widget> options() {
    List<Widget> _list = [];
    for (var i = 0; i < noOfQuestons; i++) {
      _list.add(Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _title('Select type of question'),
                i == 0
                    ? Container()
                    : Container(
                        height: 40,
                        margin: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              a.remove(TextEditingController());
                              enteredtitles.add(TextEditingController());
                              enteredOptions.add(TextEditingController());
                              //    enteredOptions2.add(TextEditingController());
                              noOfQuestons--;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: SvgPicture.asset('assets/images/delete.svg',
                                height: 30,
                                fit: BoxFit.fill,
                                color: greyColor.shade400),
                          ),
                        ),
                      ),
              ],
            ),
            _bottomSheet(fieldsType, i, (text) {
              enteredtitles.add(TextEditingController());
              enteredOptions.add(TextEditingController());
              //  enteredOptions2.add(TextEditingController());
              setState(() {});
            }),
            a[i].text.contains('Text')
                ? data('Text', i)
                : a[i].text.contains('Number')
                    ? data('Number', i)
                    : a[i].text.contains('File')
                        ? data('File', i)
                        : a[i].text.contains('Date')
                            ? data('Date', i)
                            : a[i].text.contains('Radio Buttons')
                                ? data('Radio Buttons', i)
                                : a[i].text.contains('Check Boxes')
                                    ? data('Check Boxes', i)
                                    : a[i].text.contains('Select')
                                        ? data('Select', i)
                                        : Container(),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ));
    }
    return _list;
  }

  Widget data(String Text, int i) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title("Please enter the title"),
          _textFields(enteredtitles, i),
          if (Text == "Radio Buttons" ||
              Text == "Check Boxes" ||
              Text == "Select")
            _title("Please enter the values"),
          if (Text == "Radio Buttons" ||
              Text == "Check Boxes" ||
              Text == "Select")
            _textFields(enteredOptions, i),
        ],
      ),
    );
  }

  Widget _title(String text) {
    return Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
        child: TextWidget(
          alignment: TextAlign.left,
          text: text,
          size: 15,
          color: Colors.black,
          weight: FontWeight.w600,
        ));
  }

  Widget _textFields(List<TextEditingController> controller, int i) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: TextFormField(
        controller: controller[i],
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.blue, width: 0.0)),
        ),
      ),
    );
  }

  Widget _bottomSheet(List list, int i, Function(String) onchanged) {
    List<String> c = [];
    for (var i = 0; i < list.length; i++) {
      c.add(list[i]['name']);
    }
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
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
                      a[i].text = value;
                      onchanged(value);
                      setState(() {});
                    }),
                    values: c,
                    selectedvalue: a[i].text,
                  );
                });
          },
          child: AbsorbPointer(
              child: TextFormField(
            controller: a[i],
            decoration: InputDecoration(
              suffixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_drop_down, color: Colors.black),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              suffixIconConstraints: const BoxConstraints.tightFor(),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.blue, width: 0.0)),
            ),
          )),
        ));
  }
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
                                      color: secondaryColor),
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
