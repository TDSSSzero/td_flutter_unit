import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:td_flutter_unit/modules/base/base_page.dart';
import 'package:td_flutter_unit/pages/home_provider.dart';

class LottiePage extends ConsumerStatefulWidget {
  const LottiePage({super.key});

  @override
  ConsumerState<LottiePage> createState() => _LottiePageState();
}

class _LottiePageState extends ConsumerState<LottiePage> with TickerProviderStateMixin {

  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

@override
  Widget build(BuildContext context) {
    return BasePage(
      title: ref.watch(curMenuItemProvider).name, 
    child: Center(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              width: 400,
              height: 200,
              child: Card(
                child: Lottie.asset(
                  'assets/lottie/cat.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                  controller: _controller,
                  frameRate: FrameRate.max,
                  onLoaded: (composition) {
                    _controller
                      ..duration = composition.duration
                      ..forward();
                  },
                ),
              ),
            ),
          ),
          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: _onPlay, child: Text("Play")),
              SizedBox(width: 16,),
              ElevatedButton(onPressed: _onPause, child: Text("Pause")),
            ],
          ))
        ],
      ),
    ));
  }

  _onPlay() {
    if(_controller.isCompleted){
      _controller.reset();
    }
    _controller.forward();
  }

  _onPause() {
    _controller.stop();
  }

}
