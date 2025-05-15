import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:td_flutter_unit/tds_unit.dart';

void main() {
  runApp(ProviderScope(child: TDUnit()));
}
