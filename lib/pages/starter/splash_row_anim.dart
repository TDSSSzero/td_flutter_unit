import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:td_flutter_unit/cons/str_unit.dart';
import 'package:td_flutter_unit/navigation/router/app_route.dart';

class SplashRowAnim extends StatefulWidget {
  const SplashRowAnim({super.key});

  @override
  State<SplashRowAnim> createState() => _SplashRowAnimState();
}

class _SplashRowAnimState extends State<SplashRowAnim>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;
  late Animation<double> _fadeAnimation;

  static const pos = 50.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
    _controller.addStatusListener(_onAnimStatusChanged);

    // Logo moves left (negative value)
    _logoAnimation = Tween<double>(
      begin: 0.0,
      end: -pos,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _textAnimation = Tween<double>(begin: 0.0, end: pos).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 1.0, curve: Curves.easeOut), // 延迟0.3秒启动
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_onAnimStatusChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Logo that moves left
            Transform.translate(
              offset: Offset(_logoAnimation.value, 0),
              child: const FlutterLogo(size: 50),
            ),
            // Text that moves right and fades in
            Transform.translate(
              offset: Offset(_textAnimation.value, 0),
              child: Opacity(
                opacity: _fadeAnimation.value,
                child: const Text(
                  StrUnit.appName,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onAnimStatusChanged(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.completed:
      context.go(AppRoute.home.path);
        break;
      case AnimationStatus.dismissed:
        break;
      case AnimationStatus.forward:
        break;
      case AnimationStatus.reverse:
        break;
    }
  }
}
