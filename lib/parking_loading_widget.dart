import 'package:flutter/material.dart';

class ParkingLoadingWidget extends StatefulWidget {
  @override
  _ParkingLoadingWidgetState createState() => _ParkingLoadingWidgetState();
}

class _ParkingLoadingWidgetState extends State<ParkingLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ParkingSymbolPainter(_controller.value),
          size: Size(50, 50),
        );
      },
    );
  }
}

class ParkingSymbolPainter extends CustomPainter {
  final double animationValue;

  ParkingSymbolPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;

    Paint circlePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    Paint linePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawCircle(Offset(radius, radius), radius, circlePaint);

    // Draw the "P" letter of the parking symbol
    double lineStartX = radius - 8;
    double lineEndX = radius + 4;
    double lineY = radius + 2;

    Path path = Path();
    path.moveTo(lineStartX, lineY);
    path.lineTo(lineEndX, lineY);
    path.moveTo(lineStartX, lineY - 6);
    path.lineTo(lineStartX, lineY + 6);

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
