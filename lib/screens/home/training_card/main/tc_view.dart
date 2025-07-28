// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'dart:developer';

import 'package:airmaster/data/users/user_preferences.dart';
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/training_card/home/home_administrator/view/tc_home_administrator.dart';
import 'package:airmaster/screens/home/training_card/home/home_cpts/view/tc_home_cpts.dart';
import 'package:airmaster/screens/home/training_card/home/home_examinee/view/tc_home_examinee.dart';
import 'package:airmaster/screens/home/training_card/home/home_instructor/view/tc_home_instructor.dart';
import 'package:airmaster/screens/home/training_card/pilot_crew/view/tc_pilot_crew.dart';
import 'package:airmaster/screens/home/training_card/profile/view/tc_profile.dart';
import 'package:airmaster/screens/home/training_card/profile_examinee/view/tc_profile_examinee.dart';
import 'package:airmaster/screens/home/training_card/training/view/tc_training.dart';
import 'package:airmaster/screens/home/training_card/training_list/view/examinee_training_list.dart';
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

enum MenuItem { addNewTraining }

class _TCViewState extends State<TCView> {
  late PersistentTabController _controller;
  late bool _hideNavBar;
  late String type;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
    type = "";
    getType();
  }

  Future<void> getType() async {
    String _type = await UserPreferences().getType();
    log('TYPE: $_type');

    setState(() {
      type = _type;
    });
  }

  List<Widget> _buildScreens_PilotAdministrator() => [
    TC_Home_Administrator(),
    TC_Training(),
    TC_PilotCrew(),
    TC_Profile(),
  ];

  List<Widget> _buildScreens_Instructor() => [
    TC_Home_Instructor(),
    TC_Training(),
    TC_TrainingList(),
    TC_Profile(),
  ];

  List<Widget> _buildScreens_Examinee() => [
    TC_Home_Examinee(),
    TC_TrainingList(),
    TC_ProfileExaminee(),
  ];

  List<Widget> _buildScreens_CPTS() => [
    TC_Home_CPTS(),
    TC_TrainingList(),
    TC_Training(),
    TC_PilotCrew(),
    TC_Profile(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItemsPilotAdministrator() => [
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

  List<PersistentBottomNavBarItem> _navBarsItemsInstructor() => [
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
      icon: const Icon(Icons.checklist_rtl),
      title: "Training List",
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

  List<PersistentBottomNavBarItem> _navBarsItemsExaminee() => [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home),
      title: "Home",
      activeColorPrimary: ColorConstants.activeColor,
      inactiveColorPrimary: ColorConstants.inactiveColor,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.checklist_rtl),
      title: "Training List",
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

  List<PersistentBottomNavBarItem> _navBarsItemsCPTS() => [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home),
      title: "Home",
      activeColorPrimary: ColorConstants.activeColor,
      inactiveColorPrimary: ColorConstants.inactiveColor,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.checklist_rtl),
      title: "Training List",
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
    ),
    body: PersistentTabView(
      context,
      controller: _controller,
      screens:
          type == "Administrator"
              ? _buildScreens_PilotAdministrator()
              : type == "Instructor"
              ? _buildScreens_Instructor()
              : type == "Examinee"
              ? _buildScreens_Examinee()
              : _buildScreens_CPTS(),
      items:
          type == "Administrator"
              ? _navBarsItemsPilotAdministrator()
              : type == "Instructor"
              ? _navBarsItemsInstructor()
              : type == "Examinee"
              ? _navBarsItemsExaminee()
              : _navBarsItemsCPTS(),
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
