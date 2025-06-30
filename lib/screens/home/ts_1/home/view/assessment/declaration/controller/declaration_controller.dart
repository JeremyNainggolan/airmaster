import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class Declaration_Controller extends GetxController {
  final formKey = GlobalKey<FormState>();
  final signatureKey = GlobalKey<SfSignaturePadState>();

  Uint8List? signatureImg;

  final RxString firstCrewDeclaration = ''.obs;
  final RxString secondCrewDeclaration = ''.obs;

  final declarationList = ['Satisfactory', 'Unsatisfactory'];
}
