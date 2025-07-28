// ignore_for_file: camel_case_types
import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/home/training_card/training/view/training_list/controller/training_list_detail_controller.dart';
import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class TC_TrainingListDetail extends GetView<TC_TrainingListDetail_Controller> {
  const TC_TrainingListDetail({super.key});

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
        title: Text('Training List ${controller.subject.toString()}'),
        titleTextStyle: GoogleFonts.notoSans(
          color: ColorConstants.textSecondary,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          PopupMenuButton<int>(
            color: ColorConstants.backgroundColor,
            icon: Icon(Icons.more_vert, color: ColorConstants.backgroundColor),
            onSelected:
                (item) =>
                    onSelected(context, item, controller.subject, controller),
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
      body: Obx(
        () => Column(
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
                  RefreshIndicator(
                    backgroundColor: ColorConstants.backgroundColor,
                    onRefresh: () async {
                      await controller.getAttendanceList(controller.subject);
                    },
                    child:
                        controller.attendanceListPending.isEmpty
                            ? ListView(
                              physics: AlwaysScrollableScrollPhysics(),
                              children: const [
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 24),
                                    child: Text("No Data"),
                                  ),
                                ),
                              ],
                            )
                            : buildList(
                              controller.attendanceListPending,
                              controller,
                              AppRoutes.TC_ATTENDANCE_PENDING_DETAIL,
                            ),
                  ),
                  RefreshIndicator(
                    onRefresh: () async {
                      await controller.getAttendanceList(controller.subject);
                    },
                    backgroundColor: ColorConstants.backgroundColor,
                    child:
                        controller.attendanceListConfirmed.isEmpty
                            ? ListView(
                              physics: AlwaysScrollableScrollPhysics(),
                              children: [
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 24),
                                    child: Text("No Data"),
                                  ),
                                ),
                              ],
                            )
                            : buildList(
                              controller.attendanceListConfirmed,
                              controller,
                              AppRoutes.TC_ATTENDANCE_CONFIRM_DETAIL,
                            ),
                  ),
                  RefreshIndicator(
                    backgroundColor: ColorConstants.backgroundColor,
                    onRefresh: () async {
                      await controller.getAttendanceList(controller.subject);
                    },
                    child:
                        controller.attendanceListDone.isEmpty
                            ? ListView(
                              physics: AlwaysScrollableScrollPhysics(),
                              children: [
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 24),
                                    child: Text("No Data"),
                                  ),
                                ),
                              ],
                            )
                            : buildList(
                              controller.attendanceListDone,
                              controller,
                              AppRoutes.TC_ATTENDANCE_DONE_DETAIL,
                            ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void onSelected(
  BuildContext context,
  int item,
  dynamic trainingName,
  TC_TrainingListDetail_Controller controller,
) async {
  switch (item) {
    case 0:
      Get.toNamed(AppRoutes.TC_ADD_ATTENDANCE, arguments: trainingName);
      break;
    case 1:
      await controller.deleteTraining(trainingName);
      Get.back(result: true);
      QuickAlert.show(context: Get.context!, type: QuickAlertType.success);
      break;
  }
}

Widget buildList(List list, controller, String route) {
  if (controller.isLoading.value) {
    return Center(
      child: LoadingAnimationWidget.hexagonDots(
        color: ColorConstants.primaryColor,
        size: 48,
      ),
    );
  }

  if (list.isEmpty) {
    return Center(child: Text("No Data"));
  }

  return ListView.builder(
    padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
    physics: const AlwaysScrollableScrollPhysics(),
    itemCount: list.length,
    itemBuilder: (context, index) {
      final item = list[index];
      return Card(
        color: ColorConstants.backgroundColor,
        elevation: 2,
        child: ListTile(
          title: Text(item['instructor_name'] ?? 'ERROR'),
          subtitle: Text(
            item['date'] != null
                ? DateFormat(
                  'dd MMMM yyyy',
                ).format(DateTime.parse(item['date']))
                : 'No Date',
          ),
          leading: CircleAvatar(
            backgroundImage:
                item['instructor_photo'] != null &&
                        item['instructor_photo'].toString().isNotEmpty
                    ? NetworkImage(item['instructor_photo'])
                    : AssetImage('assets/images/default_picture.png')
                        as ImageProvider,
          ),
          onTap: () {
            Get.toNamed(route, arguments: item);
          },
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: ColorConstants.labelColor,
            size: 18,
          ),
        ),
      );
    },
  );
}
