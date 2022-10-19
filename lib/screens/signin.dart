import 'dart:io' show Platform, exit;
import 'package:dsep_bpp/screens/home_screen.dart';
import 'package:dsep_bpp/screens/signup.dart';
import 'package:dsep_bpp/screens/tabbar.dart';
import 'package:dsep_bpp/utils/globals.dart';
import 'package:dsep_bpp/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'dart:async';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../utils/api.dart';
import '../utils/colors_widget.dart';
import '../widgets/responsive_ui.dart';
import '../widgets/text_widget.dart';
import '../widgets/textformfield.dart';
import '../widgets/value_text.dart';
import "package:http/http.dart" as http;

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: const SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late double _height;
  late double _width;
  late double _pixelRatio;
  late bool _large;
  late bool _medium;
  late double _bottom;
  late double _top;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? selectedType;
  late bool visible = false;
  late String formString;
  var ErrorMessage = "";
  var ErrorMessageControler = TextEditingController();
  bool _isloading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              PlatformDialogAction(
                material: (_, __) => MaterialDialogActionData(),
                cupertino: (_, __) => CupertinoDialogActionData(),
                child: PlatformText('yes'),
                onPressed: () => exit(0),
              ),
              PlatformDialogAction(
                child: PlatformText('No'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        )) ??
        false;
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
    final _bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final _topInset = MediaQuery.of(context).viewInsets.top;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: PlatformScaffold(
        body: SafeArea(
          top: true,
          bottom: true,
          child: SizedBox(
            height: _height,
            width: _width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          //padding: EdgeInsets.only(top: _top * 5.5),
                          padding: _large
                              ? EdgeInsets.only(top: _top * 5.5)
                              : _medium
                                  ? (EdgeInsets.only(top: _top * 1.5))
                                  : (EdgeInsets.only(top: _top * 2.5)),
                          child: Image.asset(
                            'assets/images/protean_logo.png',
                            width: _width / 2,
                            height: _width / 4,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 10),
                        welcomeTextRow(),
                        form(context),

                        button(),
                        // Flexible(
                        //   child: SizedBox(
                        //     width: _width,
                        //     height: 100,
                        //     child: Image.asset('assets/images/bottom-bg.png'),
                        //   ),
                        // ),
                        const SizedBox(height: 10),
                        signUp()
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: _bottom),
                    child: const Text(
                      'Powerd by Protean ID',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget welcomeTextRow() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          "Welcome to DSEP Scholarship Discovery BPP App",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: _large ? 25 : (_medium ? 18 : 15),
          ),
        ),
      ),
    );
  }

  Widget form(BuildContext bContext) {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 17.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            textfieldDesign(
                "Username", emailController, Icons.person, bContext),
            SizedBox(
              height: _height * 0.02,
            ),
            textfieldDesign(
                "Password", passwordController, Icons.key, bContext),
            SizedBox(
              height: _height * 0.045,
            ),
          ],
        ),
      ),
    );
  }

  Widget signUp() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextWidget(
            text: "Don't have an account? ",
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SignUpPage()));
            },
            child: const TextWidget(
              text: "Sign up",
              color: primaryColor,
            ),
          )
        ],
      ),
    );
  }

  Widget button() {
    return SizedBox(
      height: _large ? 50 : (_medium ? 50 : 40),
      width: _width / 1.8,
      child: _isloading
          ? Loader()
          : PlatformElevatedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                if (emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  //_submit(uidController.text);
                  var Data = {
                    "userId": emailController.text,
                    "password": passwordController.text
                    //  "userId3":"dsep_bpp_test_0001",
                    //  "password":"test@123"
                  };
                  _isloading = true;
                  setState(() {});
                  validate(Data);
                } else {
                  Fluttertoast.showToast(
                      msg: "Enter Username and password...",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  //_showerrorDialog('Invalid UID');
                }
              },
              padding: const EdgeInsets.all(8),
              child: Text(
                'Login',
                style: TextStyle(fontSize: _large ? 25 : (_medium ? 20 : 15)),
              ),
            ),
    );
  }

  textfieldDesign(
      String hintText, controller, IconData icon, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.7),
      ),
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: ValueText(hintText, 0),
          ),
          const SizedBox(height: 10),
          CustomTextField(
            obscureText: hintText.contains("Password") ? true : false,
            keyboardType: TextInputType.name,
            textEditingController: controller,
          ),
        ],
      ),
    );
  }

  // Future _submit(String uid) async {
  //   _onLoading(context);
  //   try {
  //     await Provider.of<Auth>(context, listen: false)
  //         .submitUidRequest(uid)
  //         .then((value) => {
  //               _hideDialog(context),
  //               if (value['status'] == true)
  //                 {
  //                   Fluttertoast.showToast(
  //                       //msg: value['response']['uidVerificationStatus'],
  //                       msg: 'Check your emailID for Otp',
  //                       toastLength: Toast.LENGTH_SHORT,
  //                       gravity: ToastGravity.BOTTOM,
  //                       timeInSecForIosWeb: 3,
  //                       backgroundColor: Colors.black,
  //                       textColor: Colors.white,
  //                       fontSize: 16.0),
  //                   Navigator.of(context).pushReplacement(MaterialPageRoute(
  //                       builder: (context) => OtpScreen(
  //                             uid: uid,
  //             33333333333333333333333333333333333333333333333333333
  //              )))
  //            3     }
  //          33     else
  //         3        {
  //        3           _showerrorDialog(value['errors']['message'] ??
  //      33                 value['errors']['errorCode'])
  //    33             }
  //   3          });
  // 33  } on HttpException catch (e) {
  //3     _showerrorDialog(e.message);
  //   } catch (error) {
  //     _showerrorDialog(error.toString());
  //   }
  // }

  validate(var Data) async {
    await Future.delayed(Duration(seconds: 2));
    // final catalogJson =3
    //     await rootBundle.33loadString("assets/files/catalog.json");
    try {
      // Api for Login user3name or Password Verification
      var data1 = json.encode(Data);
      Map<String, String> headers1 = {"Content-Type": "application/json"};
      //  "Content-Leng3th": "<calculated when request is sent>",
      //   "Host": "<33calculated when request is sent>",
      //   "User-Age3nt": "PostmanRuntime/7.29.2",
      //   "Accept"3: "*/*",
      //   "Accep33t-Encoding": "gzip, deflate, br",
      //   "Conn3ection": "keep-alive",
      var response = await http.post(Uri.parse(Api.signin),
          body: data1, headers: headers1);
      if (response.statusCode == 200) {
        var resp = jsonDecode(response.body);
        _isloading = false;
        setState(() {});
        print(resp);
        Global.token = resp['token'];
        print(Global.token);
        Fluttertoast.showToast(
                msg: "Logged In SuccessFully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0)
            .then((value) {
          Future.delayed(
            Duration(seconds: 2),
            () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Tabbar()));
            },
          );
        });
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(
            msg: "Incorrect Username Or Password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong please try after sometime",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      //_showerrorDialog('Invalid UID');

    } catch (e) {
      return e.toString();
    }
  }

  void _showerrorDialog(String? message) {
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: const Text('Alert'),
        content: Text(message ?? ''),
        actions: <Widget>[
          PlatformDialogAction(
            material: (_, __) => MaterialDialogActionData(),
            cupertino: (_, __) => CupertinoDialogActionData(),
            child: PlatformText('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          PlatformDialogAction(
            child: PlatformText('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _onLoading(BuildContext context) {
    showDialog(
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
