import 'package:airmaster/utils/const_color.dart';
import 'package:airmaster/utils/const_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  final MobileScannerController scannerController = MobileScannerController(
    formats: [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.normal,
  );

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorConstants.whiteColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorConstants.lightColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "QR Scanner",
          style: TextStyle(
            color: ColorConstants.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: ColorConstants.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(SizeConstant.SCREEN_PADDING),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxHeight = constraints.maxHeight;
              return Stack(
                children: [
                  MobileScanner(
                    controller: scannerController,
                    onDetect: (capture) async {
                      final List<Barcode> barcodes = capture.barcodes;

                      if (barcodes.isNotEmpty) {
                        await scannerController.stop();

                        final String? code = barcodes.first.rawValue;
                        if (code != null) {
                          Get.back(result: code);
                        }
                      }
                    },
                  ),

                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Positioned(
                        top: _animation.value * (maxHeight - 5),
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFED1C24),
                                Colors.white,
                                Color(0xFFED1C24),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFED1C24),
                                blurRadius: 50,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Center(
          child: Text(
            'Scan EFB Device QR Code',
            style: GoogleFonts.notoSans(
              color: ColorConstants.textPrimary,
              fontSize: SizeConstant.TEXT_SIZE,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
