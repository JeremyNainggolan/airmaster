// ignore_for_file: camel_case_types
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/controller/training_list_detail_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class TC_TrainingListDetail extends GetView<TC_TrainingListDetail_Controller> {
  TC_TrainingListDetail({super.key});

  final trainingName = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorConstants.textSecondary),
          onPressed: () => Get.back(),
        ),
        title: Text('Training List $trainingName'),
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          PopupMenuButton<int>(
            color: ColorConstants.backgroundColor,
            icon: Icon(Icons.more_vert, color: ColorConstants.backgroundColor),
            onSelected: (item) => onSelected(context, item, trainingName, controller),
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: ColorConstants.hintColor,
                          size: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Add Attendance",
                            style: TextStyle(
                              color: ColorConstants.hintColor,
                              fontSize: SizeConstant.TEXT_SIZE,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: ColorConstants.hintColor,
                          size: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),

                          child: Text(
                            "Delete",
                            style: TextStyle(
                              color: ColorConstants.hintColor,
                              fontSize: SizeConstant.TEXT_SIZE,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
          ),
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: controller.trainingList,
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Confirmed'),
              Tab(text: 'Done'),
            ],
            dividerColor: Colors.transparent,
          ),
          SizedBox(height: SizeConstant.SIZED_BOX_HEIGHT),
          Expanded(
            child: TabBarView(
              controller: controller.trainingList,
              children: [
                FutureBuilder<List<dynamic>>(
                  future: controller.getAttendanceList('$trainingName','pending'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No Pending Attendance'));
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final attendance = snapshot.data![index];
                          return ListTile(
                            title: Text(attendance['user_name'] ?? 'No Name' ),
                            subtitle: Text(
                              attendance['date'] != null
                                  ? DateFormat('dd MMMM yyyy').format(DateTime.parse(attendance['date']))
                                  : 'No Date',
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
                Center(child: Text('In Use Devices')),
                Center(child: Text('Returned Devices')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void onSelected(BuildContext context, int item, dynamic trainingName, TC_TrainingListDetail_Controller controller) {
  switch (item) {
    case 0:
      Get.toNamed(AppRoutes.TC_ADD_ATTENDANCE, arguments: trainingName);
      break;
    case 1:
      controller.deleteTraining(trainingName);
      break;
  }
}
