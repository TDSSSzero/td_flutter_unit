import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:td_flutter_unit/modules/chart/model/chart_sales.dart';
import 'package:td_flutter_unit/modules/chart/model/chart_weather.dart';
import 'package:td_flutter_unit/modules/chart/repository/chart_repository.dart';

part 'chart_provider.g.dart';

@riverpod
FutureOr<SalesData> chartSales(Ref ref) async{
  await ChartRepository().loadSalesData();
  return ChartRepository().chartDataMap[ChartDataType.sales]?.data ?? SalesData();
}

@riverpod
FutureOr<WeatherData> chartWeather(Ref ref) async{
  await ChartRepository().loadWeatherData();
  return ChartRepository().chartDataMap[ChartDataType.weather]?.data ?? WeatherData();
}

