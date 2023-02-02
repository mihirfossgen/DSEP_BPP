import 'dart:convert';

import 'package:dsep_bpp/screens/applied_screen_detail.dart';
import 'package:dsep_bpp/utils/colors_widget.dart';
import 'package:dsep_bpp/widgets/custom_loader.dart';
import 'package:dsep_bpp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import '../provides/ApiServices.dart';

class AppliedScreens extends StatefulWidget {
  const AppliedScreens({Key? key}) : super(key: key);

  @override
  State<AppliedScreens> createState() => _AppliedScreensState();
}

class _AppliedScreensState extends State<AppliedScreens> {
  List response = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    callschemedata();
  }

  void callschemedata() {
    ApiServices().getAppliedSchemes().then((value) {
      setState(() {
        _isLoading = false;

        response = json.decode(value);
      });
    });
  }

  String applicationStatus(String txt) {
    switch (txt) {
      case '0':
        return 'Init';
      case '1':
        return 'Inprogress';
      case '2':
        return 'Awarded';
      case '3':
        return 'Disbursed';
      case '4':
        return 'Closed';
      case '5':
        return 'Rejected';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
          title: const Text('Applied Schemes',
              style: TextStyle(color: Colors.white)),
        ),
        body: _isLoading ? Loader() : _body(screenHeight, screenWidth));
  }

  List<Widget> listOfAppliedSchmes(double h, double w) {
    List<Widget> a = [];
    for (var i = 0; i < response.length; i++) {
      a.add(GestureDetector(
        onTap: () async {
          var data = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AppliedScreenDetails(
                        appId: response[i]['appId'],
                        json: response[i]['applcntDtls'],
                        additionalDetails:
                            jsonDecode(response[i]['addtnlDtls']),
                      )));
          if (data == true) {
            callschemedata();
          }
        },
        child: Container(
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Application ID : ${response[i]['appId']}",
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Applicant Name : ${response[i]['applcntDtls']['person']['name']}",
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Applied Date : ${dateformatter(response[i]['schemeStartDate'])}",
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Scheme Name : ${response[i]['schemeDescription']}",
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              "Scheme ID : ${response[i]['schemeProviderId']}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: w * 0.037,
                                  fontWeight: FontWeight.w500),
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
                              "Application Status: ${applicationStatus(response[i]['appStatus'].toString())}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: w * 0.037,
                                  fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "View Application",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ));
    }
    return a;
  }

  String dateformatter(String dt) {
    DateTime parseDt = DateTime.parse(dt);
    var newFormat = DateFormat("yyyy-MM-dd");
    String updatedDt = newFormat.format(parseDt);
    // 20-
    return updatedDt;
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
