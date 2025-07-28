// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:airmaster/screens/home/training_card/home/home_cpts/controller/tc_home_cpts_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:airmaster/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart' as fl;
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TC_Home_CPTS extends GetView<TC_Home_CPTS_Controller> {
  const TC_Home_CPTS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: LoadingAnimationWidget.hexagonDots(color: ColorConstants.primaryColor, size: 48))
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                Card(
                  color: ColorConstants.cardColorPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      SizeConstant.BORDER_RADIUS,
                    ),
                  ),
                  elevation: SizeConstant.CARD_ELEVATION,
                  shadowColor: ColorConstants.shadowColor,
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(SizeConstant.PADDING),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                controller.imgUrl.value.isNotEmpty
                                    ? NetworkImage(controller.imgUrl.value)
                                    : AssetImage(
                                          'assets/images/default_picture.png',
                                        )
                                        as ImageProvider,
                          ),

                          const SizedBox(width: SizeConstant.SIZED_BOX_WIDTH),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hello, ${controller.name.value}",
                                  style: GoogleFonts.notoSans(
                                    color: ColorConstants.textSecondary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Text(
                                  'Good ${controller.greetings.value}',
                                  style: GoogleFonts.notoSans(
                                    color: ColorConstants.textSecondary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  DateFormatter.convertDateTimeDisplay(
                                    DateTime.now().toString(),
                                    "EEEE",
                                  ),
                                  style: GoogleFonts.notoSans(
                                    color: ColorConstants.textSecondary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  DateFormatter.convertDateTimeDisplay(
                                    DateTime.now().toString(),
                                    "dd MMMM yyyy",
                                  ),
                                  style: GoogleFonts.notoSans(
                                    color: ColorConstants.textSecondary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                Column(
                  children: [
                    Center(
                      child: Text(
                        'STATS',
                        style: GoogleFonts.poppins(
                          color: ColorConstants.textPrimary,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(color: Colors.red, thickness: 2),
                    const SizedBox(height: 15),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 120,
                              child: Divider(color: Colors.red, thickness: 1),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  'Trainings',
                                  style: GoogleFonts.notoSans(
                                    color: ColorConstants.textPrimary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: Divider(color: Colors.red, thickness: 1),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //SUBJECT TRAININGS
                            Expanded(
                              child: SizedBox(
                                height: 140,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: ColorConstants.primaryColor,
                                      width: 1,
                                    ),
                                  ),
                                  color:
                                      ColorConstants.backgroundColorSecondary,
                                  surfaceTintColor: Colors.white,
                                  shadowColor: Colors.white,
                                  elevation: 5,
                                  child: InkWell(
                                    onTap: () {},
                                    splashColor: ColorConstants.primaryColor,
                                    child: Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 10,
                                        ),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              "assets/images/trainings_logo.png",
                                              fit: BoxFit.fitWidth,
                                            ),
                                            Obx(
                                              () => Text(
                                                '${controller.trainingCount.value}',
                                                style: GoogleFonts.notoSans(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      ColorConstants
                                                          .textPrimary,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Subject Trainings',
                                              style: TextStyle(
                                                color:
                                                    ColorConstants
                                                        .borderColorSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //ONGOING TRAININGS
                            Expanded(
                              child: SizedBox(
                                height: 140,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color:
                                          ColorConstants.borderColorSecondary,
                                      width: 1,
                                    ),
                                  ),
                                  color: ColorConstants.activeColor,
                                  surfaceTintColor: Colors.white,
                                  shadowColor: Colors.white,
                                  elevation: 5,
                                  child: InkWell(
                                    onTap: () {},
                                    splashColor:
                                        ColorConstants.cardColorPrimary,
                                    child: Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 10,
                                        ),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              "assets/images/on_going_training_logo.png",
                                              fit: BoxFit.fitWidth,
                                            ),
                                            Obx(
                                              () => Text(
                                                '${controller.ongoingTrainingCount.value}',
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      ColorConstants
                                                          .textPrimary,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Ongoing Trainings',
                                              style: TextStyle(
                                                color:
                                                    ColorConstants.primaryColor,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 25),

                        Column(
                          children: [
                            const Row(
                              children: [
                                SizedBox(
                                  width: 80,
                                  child: Divider(
                                    color: Colors.red,
                                    thickness: 1,
                                  ),
                                ),
                                Expanded(
                                  flex: 1, // Atur flex ke 3 untuk teks
                                  child: Center(
                                    child: Text(
                                      'Instructor vs Pilot',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                  child: Divider(
                                    color: Colors.red,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Obx(() {
                              final int instructor =
                                  controller.instructorCount.value;
                              final int pilot = controller.pilotCount.value;
                              final int total = instructor + pilot;
                              final int touched =
                                  controller.touchedIndexPilot.value;

                              final double instructorValue =
                                  total == 0 ? 0 : instructor / total;
                              final double pilotValue =
                                  total == 0 ? 0 : pilot / total;

                              final String instructorLabel =
                                  total == 0
                                      ? '0%'
                                      : '${(instructor * 100 / total).toStringAsFixed(1)}%';
                              final String pilotLabel =
                                  total == 0
                                      ? '0%'
                                      : '${(pilot * 100 / total).toStringAsFixed(1)}%';

                              return SizedBox(
                                height: 150,
                                child: Stack(
                                  children: [
                                    fl.PieChart(
                                      fl.PieChartData(
                                        sections: [
                                          fl.PieChartSectionData(
                                            value: instructorValue,
                                            color: const Color(0xffF24C3D),
                                            title: instructorLabel,
                                            radius:
                                                touched == 0
                                                    ? 60
                                                    : 50, // efek tap
                                            titleStyle: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            badgeWidget:
                                                touched == 0
                                                    ? Text(
                                                      '$instructor people',
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                    : null,
                                            badgePositionPercentageOffset: 1.5,
                                          ),
                                          fl.PieChartSectionData(
                                            value: pilotValue,
                                            color: const Color(0xff35A29F),
                                            title: pilotLabel,
                                            radius:
                                                touched == 1
                                                    ? 60
                                                    : 50, // efek tap
                                            titleStyle: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            badgeWidget:
                                                touched == 1
                                                    ? Text(
                                                      '$pilot people',
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                    : null,
                                            badgePositionPercentageOffset: 1.5,
                                          ),
                                        ],
                                        sectionsSpace: 3,
                                        centerSpaceRadius: 30,
                                        pieTouchData: fl.PieTouchData(
                                          touchCallback: (event, response) {
                                            if (response == null ||
                                                response.touchedSection ==
                                                    null) {
                                              return;
                                            }

                                            // Saat tap up / long press end, simpan index-nya secara tetap
                                            if (event is fl.FlTapUpEvent ||
                                                event is fl.FlLongPressEnd) {
                                              controller
                                                  .touchedIndexPilot
                                                  .value = response
                                                      .touchedSection!
                                                      .touchedSectionIndex;
                                            }
                                          },
                                        ),
                                      ),
                                    ),

                                    //DESCRIPTION
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Desc:',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 10,
                                              height: 10,
                                              color: const Color(0xffF24C3D),
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              'Instructors',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffF24C3D),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 10,
                                              height: 10,
                                              color: const Color(0xff35A29F),
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              'Pilots',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff35A29F),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                // Card for "CCP", "FIA", "FIS", "PGI"
                                Expanded(
                                  child: SizedBox(
                                    height: 105, // Set the desired height
                                    child: Card(
                                      elevation: 5,
                                      // color: Colors.green,
                                      color: const Color(0xFFEEEEEE),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text(
                                                'Instructor Categories',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.redAccent[700],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            // Display counts for "CCP", "FIA", "FIS", "GI"
                                            Obx(
                                              () => Text(
                                                'CCP : ${controller.ccpCount}',
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Obx(
                                              () => Text(
                                                'FIA   : ${controller.fiaCount}',
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Obx(
                                              () => Text(
                                                'FIS   : ${controller.fisCount}',
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Obx(
                                              () => Text(
                                                'GI     : ${controller.giCount}',
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Card for "CAPT" and "FO"
                                Expanded(
                                  child: SizedBox(
                                    height: 105, // Set the desired height
                                    child: Card(
                                      elevation: 5,
                                      // color: Colors.green,
                                      color: const Color(0xFFEEEEEE),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text(
                                                'Rank Categories',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.redAccent[700],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 5),

                                            // Display counts for "CAPT" and "FO"
                                            Obx(
                                              () => Text(
                                                'CAPT : ${controller.captCount.value}',
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Obx(
                                              () => Text(
                                                'FO       : ${controller.foCount.value}',
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 35),

                            Column(
                              children: [
                                const Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Divider(
                                        color: Colors.red,
                                        thickness: 1,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          'Attendance',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Divider(
                                        color: Colors.red,
                                        thickness: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                //FILTER
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.filter_list),
                                      onPressed: () {
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          backgroundColor: Colors.white,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadiusDirectional.only(
                                                  topEnd: Radius.circular(25),
                                                  topStart: Radius.circular(25),
                                                ),
                                          ),
                                          builder:
                                              (
                                                context,
                                              ) => SingleChildScrollView(
                                                padding:
                                                    const EdgeInsetsDirectional.only(
                                                      start: 20,
                                                      end: 20,
                                                      bottom: 30,
                                                      top: 8,
                                                    ),
                                                child: Wrap(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        bottom:
                                                            MediaQuery.of(
                                                              context,
                                                            ).viewInsets.bottom,
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          const Text(
                                                            'Filter',
                                                            style: TextStyle(
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          //DROPDOWN
                                                          const Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Please choose the training subject',
                                                                style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                  3.0,
                                                                ),
                                                            child: InputDecorator(
                                                              decoration: InputDecoration(
                                                                border: OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                    color:
                                                                        ColorConstants
                                                                            .successColor,
                                                                  ),
                                                                ),
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          8,
                                                                    ),
                                                                labelStyle:
                                                                    TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color:
                                                                          Colors
                                                                              .black,
                                                                    ),
                                                              ),
                                                              child: Obx(() {
                                                                List<String>
                                                                subjects =
                                                                    controller
                                                                        .trainingList
                                                                        .cast<
                                                                          String
                                                                        >();

                                                                return DropdownButtonHideUnderline(
                                                                  child: DropdownButton<
                                                                    String
                                                                  >(
                                                                    isExpanded:
                                                                        true,
                                                                    value:
                                                                        controller
                                                                            .selectedSubject
                                                                            .value,
                                                                    icon: const Icon(
                                                                      Icons
                                                                          .arrow_drop_down,
                                                                      size: 24,
                                                                    ),
                                                                    dropdownColor:
                                                                        ColorConstants
                                                                            .backgroundColor,
                                                                    items:
                                                                        subjects.map((
                                                                          String
                                                                          subject,
                                                                        ) {
                                                                          return DropdownMenuItem<
                                                                            String
                                                                          >(
                                                                            value:
                                                                                subject,
                                                                            child: Text(
                                                                              subject,
                                                                            ),
                                                                          );
                                                                        }).toList(),
                                                                    onChanged: (
                                                                      String?
                                                                      newValue,
                                                                    ) {
                                                                      controller.updateSelectedSubject(
                                                                        newValue ??
                                                                            'ALL',
                                                                      );
                                                                      controller
                                                                          .training
                                                                          .value = newValue ??
                                                                          'ALL';
                                                                    },
                                                                  ),
                                                                );
                                                              }),
                                                            ),
                                                          ),

                                                          const SizedBox(
                                                            height: 30,
                                                          ),
                                                          //DATE FILTER
                                                          const Row(
                                                            children: [
                                                              Text(
                                                                'Please pick date range',
                                                                style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      Colors
                                                                          .black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Form(
                                                            key:
                                                                controller
                                                                    .formKey,
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  flex: 3,
                                                                  child: TextFormField(
                                                                    controller:
                                                                        controller
                                                                            .fromC,
                                                                    obscureText:
                                                                        false,
                                                                    readOnly:
                                                                        true,
                                                                    decoration: InputDecoration(
                                                                      contentPadding: const EdgeInsets.symmetric(
                                                                        vertical:
                                                                            0,
                                                                        horizontal:
                                                                            10,
                                                                      ),
                                                                      prefixIcon: Icon(
                                                                        Icons
                                                                            .calendar_month,
                                                                        color:
                                                                            ColorConstants.sliderActiveColor,
                                                                      ),
                                                                      enabledBorder: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                          color:
                                                                              ColorConstants.activeColor,
                                                                        ),
                                                                      ),
                                                                      border: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                          color:
                                                                              ColorConstants.sliderActiveColorSecondary,
                                                                        ),
                                                                      ),
                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                          color:
                                                                              Colors.green,
                                                                        ),
                                                                      ),
                                                                      labelText:
                                                                          "From Date",
                                                                    ),
                                                                    onTap: () async {
                                                                      DateTime?
                                                                      pickedDate = await showDatePicker(
                                                                        context:
                                                                            context,
                                                                        initialDate:
                                                                            DateTime.now(),
                                                                        firstDate:
                                                                            DateTime(
                                                                              1945,
                                                                            ),
                                                                        lastDate:
                                                                            DateTime(
                                                                              2300,
                                                                            ),
                                                                        builder: (
                                                                          BuildContext
                                                                          context,
                                                                          Widget?
                                                                          child,
                                                                        ) {
                                                                          return Theme(
                                                                            data: ThemeData.light().copyWith(
                                                                              primaryColor:
                                                                                  Colors.green, // warna header & active date
                                                                              colorScheme: ColorScheme.light(
                                                                                primary:
                                                                                    ColorConstants.primaryColor, // warna header & active date
                                                                                onPrimary:
                                                                                    ColorConstants.whiteColor, // warna teks di header
                                                                                surface:
                                                                                    ColorConstants.backgroundColorSecondary, // background date picker
                                                                                onSurface:
                                                                                    ColorConstants.blackColor, // warna teks di body
                                                                              ),
                                                                              dialogBackgroundColor:
                                                                                  Colors.grey[100], // background keseluruhan
                                                                            ),
                                                                            child:
                                                                                child!,
                                                                          );
                                                                        },
                                                                      );
                                                                      if (pickedDate !=
                                                                          null) {
                                                                        String
                                                                        formattedDate = DateFormat(
                                                                          'dd-MM-yyyy',
                                                                        ).format(
                                                                          pickedDate,
                                                                        );
                                                                        controller
                                                                            .fromC
                                                                            .text = formattedDate;
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                                const Expanded(
                                                                  flex: 1,
                                                                  child: Icon(
                                                                    Icons
                                                                        .compare_arrows_rounded,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 3,
                                                                  child: TextFormField(
                                                                    controller:
                                                                        controller
                                                                            .toC,
                                                                    obscureText:
                                                                        false,
                                                                    readOnly:
                                                                        true,
                                                                    decoration: InputDecoration(
                                                                      contentPadding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            0,
                                                                        horizontal:
                                                                            10,
                                                                      ),
                                                                      prefixIcon: Icon(
                                                                        Icons
                                                                            .calendar_month,
                                                                        color:
                                                                            ColorConstants.primaryColor,
                                                                      ),
                                                                      enabledBorder: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                          color:
                                                                              ColorConstants.primaryColor,
                                                                        ),
                                                                      ),
                                                                      border: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                          color:
                                                                              ColorConstants.backgroundColor,
                                                                        ),
                                                                      ),
                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                          color:
                                                                              Colors.green,
                                                                        ),
                                                                      ),
                                                                      labelText:
                                                                          "To Date",
                                                                    ),
                                                                    onTap: () async {
                                                                      DateTime?
                                                                      pickedDate = await showDatePicker(
                                                                        context:
                                                                            context,
                                                                        initialDate:
                                                                            DateTime.now(),
                                                                        firstDate:
                                                                            DateTime(
                                                                              1945,
                                                                            ),
                                                                        lastDate:
                                                                            DateTime(
                                                                              2300,
                                                                            ),
                                                                        builder: (
                                                                          BuildContext
                                                                          context,
                                                                          Widget?
                                                                          child,
                                                                        ) {
                                                                          return Theme(
                                                                            data: ThemeData.light().copyWith(
                                                                              primaryColor:
                                                                                  ColorConstants.successColor, // warna header & active date
                                                                              colorScheme: ColorScheme.light(
                                                                                primary:
                                                                                    ColorConstants.primaryColor, // warna header & active date
                                                                                onPrimary:
                                                                                    ColorConstants.whiteColor, // warna teks di header
                                                                                surface:
                                                                                    ColorConstants.backgroundColorSecondary, // background date picker
                                                                                onSurface:
                                                                                    ColorConstants.blackColor, // warna teks di body
                                                                              ),
                                                                              dialogBackgroundColor:
                                                                                  Colors.grey[100], // background keseluruhan
                                                                            ),
                                                                            child:
                                                                                child!,
                                                                          );
                                                                        },
                                                                      );
                                                                      if (pickedDate !=
                                                                          null) {
                                                                        String
                                                                        formattedDate = DateFormat(
                                                                          'dd-MM-yyyy',
                                                                        ).format(
                                                                          pickedDate,
                                                                        );
                                                                        controller
                                                                            .toC
                                                                            .text = formattedDate;
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Align(
                                                            alignment:
                                                                Alignment
                                                                    .bottomCenter,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    controller
                                                                        .resetDate();
                                                                    Navigator.of(
                                                                      context,
                                                                    ).pop();
                                                                  },
                                                                  child: Container(
                                                                    padding: const EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          40,
                                                                      vertical:
                                                                          10,
                                                                    ),
                                                                    decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            10.0,
                                                                          ),
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Colors.grey.withOpacity(
                                                                            0.3,
                                                                          ),
                                                                          spreadRadius:
                                                                              2,
                                                                          blurRadius:
                                                                              3,
                                                                          offset: const Offset(
                                                                            0,
                                                                            2,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child: const Text(
                                                                      "Reset",
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color:
                                                                            Colors.red,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    if (controller.formKey.currentState !=
                                                                            null &&
                                                                        controller.formKey.currentState!.validate() !=
                                                                            false) {
                                                                      if (controller
                                                                              .fromC
                                                                              .text
                                                                              .isNotEmpty &&
                                                                          controller
                                                                              .toC
                                                                              .text
                                                                              .isNotEmpty) {
                                                                        // Pastikan parse sekali, konsisten!
                                                                        DateTime
                                                                        from = DateFormat(
                                                                          'dd-MM-yyyy',
                                                                        ).parse(
                                                                          controller
                                                                              .fromC
                                                                              .text
                                                                              .trim(),
                                                                        );
                                                                        DateTime
                                                                        to = DateFormat(
                                                                          'dd-MM-yyyy',
                                                                        ).parse(
                                                                          controller
                                                                              .toC
                                                                              .text
                                                                              .trim(),
                                                                        );

                                                                        if (from
                                                                            .isBefore(
                                                                              to,
                                                                            )) {
                                                                          controller
                                                                              .from
                                                                              .value = from;
                                                                          controller
                                                                              .to
                                                                              .value = to;

                                                                          log(
                                                                            "training Type: ${controller.training.value}",
                                                                          );
                                                                          log(
                                                                            "from: ${controller.fromC.text}",
                                                                          );
                                                                          log(
                                                                            "to: ${controller.toC.text}",
                                                                          );

                                                                          controller.fetchAttendanceData(
                                                                            trainingType:
                                                                                controller.training.value,
                                                                            from:
                                                                                from, // ← PAKAI YANG UDAH DIPARSE
                                                                            to:
                                                                                to, // ← PAKAI YANG UDAH DIPARSE
                                                                          );

                                                                          Navigator.of(
                                                                            context,
                                                                          ).pop();
                                                                        } else {
                                                                          // Bisa kasih feedback kalau dari > to
                                                                        }
                                                                      }
                                                                    }
                                                                  },

                                                                  child: Container(
                                                                    padding: const EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          40,
                                                                      vertical:
                                                                          10,
                                                                    ),
                                                                    decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            10.0,
                                                                          ),
                                                                      color:
                                                                          ColorConstants
                                                                              .activeColor,
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Colors.grey.withOpacity(
                                                                            0.3,
                                                                          ),
                                                                          spreadRadius:
                                                                              2,
                                                                          blurRadius:
                                                                              3,
                                                                          offset: const Offset(
                                                                            0,
                                                                            2,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child: const Text(
                                                                      "Apply",
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color:
                                                                            Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                        );
                                      },
                                    ),
                                  ],
                                ),

                                Center(
                                  child: Obx(() {
                                    final int absent =
                                        controller.absentCount.value;
                                    final int present =
                                        controller.presentCount.value;
                                    final int total = absent + present;
                                    final int touched =
                                        controller.touchedIndexAttendance.value;

                                    final double absentValue =
                                        total == 0 ? 0 : absent / total;
                                    final double presentValue =
                                        total == 0 ? 0 : present / total;

                                    final String absentLabel =
                                        total == 0
                                            ? '0%'
                                            : '${(absent * 100 / total).toStringAsFixed(1)}%';
                                    final String presentLabel =
                                        total == 0
                                            ? '0%'
                                            : '${(present * 100 / total).toStringAsFixed(1)}%';
                                    log(
                                      "Training Type 2: ${controller.training.value}",
                                    );
                                    log(
                                      "From Date 2: ${controller.from.value}",
                                    );
                                    log("To Date 2: ${controller.to.value}");
                                    return FutureBuilder<void>(
                                      future: controller.attendanceFuture,
                                      builder: (
                                        BuildContext context,
                                        AsyncSnapshot<void> snapshot,
                                      ) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }

                                        if (snapshot.hasError) {
                                          return const Center(
                                            child: Text('An error occurred'),
                                          );
                                        }
                                        if (controller.presentCount.value ==
                                                0 &&
                                            controller.absentCount.value == 0) {
                                          return const Center(
                                            child: Text(
                                              'No attendance data available',
                                            ),
                                          );
                                        }

                                        // Check if the data has been fetched and processed
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return SizedBox(
                                            height: 180,
                                            child: Stack(
                                              children: [
                                                fl.PieChart(
                                                  fl.PieChartData(
                                                    sections: [
                                                      fl.PieChartSectionData(
                                                        value: absentValue,
                                                        color: const Color(
                                                          0xffF24C3D,
                                                        ),
                                                        title: absentLabel,
                                                        radius:
                                                            touched == 0
                                                                ? 60
                                                                : 50, // efek tap
                                                        titleStyle:
                                                            const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                        badgeWidget:
                                                            touched == 0
                                                                ? Text(
                                                                  '$absent people',
                                                                  style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                )
                                                                : null,
                                                        badgePositionPercentageOffset:
                                                            1.5,
                                                      ),
                                                      fl.PieChartSectionData(
                                                        value: presentValue,
                                                        color: const Color(
                                                          0xff35A29F,
                                                        ),
                                                        title: presentLabel,
                                                        radius:
                                                            touched == 1
                                                                ? 60
                                                                : 50, // efek tap
                                                        titleStyle:
                                                            const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                        badgeWidget:
                                                            touched == 1
                                                                ? Text(
                                                                  '$present people',
                                                                  style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                )
                                                                : null,
                                                        badgePositionPercentageOffset:
                                                            1.5,
                                                      ),
                                                    ],
                                                    sectionsSpace: 3,
                                                    centerSpaceRadius: 30,
                                                    pieTouchData: fl.PieTouchData(
                                                      touchCallback: (
                                                        event,
                                                        response,
                                                      ) {
                                                        if (response == null ||
                                                            response.touchedSection ==
                                                                null) {
                                                          return;
                                                        }

                                                        // Saat tap up / long press end, simpan index-nya secara tetap
                                                        if (event
                                                                is fl.FlTapUpEvent ||
                                                            event
                                                                is fl.FlLongPressEnd) {
                                                          controller
                                                              .touchedIndexAttendance
                                                              .value = response
                                                                  .touchedSection!
                                                                  .touchedSectionIndex;
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),

                                                //DESCRIPTION
                                                Positioned(
                                                  top: 120,
                                                  left: 0,
                                                  right: -300,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'Desc:',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 10,
                                                            height: 10,
                                                            decoration:
                                                                const BoxDecoration(
                                                                  color: Color(
                                                                    0xff116D6E,
                                                                  ),
                                                                  shape:
                                                                      BoxShape
                                                                          .rectangle,
                                                                ),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          const Text(
                                                            'Absent',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                0xff116D6E,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 10,
                                                            height: 10,
                                                            decoration:
                                                                const BoxDecoration(
                                                                  color: Color(
                                                                    0xffff9900,
                                                                  ),
                                                                  shape:
                                                                      BoxShape
                                                                          .rectangle,
                                                                ),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          const Text(
                                                            'Present',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                0xffff9900,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                        return Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 20),
                                                Image.asset(
                                                  'assets/images/nothing_found.png',
                                                ),
                                                const SizedBox(height: 20),
                                                Text(
                                                  "Empty",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        ColorConstants
                                                            .textSecondary,
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    "You have no attendance data",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color:
                                                          ColorConstants
                                                              .textSecondary,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
