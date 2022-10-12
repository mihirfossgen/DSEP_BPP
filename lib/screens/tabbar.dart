import 'package:dsep_bpp/screens/home_screen.dart';
import 'package:dsep_bpp/screens/profile.dart';
import 'package:dsep_bpp/utils/colors_widget.dart';
import 'package:dsep_bpp/utils/globals.dart';
import 'package:dsep_bpp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({Key? key}) : super(key: key);

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> with SingleTickerProviderStateMixin {
  late TabController tabController;
  int index = 0;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    tabController.addListener(listener);
    super.initState();
  }

  listener() async {
    if (tabController.indexIsChanging) {
      setState(() {
        index = tabController.index;
      });
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("first_login") != null) {
      Global.isfirstlogin = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('DSEP'),
        ),
        body: index == 0
            ? Global.isfirstlogin
                ? HomePage()
                : ShowCaseWidget(
                    onStart: (index, key) {
                      print('onStart: $index, $key');
                    },
                    onComplete: (index, key) {
                      print('onComplete: $index, $key');
                      if (index == 4) {
                        SystemChrome.setSystemUIOverlayStyle(
                          SystemUiOverlayStyle.light.copyWith(
                            statusBarIconBrightness: Brightness.dark,
                            statusBarColor: Colors.white,
                          ),
                        );
                      }
                    },
                    blurValue: 1,
                    builder: Builder(builder: (context) => HomePage()),
                    autoPlayDelay: const Duration(seconds: 2),
                    autoPlay: true,
                  )
            : Profile(),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: primaryColor,
            border: Border(
              top: BorderSide(
                color: Colors.grey.shade200,
                width: 1.0,
              ),
            ),
          ),
          height: 53,
          child: TabBar(
              labelColor: whiteColor,
              unselectedLabelColor: greyColor.shade300,
              labelPadding: const EdgeInsets.all(0),
              controller: tabController,
              indicatorColor: Colors.transparent,
              tabs: [
                SizedBox(
                    width: 75,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 3, //5,
                        ),
                        SvgPicture.asset('assets/images/home_icon.svg',
                            height: 30,
                            fit: BoxFit.fill,
                            color:
                                index == 0 ? whiteColor : greyColor.shade300),
                        TextWidget(
                          text: "Home",
                          color: index == 0 ? whiteColor : greyColor.shade300,
                        )
                      ],
                    )),
                SizedBox(
                    width: 75,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 3, //5,
                        ),
                        SvgPicture.asset('assets/images/profile_icon.svg',
                            height: 30,
                            fit: BoxFit.fill,
                            color:
                                index == 1 ? whiteColor : greyColor.shade300),
                        TextWidget(
                          text: "Profile",
                          color: index == 1 ? whiteColor : greyColor.shade300,
                        )
                      ],
                    )),
              ]),
        ),
      ),
    );
  }
}