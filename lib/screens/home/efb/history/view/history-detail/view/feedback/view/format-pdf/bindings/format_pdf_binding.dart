import 'package:airmaster/screens/home/efb/history/view/history-detail/view/feedback/view/format-pdf/controller/format_pdf_controller.dart';
import 'package:get/get.dart';

/*
  |--------------------------------------------------------------------------
  | File: Format PDF Binding
  |--------------------------------------------------------------------------
  | This file contains the binding for the Format PDF Controller.
  | It is responsible for lazy loading the controller when it is needed.
  |--------------------------------------------------------------------------
  | created by: Jeremy Nainggolan
  | created at: 2025-06-01
  | last modified by: Jeremy Nainggolan
  | last modified at: 2025-08-05
  |
*/
class Format_Pdf_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Format_Pdf_Controller>(() => Format_Pdf_Controller());
  }
}
