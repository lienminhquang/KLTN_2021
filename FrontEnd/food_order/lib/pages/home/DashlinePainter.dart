import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashedLinePainter extends CustomPainter {
  //const CustomPainter({ Listenable? repaint }) : _repaint = repaint;
  const DashedLinePainter({this.dashWidth = 4, this.dashSpace = 4});
  final double dashWidth;
  final double dashSpace;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;

    Offset start = Offset(0, 0);
    int n = 1;
    while (start.dy < size.height) {
      var x = start.dx;
      var y = start.dy + dashWidth;

      canvas.drawLine(start, Offset(x, y), paint);

      start = Offset(x, y + dashSpace);
      n++;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
