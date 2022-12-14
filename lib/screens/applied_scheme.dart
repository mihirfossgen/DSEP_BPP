import 'package:dsep_bpp/utils/colors_widget.dart';
import 'package:dsep_bpp/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AppliedScreens extends StatefulWidget {
  const AppliedScreens({Key? key}) : super(key: key);

  @override
  State<AppliedScreens> createState() => _AppliedScreensState();
}

class _AppliedScreensState extends State<AppliedScreens> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            title: const TextWidget(
              text: "Applied Schemes",
              color: whiteColor,
            ),
          ),
          body: _body(screenHeight, screenWidth)),
    );
  }

  List<Widget> listOfAppliedSchmes(double h, double w) {
    List<Widget> a = [];
    for (var i = 0; i < 5; i++) {
      a.add(Container(
        margin: const EdgeInsets.all(20),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(
              color: primaryColor,
              width: 2,
            ),
          ),
          color: Colors.white,
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Text(
                        "Application ID : abc ",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: w * 0.037, fontWeight: FontWeight.w500),
                      )),
                  Expanded(
                      flex: 1,
                      child: Text(
                        "Application Date : 13/12/2022",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: w * 0.037, fontWeight: FontWeight.w500),
                      )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Text(
                        "Scheme Name : abc ",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: w * 0.037, fontWeight: FontWeight.w500),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Text(
                        "Scheme Type : Scholarship",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: w * 0.037, fontWeight: FontWeight.w500),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Text(
                        "Appliaction Status: Applied",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: w * 0.037, fontWeight: FontWeight.w500),
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "View More",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ]),
          ),
        ),
      ));
    }
    return a;
  }

  Widget _body(double h, double w) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
          child: Column(
        children: listOfAppliedSchmes(h, w),
      )),
    );
  }
}
