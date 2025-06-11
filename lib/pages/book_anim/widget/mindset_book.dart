import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:td_flutter_unit/modules/function.dart';

import 'book_controller.dart';
import 'book_painter.dart';

/// 类介绍：模拟书籍翻页效果
class MindsetBook extends StatefulWidget {
  /// 翻页时长
  final Duration? duration;

  /// 书籍区域
  final Size size;

  /// 一般情况页面布局是固定的 变化的是布局当中的内容
  /// 不过若是页面之间有布局不同时，须同时更新布局
  /// 当前页布局
  /// [index] 当前页码
  final Widget Function(int index) currentPage;

  /// 下一页布局
  /// [index] 下一页页码
  final Widget Function(int index) nextPage;

  /// 当前翻页的背面色值
  final Color? currentBgColor;

  /// 书籍页数
  final int pageCount;

  /// 下一页回调
  final Function(int index)? nextCallBack;

  /// 上一页回调
  final Function(int index)? lastCallBack;

  final BookController controller;

  final SingleCallback<BuildContext> onLongPress;
  final SingleCallback<int>? onPageChanged;

  const MindsetBook({
    Key? key,
    this.duration,
    required this.size,
    required this.currentPage,
    required this.nextPage,
    this.currentBgColor,
    this.pageCount = 10000,
    this.nextCallBack,
    this.lastCallBack,
    required this.controller,
    required this.onLongPress,
    this.onPageChanged,
  }) : super(key: key);

  @override
  _MindsetBookState createState() => _MindsetBookState();
}

class _MindsetBookState extends State<MindsetBook> with SingleTickerProviderStateMixin {
  late Size size = widget.size;
  late Offset downPos;
  double panOffset = 0;
  Point<double> currentA = const Point(0, 0);

  AnimationController? _controller;

  // 当前页面

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this,
        duration: widget.duration ?? const Duration(milliseconds: 1000));
    _controller?.addListener(() {

      if (isNext) {
        /// 翻页
        _p.value = PaperPoint(
            Point(currentA.x - (currentA.x + size.width) * _controller!.value,
                currentA.y + (size.height - currentA.y) * _controller!.value),
            size);
      } else {
        /// 不翻页 回到原始位置
        _p.value = PaperPoint(
            Point(
              currentA.x + (size.width - currentA.x) * _controller!.value,
              currentA.y + (size.height - currentA.y) * _controller!.value,
            ),
            size);
      }
    });
    // final state = Get.find<PetBookLogic>().state;
    _controller?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // state.buttonOpacity.value = 1;
        isAnimation = false;
        if (isNext) {
          setState(() {
            isAlPath = true;
            widget.controller.currentIndex++;
            widget.onPageChanged?.call(widget.controller.currentIndex);
            widget.nextCallBack?.call(widget.controller.currentIndex + 1);
          });
        }else{
          widget.onPageChanged?.call(widget.controller.currentIndex);
        }
      }
      if(status == AnimationStatus.forward){
        // state.buttonOpacity.value = 0;
      }
    });

    // build完毕初始化首页
    // 当前页码
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _p.value = PaperPoint(Point(size.width, size.height), size);
    });
    widget.controller.addListener(ctrlListen);
  }

  @override
  void didUpdateWidget(covariant MindsetBook oldWidget) {
    super.didUpdateWidget(oldWidget);
    _p.value = PaperPoint(Point(size.width, size.height), size);
    widget.controller.removeListener(ctrlListen);
    widget.controller.addListener(ctrlListen);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  bool isNext = true; // 是否翻页到下一页
  bool isAlPath = true; //
  bool isAnimation = false; // 是否正在执行翻页
  bool isLongPress = false;
  // 控制点类
  final ValueNotifier<PaperPoint> _p =
  ValueNotifier(PaperPoint(const Point(0, 0), const Size(0, 0)));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: GestureDetector(
        child: Stack(
          children: [
            // 下一页
            widget.controller.currentIndex == widget.pageCount - 1
                ? const SizedBox()
                : widget.nextPage(widget.controller.currentIndex + 1),
            // 当前页
            ClipPath(
              clipper: isAlPath ? null : CurrentPaperClipPath(_p, isNext),
              child: widget.currentPage(widget.controller.currentIndex),
            ),
            CustomPaint(
              size: size,
              painter: BookPainter(
                _p,
                widget.currentBgColor,
              ),
            ),
          ],
        ),
        onLongPressStart: (details) {
          isLongPress = true;
        },
        onLongPress: () {
          widget.onLongPress.call(context);
          isLongPress = false;
        },
        onPanStart: (details) {
          
        },
        onPanUpdate: (details) {
          panOffset += details.delta.dx;
          setState(() {

          });
        },
        onTapDown: (details) {
          downPos = details.localPosition;
          setState(() {

          });
        },
        onTapUp: (details) {
          if(!isLongPress){
            changePage(isNext: downPos.dx >= size.width / 2);
          }
        },
        onPanEnd: (details) {
          if(!isLongPress){
            changePage(isNext: panOffset <= 0);
            panOffset = 0;
            setState(() {

            });
          }
        },
      ),
    );
  }

  void changePage({required bool isNext}){
    if (isAnimation) {
      return;
    }
    if(isNext){
      //如果是最后一页
      if(widget.controller.currentIndex == widget.pageCount - 1)return;
      next();
    }else{
      //如果是第一页
      if (widget.controller.currentIndex == 0) return;
      widget.lastCallBack?.call(widget.controller.currentIndex);
      last();
    }
    // /// 手指首次触摸屏幕左侧区域
    // if (downPos.dx < size.width / 2) {
    
    //   //如果是第一页
    //   if (widget.controller.currentIndex == 0) return;
    //   widget.lastCallBack?.call(widget.controller.currentIndex);
    //   last();
    // }else{
    //   printDebug("pet book bg next");
    //   printDebug("currentIndex: ${widget.controller.currentIndex},pageCount : ${widget.pageCount}");
    //   printDebug("bool : ${widget.controller.currentIndex == widget.pageCount - 1}");
    //   //如果是最后一页
    //   if(widget.controller.currentIndex == widget.pageCount - 1)return;
    //   next();
    // }
  }

  void ctrlListen(){
    if (isAnimation == true) {
      // 翻页动画正在执行
      return;
    }
    if (widget.controller.nextType == 1) {
      /// 下一页
      /// 当前页currentIndex是角标索引 0开始 页码是从 1开始的
      if (widget.controller.currentIndex >= widget.pageCount - 1) {
        //最后一页了
        widget.nextCallBack?.call(widget.pageCount);
        return;
      }
      next();
    } else if (widget.controller.nextType == -1) {
      /// 上一页
      if (widget.controller.currentIndex != 0) {
        last();
        return;
      } else {
        // 首页了
        widget.lastCallBack?.call(widget.controller.currentIndex);
      }
    } else if (widget.controller.nextType == 0) {
      // 跳页
      // 当前页 = 跳转页  || 当前页<0 || 当前页>页码
      if (widget.controller.currentIndex == widget.controller.goToIndex - 1 ||
          widget.controller.goToIndex < 0 ||
          widget.controller.goToIndex > widget.pageCount) {
        return;
      } else {
        setState(() {
          widget.controller.currentIndex = widget.controller.goToIndex - 1;
        });
      }
    }
  }

  void last() {
    setState(() {
      // isAlPath = true;
      isAlPath = false;
      isAnimation = true;
      currentA = Point(-(size.width -50), size.height - 50);
      isNext = false;
      widget.controller.currentIndex--;
      _controller?.forward(
        from: 0,
      );
    });
  }

  void next() {
    setState(() {
      isAlPath = false;
    });
    isAnimation = true;
    isNext = true;
    currentA = Point(size.width - 50, size.height - 50);
    // widget.controller.currentIndex++;
    _controller?.forward(
      from: 0,
    );
  }
}

/// 当前页区域
class CurrentPaperClipPath extends CustomClipper<Path> {
  ValueNotifier<PaperPoint> p;
  bool isNext;

  CurrentPaperClipPath(this.p, this.isNext) : super(reclip: p);

  @override
  Path getClip(Size size) {
    ///书籍区域
    Path mPath = Path();
    mPath.addRect(Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width,
        height: size.height));
    Path mPathA = Path();
    // 翻页
    if (p.value.a != p.value.f && p.value.a.x > -size.width) {
      mPathA.moveTo(p.value.c.x, p.value.c.y);
      mPathA.quadraticBezierTo(
          p.value.e.x, p.value.e.y, p.value.b.x, p.value.b.y);
      mPathA.lineTo(p.value.a.x, p.value.a.y);
      mPathA.lineTo(p.value.k.x, p.value.k.y);
      mPathA.quadraticBezierTo(
          p.value.h.x, p.value.h.y, p.value.j.x, p.value.j.y);
      mPathA.lineTo(p.value.f.x, p.value.f.y);
      mPathA.close();
      // try{
      Path mPathC =
      Path.combine(PathOperation.reverseDifference, mPathA, mPath);
      return mPathC;
      // }catch(e){
      //   return Path();
      // }

    } else {
      // 全区域 Path
      if (isNext) {
        return Path();
      } else {
        return mPath;
      }
    }
  }

  @override
  bool shouldReclip(covariant CurrentPaperClipPath oldClipper) {
    return p != oldClipper.p;
  }
}



class PaperPoint {
  //手指拉拽点 已知
  Point<double> a;

  // c区域影深
  final double elevationC;

  //右下角的点 已知
  late Point<double> f;

  late Point<double> p;
  late Point<double> p2;

  //
  // //贝塞尔点(e为控制点)
  late Point<double> b, c, d, e;

  // //贝塞尔点(h为控制点)
  late Point<double> h, i, j, k;

  //eh实际为af中垂线，g为ah和af的交点
  late Point<double> g;

  late Size size;

  late double ahK;
  late double ahB;

  PaperPoint(
      this.a,
      this.size, {
        this.elevationC = 10,
      }) {
    //每个点的计算公式
    // f = Point(size.width / 2, size.height / 2);
    f = Point(size.width, size.height);
    // debugPrint("af  ${a.y}  ${f.y}");
    // if (a.y == f.y) {
    //   return;
    // }
    g = Point((a.x + f.x) / 2, (a.y + f.y) / 2);
    e = Point(g.x - (pow(f.y - g.y, 2) / (f.x - g.x)), f.y);
    double cx = e.x - (f.x - e.x) / 2;
    // debugPrint("g  $g e $e");
    if (a.x > 0) {
      if (cx <= 0) {
        //   // 临界点
        double fc = f.x - cx;
        double fa = f.x - a.x;
        double bb1 = size.width * fa / fc;
        double fd1 = f.y - a.y;
        double fd = bb1 * fd1 / fa;
        a = Point(f.x - bb1, f.y - fd);
        g = Point((a.x + f.x) / 2, (a.y + f.y) / 2);
        e = Point(g.x - (pow((f - g).y, 2) / (f - g).x), f.y);

        cx = 0;
      }
    }

    c = Point(cx, f.y);
    h = Point(f.x, g.y - (pow((f - g).x, 2) / (f.y - g.y)));

    j = Point(f.x, h.y - (f.y - h.y) / 2);

    double k1 = towPointKb(c, j);
    double b1 = towPointKb(c, j, isK: false);

    double k2 = towPointKb(a, e);
    double b2 = towPointKb(a, e, isK: false);

    double k3 = towPointKb(a, h);

    double b3 = towPointKb(a, h, isK: false);

    ahK = towPointKb(a, h);
    ahB = towPointKb(a, h, isK: false);
    b = Point((b2 - b1) / (k1 - k2), (b2 - b1) / (k1 - k2) * k1 + b1);
    k = Point((b3 - b1) / (k1 - k3), (b3 - b1) / (k1 - k3) * k1 + b1);
    d = Point(((c.x + b.x) / 2 + e.x) / 2, ((c.y + b.y) / 2 + e.y) / 2);

    i = Point(((j.x + k.x) / 2 + h.x) / 2, ((j.y + k.y) / 2 + h.y) / 2);

    p = toP(a, ahK, ahB, elevationC);
    p2 = toP(a, towPointKb(a, e), towPointKb(a, e, isK: false), elevationC);
  }

  Point<double> toP(Point<double> p, double k, double b, double jl) {
    double x = 0.0;
    double y = 0.0;

    if (k > 0 || a.y >= h.y) {
      x = a.x - sqrt(jl * jl / (1 + (k * k)));
      y = a.y - sqrt(jl * jl / (1 + (k * k))) * k;
    } else {
      x = a.x + sqrt(jl * jl / (1 + (k * k)));
      y = a.y + sqrt(jl * jl / (1 + (k * k))) * k;
    }

    return Point<double>(x, y);
  }

  /// 两点求直线方程
  static double towPointKb(Point<double> p1, Point<double> p2,
      {bool isK = true}) {
    /// 求得两点斜率
    double k = 0;
    double b = 0;
    // 防止除数 = 0 出现的计算错误 a e x轴重合
    if (p1.x == p2.x) {
      k = (p1.y - p2.y) / (p1.x - p2.x - 1);
    } else {
      k = (p1.y - p2.y) / (p1.x - p2.x);
    }
    b = p1.y - k * p1.x;
    if (isK) {
      return k;
    } else {
      return b;
    }
  }

  static Point<double> toTwoPoint(
      Point<double> a, Point<double> b, Point<double> m, Point<double> n) {
    double k1 = towPointKb(a, b);
    double b1 = towPointKb(a, b, isK: false);

    double k2 = towPointKb(m, n);
    double b2 = towPointKb(m, n, isK: false);

    return Point((b2 - b1) / (k1 - k2), (b2 - b1) / (k1 - k2) * k1 + b1);
  }
}