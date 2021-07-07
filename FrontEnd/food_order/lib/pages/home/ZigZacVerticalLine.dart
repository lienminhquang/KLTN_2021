import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ZigZacVerticalLine extends CustomPainter {
  //const CustomPainter({ Listenable? repaint }) : _repaint = repaint;
  const ZigZacVerticalLine({this.zigzagWidth = 4, this.zigzagHeight = 4});
  final double zigzagWidth;
  final double zigzagHeight;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;

    Offset start = Offset(0, 0);
    int n = 1;
    while (start.dy < size.height) {
      var x = start.dx - zigzagWidth;
      var y = start.dy + zigzagHeight;

      if (n % 2 == 0) {
        x = 0;
      }
      canvas.drawLine(start, Offset(x, y), paint);
      start = Offset(x, y);
      n++;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
