import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/training_card/home/view/tc_home.dart';
import 'package:airmaster/screens/home/training_card/pilot_crew/view/tc_pilot_crew.dart';
import 'package:airmaster/screens/home/training_card/profile/view/tc_profile.dart';
import 'package:airmaster/screens/home/training_card/training/view/tc_training.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:get/route_manager.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class TCView extends StatefulWidget {
  const TCView({super.key});

  @override
  State<TCView> createState() => _TCViewState();
}
enum MenuItem{
  addNewTraining,
}

class _TCViewState extends State<TCView> {
  late PersistentTabController _controller;
  late bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() => [
    TC_Home(),
    TC_Training(),
    TC_PilotCrew(),
    TC_Profile(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home),
      title: "Home",
      activeColorPrimary: ColorConstants.activeColor,
      inactiveColorPrimary: ColorConstants.inactiveColor,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.list_alt),
      title: "Training",
      activeColorPrimary: ColorConstants.activeColor,
      inactiveColorPrimary: ColorConstants.inactiveColor,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.person_2_fill),
      title: "Pilot Crew",
      activeColorPrimary: ColorConstants.activeColor,
      inactiveColorPrimary: ColorConstants.inactiveColor,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.person_circle_fill),
      title: "Profile",
      activeColorPrimary: ColorConstants.activeColor,
      inactiveColorPrimary: ColorConstants.inactiveColor,
    ),
  ];

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: ColorConstants.primaryColor,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
        onPressed: () => Get.back(),
      ),
      title: Text(
        "Training Card",
        style: GoogleFonts.notoSans(
          color: ColorConstants.textSecondary,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        PopupMenuButton<int>(
          color: ColorConstants.backgroundColor,
          icon: Icon(Icons.more_vert, color: ColorConstants.backgroundColor),
          onSelected: (item) => onSelected(context, item),
          itemBuilder: (context) => [
            PopupMenuItem( 
              value: 0,
              child: Text("Add New Training"),
            ),
          ],
        ),
      ]
    ),
    body: PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: false,
      resizeToAvoidBottomInset: false,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      padding: const EdgeInsets.only(top: 8),
      backgroundColor: ColorConstants.backgroundColor,
      isVisible: !_hideNavBar,
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle: NavBarStyle.style3,
    ),
  );
}

void onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      Get.toNamed(AppRoutes.TC_NEW_TRAINING);
      break;
  }
}