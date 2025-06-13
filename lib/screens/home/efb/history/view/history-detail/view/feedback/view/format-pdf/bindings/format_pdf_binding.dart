import 'package:airmaster/screens/home/efb/history/view/history-detail/view/feedback/view/format-pdf/controller/format_pdf_controller.dart';
import 'package:get/get.dart';

class Format_Pdf_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Format_Pdf_Controller>(() => Format_Pdf_Controller());
  }
}
