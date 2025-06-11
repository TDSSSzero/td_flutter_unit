import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'mindset_book.dart';

class BookPainter extends CustomPainter {
  ValueNotifier<PaperPoint> p;
  final Color? bColor;

  BookPainter(this.p, this.bColor) : super(repaint: p);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);

    canvas.restore();

    Path mPathAB = Path();

    ///书籍区域
    Path mPath = Path();
    mPath.addRect(Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width,
        height: size.height)
    );
    // print("book width: ${size.width},height: ${size.height}");

    /// A区域 下一页可见区域+当前页不可见区域  af重合 不需要绘制A区域
    if (p.value.a != p.value.f) {
      if (p.value.a.y == p.value.f.y) {
        // canvas.drawPath(mPath, paint..color = Colors.yellow);
        /// 翻页完毕
      } else {
        mPathAB.moveTo(p.value.c.x, p.value.c.y);
        mPathAB.quadraticBezierTo(
            p.value.e.x, p.value.e.y, p.value.b.x, p.value.b.y);
        mPathAB.lineTo(p.value.a.x, p.value.a.y);
        mPathAB.lineTo(p.value.k.x, p.value.k.y);
        mPathAB.quadraticBezierTo(
            p.value.h.x, p.value.h.y, p.value.j.x, p.value.j.y);
        mPathAB.lineTo(p.value.f.x, p.value.f.y);

        mPathAB.close();
        Path mPath1 = Path();
        mPath1.moveTo(p.value.d.x, p.value.d.y);
        mPath1.lineTo(p.value.a.x, p.value.a.y);
        mPath1.lineTo(p.value.i.x, p.value.i.y);
        mPath1.close();

        /// C区域 当前页可见区域 与A区域重新生成新路径
        // Path mPathC =
        //     Path.combine(PathOperation.reverseDifference, mPathAB, mPath);

        // canvas.drawPath(mPathC, paint..color = Colors.red);
        // canvas.drawPath(mPathAB, paint..color = Colors.yellow);

        /// B区域 当前页不可见区域
        if (!p.value.b.x.isNaN) {
          Path pyy1 = Path();
          Path pyy2 = Path();
          Path mPathB = Path.combine(PathOperation.intersect, mPathAB, mPath1);
          // 已知a坐标点在一条直线上，求距离该坐标点为10并和该直线相交的的坐标点。
          double m1 = (p.value.a.x - p.value.p.x);
          double n1 = (p.value.a.y - p.value.p.y);

          pyy1.moveTo(p.value.c.x - m1, p.value.c.y);
          pyy1.quadraticBezierTo(p.value.e.x - m1, p.value.e.y - n1,
              p.value.b.x - m1, p.value.b.y - n1);

          // pyy1.lineTo(twoPoint.x, twoPoint.y);

          pyy1.lineTo(p.value.p.x, p.value.p.y);
          pyy1.lineTo(p.value.k.x, p.value.k.y);
          pyy1.lineTo(p.value.f.x, p.value.f.y);
          pyy1.close();

          double mE1 = (p.value.a.x - p.value.p2.x);
          double nE1 = (p.value.a.y - p.value.p2.y); // 负数
          // debugPrint("p1x = $m1");
          // debugPrint("p1y = $n1");
          // debugPrint("p2x = $mE1");
          // debugPrint("p2y = $nE1");

          var twoPoint = PaperPoint.toTwoPoint(
              Point(p.value.b.x - m1, p.value.b.y - n1),
              p.value.p,
              p.value.p2,
              Point(p.value.k.x - mE1, p.value.k.y - nE1));
          pyy2.moveTo(p.value.j.x, (p.value.j.y - nE1));
          pyy2.quadraticBezierTo(p.value.i.x - mE1, p.value.i.y - nE1,
              p.value.k.x - mE1, p.value.k.y - nE1);
          // pyy2.lineTo(twoPoint.x, twoPoint.y);
          // pyy2.lineTo(p.value.a.x, p.value.a.y);
          pyy2.lineTo(p.value.p2.x, p.value.p2.y);
          pyy2.lineTo(p.value.b.x, p.value.b.y);
          pyy2.lineTo(p.value.f.x, p.value.f.y);

          pyy2.close();

          Path pd = Path();
          pd.moveTo(p.value.a.x, p.value.a.y);
          pd.lineTo(twoPoint.x, twoPoint.y);
          pd.lineTo(p.value.p2.x, p.value.p2.y);
          pd.close();
          Paint pdPaint = Paint();
          canvas.drawPath(
              pd,
              pdPaint
                ..shader = ui.Gradient.linear(
                  Offset(p.value.a.x, p.value.a.y),
                  Offset(p.value.p2.x, p.value.p2.y),
                  [Colors.black12, Colors.transparent],
                )
                ..style = PaintingStyle.fill);
          Paint psPaint = Paint();
          Path ps = Path();
          ps.moveTo(p.value.a.x, p.value.a.y);
          ps.lineTo(twoPoint.x, twoPoint.y);
          ps.lineTo(p.value.p.x, p.value.p.y);
          ps.close();

          canvas.drawPath(
              ps,
              psPaint
                ..shader = ui.Gradient.linear(
                    Offset(p.value.a.x, p.value.a.y),
                    Offset(p.value.p.x, p.value.p.y),
                    [Colors.black12, Colors.transparent])
                ..style = PaintingStyle.fill);
          // canvas.drawPath(
          //     Path.combine(PathOperation.reverseDifference, mPathAB, pyy2),
          //     paint
          //       ..color = Colors.green
          //       ..style = PaintingStyle.stroke);
          // //
          // canvas.drawPath(
          //     Path.combine(PathOperation.reverseDifference, mPathAB, pyy1),
          //     paint
          //       ..color = Colors.red
          //       ..style = PaintingStyle.stroke);

          // canvas.drawPath(
          //     pyy2,
          //     paint
          //       ..color = Colors.red
          //       ..style = PaintingStyle.fill);
          // canvas.drawPath(
          //     mPathAB,
          //     paint
          //       ..color = Colors.black
          //       ..style = PaintingStyle.stroke);

          Path startYY =
          Path.combine(PathOperation.reverseDifference, mPathAB, pyy1);
          Path endYY =
          Path.combine(PathOperation.reverseDifference, mPathAB, pyy2);

          canvas.drawPath(
              mPathB, paint..color = bColor ?? Colors.grey.shade400);

          Paint paint2 = Paint();
          // 上左

          canvas.drawPath(
              startYY,
              paint2
                ..style = PaintingStyle.fill
                ..shader = ui.Gradient.linear(
                    Offset(p.value.a.x, p.value.a.y),
                    Offset(p.value.p.x, p.value.p.y),
                    [Colors.black12, Colors.transparent]));

          //上右
          canvas.drawPath(
              endYY,
              paint2
                ..style = PaintingStyle.fill
                ..shader = ui.Gradient.linear(
                    Offset(p.value.a.x, p.value.a.y),
                    Offset(p.value.p2.x, p.value.p2.y),
                    [Colors.black12, Colors.transparent]));

          // 右下
          Path pr = Path();
          pr.moveTo(p.value.c.x, p.value.c.y);
          pr.lineTo(p.value.j.x, p.value.j.y);
          pr.lineTo(p.value.h.x, p.value.h.y);
          pr.lineTo(p.value.e.x, p.value.e.y);
          pr.close();

          Path p1 = Path.combine(PathOperation.intersect, pr, mPathAB);
          Path p2 = Path.combine(PathOperation.difference, p1, mPathB);

          Offset u = Offset(
              PaperPoint.toTwoPoint(p.value.a, p.value.f, p.value.d, p.value.i)
                  .x,
              PaperPoint.toTwoPoint(p.value.a, p.value.f, p.value.d, p.value.i)
                  .y);
          canvas.drawPath(
              p2,
              paint
                ..style = PaintingStyle.fill
                ..shader = ui.Gradient.linear(
                    u,
                    Offset(p.value.g.x, p.value.g.y),
                    [Colors.black26, Colors.transparent]));

          // canvas.drawLine(o1, o2, paint);

        }
      }
    } else {
      // canvas.drawPath(mPath, paint..color = Colors.red);
    }
  }

  @override
  bool shouldRepaint(covariant BookPainter oldDelegate) {
    return oldDelegate.p != p;
  }

  Path drawText(String s, Canvas canvas, Size size) {
    var textPainter = TextPainter(
        text: TextSpan(
            text: s,
            style: TextStyle(
              fontSize: 20,
              foreground: Paint()
                ..style = PaintingStyle.fill
                ..strokeWidth = 1,
            )),
        textAlign: TextAlign.left,
        maxLines: 100,
        ellipsis: "...",
        textDirection: TextDirection.ltr);
    textPainter.layout();
    var size2 = textPainter.size;
    textPainter.paint(
      canvas,
      Offset(-size2.width / 2, -size2.height / 2),
    );

    Path path = Path();
    path.addRect(Rect.fromCenter(
        center: Offset.zero, width: size2.width, height: size2.height));
    return path;
  }
}