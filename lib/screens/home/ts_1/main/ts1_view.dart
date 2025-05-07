import "package:airmaster/screens/home/ts_1/analytics/view/ts1_analytics.dart";
import "package:airmaster/screens/home/ts_1/history/view/ts1_history.dart";
import "package:airmaster/screens/home/ts_1/home/view/ts1_home.dart";
import "package:airmaster/screens/home/ts_1/settings/view/ts1_settings.dart";
import "package:airmaster/utils/const_color.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart";

class TS1View extends StatefulWidget {
  const TS1View({super.key});

  @override
  State<TS1View> createState() => _TS1ViewState();
}

BuildContext? testContext;

class _TS1ViewState extends State<TS1View> {
  late PersistentTabController _controller;
  late bool _hideNavBar;

  final List<ScrollController> _scrollControllers = [
    ScrollController(),
    ScrollController(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  @override
  void dispose() {
    for (final element in _scrollControllers) {
      element.dispose();
    }
    super.dispose();
  }

  List<Widget> _buildScreens() => [
    TS1_Home(),
    TS1_Analytics(),
    TS1_History(),
    TS1_Settings(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home),
      title: "Home",
      activeColorPrimary: ColorConstants.primaryColor,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.analytics),
      title: "Analytics",
      activeColorPrimary: ColorConstants.primaryColor,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.history),
      title: "History",
      activeColorPrimary: ColorConstants.primaryColor,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.settings),
      title: "Settings",
      activeColorPrimary: ColorConstants.primaryColor,
      inactiveColorPrimary: Colors.grey,
    ),
  ];

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        "TS - 1",
        style: GoogleFonts.notoSans(
          color: ColorConstants.textPrimary,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    body: PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: false,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.once,
      hideOnScrollSettings: HideOnScrollSettings(
        hideNavBarOnScroll: true,
        scrollControllers: _scrollControllers,
      ),
      padding: const EdgeInsets.only(top: 8),
      selectedTabScreenContext: (final context) {
        testContext = context;
      },
      backgroundColor: ColorConstants.backgroundColor,
      isVisible: !_hideNavBar,
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle: NavBarStyle.style3,
    ),
  );
}
