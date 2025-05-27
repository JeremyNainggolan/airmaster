import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UnderMaintenance extends StatefulWidget {
  const UnderMaintenance({super.key});

  @override
  State<UnderMaintenance> createState() => _UnderMaintenanceState();
}

class _UnderMaintenanceState extends State<UnderMaintenance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: DiagonalStripesPainter(
          colors: [Colors.yellow, Colors.black], // Urutan warna yang sesuai
          stripeWidth: 30.0, // Sesuaikan lebar garis
          gapWidth: 30.0, // Sesuaikan lebar celah (garis lainnya)
          angleInDegrees: 45.0, // Sudut kemiringan
        ),
        child: Center(
          child: Text(
            'UNDER MAINTENANCE',
            textAlign: TextAlign.justify,
            style: GoogleFonts.notoSans(
              color: Colors.black,
              fontSize: 28.0,
              letterSpacing: 3.0,
              fontWeight: FontWeight.bold,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class DiagonalStripesPainter extends CustomPainter {
  final List<Color> colors;
  final double stripeWidth;
  final double gapWidth; // Jarak antar garis (sama dengan lebar garis lainnya)
  final double angleInDegrees; // Sudut kemiringan garis

  DiagonalStripesPainter({
    this.colors = const [Colors.black, Colors.yellow],
    this.stripeWidth = 40.0,
    this.gapWidth = 40.0,
    this.angleInDegrees = 45.0, // Kemiringan 45 derajat
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double angle = angleInDegrees * math.pi / 180.0; // Konversi ke radian
    final double diagonalLength = math.sqrt(
      size.width * size.width + size.height * size.height,
    );

    // Hitung lebar efektif garis saat diproyeksikan ke sumbu x atau y
    final double effectiveStripeWidth = stripeWidth / math.sin(angle);
    final double effectiveGapWidth =
        gapWidth / math.cos(angle); // Untuk diagonal

    // Menghitung panjang satu siklus pola (garis kuning + garis hitam)
    final double patternCycle = effectiveStripeWidth + effectiveGapWidth;

    // Geser canvas ke tengah agar garis bisa diatur dari tengah
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(angle); // Putar canvas
    canvas.translate(
      -size.width / 2,
      -size.height / 2,
    ); // Kembali geser ke posisi semula

    // Tentukan area menggambar yang lebih besar untuk menutupi setelah rotasi
    final double extendedWidth = size.width + diagonalLength;
    final double extendedHeight = size.height + diagonalLength;

    // Loop untuk menggambar garis-garis
    // Mulai dari luar area pandang untuk memastikan seluruh canvas tertutup
    for (double x = -extendedWidth; x < extendedWidth; x += patternCycle) {
      // Garis warna pertama (misal: kuning)
      canvas.drawRect(
        Rect.fromLTWH(
          x,
          -diagonalLength,
          effectiveStripeWidth,
          extendedHeight * 2,
        ),
        Paint()..color = colors[0],
      );

      // Garis warna kedua (misal: hitam)
      canvas.drawRect(
        Rect.fromLTWH(
          x + effectiveStripeWidth,
          -diagonalLength,
          effectiveGapWidth,
          extendedHeight * 2,
        ),
        Paint()..color = colors[1],
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Repaint jika properti berubah
    return oldDelegate is DiagonalStripesPainter &&
        (oldDelegate.colors != colors ||
            oldDelegate.stripeWidth != stripeWidth ||
            oldDelegate.gapWidth != gapWidth ||
            oldDelegate.angleInDegrees != angleInDegrees);
  }
}
