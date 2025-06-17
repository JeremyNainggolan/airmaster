import 'package:airmaster/screens/home/efb/history/view/history-detail/view/handover-log-format/controller/handover_log_format_controller.dart';
import 'package:get/get.dart';

class Handover_Log_Format_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Handover_Log_Format_Controller>(
      () => Handover_Log_Format_Controller(),
    );
  }
}
