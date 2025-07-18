import 'dart:developer';

import 'package:airmaster/data/users/user_preferences.dart';
import 'package:airmaster/screens/home/efb/analytics/view/efb_analytics.dart';
import 'package:airmaster/screens/home/efb/devices/view/efb_device.dart';
import 'package:airmaster/screens/home/efb/history/view/efb_history.dart';
import 'package:airmaster/screens/home/efb/home/view/efb_home.dart';
import 'package:airmaster/screens/home/efb/profile/view/efb_profile.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class EFBView extends StatefulWidget {
  const EFBView({super.key});

  @override
  State<EFBView> createState() => _EFBViewState();
}

class _EFBViewState extends State<EFBView> {
  late PersistentTabController _controller;
  late bool _hideNavBar;
  late String _rank;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
    _rank = '';
    getRank();
  }

  void getRank() async {
    final rank = await UserPreferences().getRank();
    log('Rank: $rank');
    setState(() {
      _rank = rank;
    });
  }

  List<Widget> _buildScreensOCC() => [
    EFB_Home(),
    EFB_Device(),
    EFB_History(),
    EFB_Analytics(),
    EFB_Profile(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItemsOCC() => [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home),
      title: "Home",
      activeColorPrimary: ColorConstants.activeColor,
      inactiveColorPrimary: ColorConstants.inactiveColor,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.device_hub),
      title: "Devices",
      activeColorPrimary: ColorConstants.activeColor,
      inactiveColorPrimary: ColorConstants.inactiveColor,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.history),
      title: "History",
      activeColorPrimary: ColorConstants.activeColor,
      inactiveColorPrimary: ColorConstants.inactiveColor,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.analytics),
      title: "Analytics",
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

  List<Widget> _buildScreensPilot() => [
    EFB_Home(),
    EFB_History(),
    EFB_Profile(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItemsPilot() => [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home),
      title: "Home",
      activeColorPrimary: ColorConstants.activeColor,
      inactiveColorPrimary: ColorConstants.inactiveColor,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.history),
      title: "History",
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
        onPressed: () => log('Rank: ${_rank.toString()}'),
      ),
      title: Text(
        "Electronic Flight Bag",
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
      screens: _rank == 'OCC' ? _buildScreensOCC() : _buildScreensPilot(),
      items: _rank == 'OCC' ? _navBarsItemsOCC() : _navBarsItemsPilot(),
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
