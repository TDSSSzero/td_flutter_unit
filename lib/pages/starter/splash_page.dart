import 'package:flutter/material.dart';
import 'package:td_flutter_unit/pages/starter/splash_row_anim.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SplashRowAnim(),
      ),
    );
  }
}