import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signals/signals_flutter.dart';

class SignalDemoPage extends ConsumerStatefulWidget {
  const SignalDemoPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignalDemoPageState();
}

class _SignalDemoPageState extends ConsumerState<SignalDemoPage> {

  final _counter = signal(0);

  void _incrementCounter() => _counter.value++;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('SignalDemoPage'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('counter: ${_counter.watch(context)}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: Icon(Icons.add),
        ),
      );
  }
}