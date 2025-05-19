import 'dart:convert';
import 'package:flutter/services.dart';

import '../model/chart_base.dart';
import '../model/chart_sales.dart';
import '../model/chart_weather.dart';
import '../model/chart_web_traffic.dart';

/// 图表数据仓库类
/// 负责统一管理和加载各种图表数据
final class ChartRepository {
  static final ChartRepository _instance = ChartRepository._internal();
  
  /// 私有构造函数，用于单例模式
  ChartRepository._internal();
  
  /// 获取ChartRepository单例
  factory ChartRepository() => _instance;

  Map<ChartDataType, ChartBase?> chartDataMap = {
    ChartDataType.sales: null,
    ChartDataType.weather: null,
    ChartDataType.webTraffic: null,
  };

  SalesData? get salesData => chartDataMap[ChartDataType.sales]?.data as SalesData?;
  WeatherData? get weatherData => chartDataMap[ChartDataType.weather]?.data as WeatherData?;
  ChartWebTraffic? get webTrafficData => chartDataMap[ChartDataType.webTraffic]?.data as ChartWebTraffic?;
  
  /// 通用方法：从JSON文件加载图表数据
  /// 
  /// [assetPath] - JSON资源文件路径
  /// [fromJson] - 将JSON转换为指定类型的函数
  Future<T> loadChartData<T>(
    String assetPath, 
    T Function(Map<String, dynamic>) fromJson
  ) async {
    try {
      // 从资源文件加载JSON字符串
      final jsonString = await rootBundle.loadString(assetPath);
      // 解析JSON字符串为Map
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      // 使用传入的fromJson函数将Map转换为指定类型
      return fromJson(jsonMap);
    } catch (e) {
      throw Exception('加载图表数据失败: $e');
    }
  }
  
  /// 加载销售数据
  Future<ChartSales> loadSalesData() async {
    if(chartDataMap[ChartDataType.sales] == null){
      chartDataMap[ChartDataType.sales] = await loadChartData(ChartSales.assetsPath, ChartSales.fromJson);
    }
    return chartDataMap[ChartDataType.sales] as ChartSales;
  }
  
  /// 加载天气数据
  Future<ChartWeather> loadWeatherData() async {
    if(chartDataMap[ChartDataType.weather] == null){
      chartDataMap[ChartDataType.weather] = await loadChartData(ChartWeather.assetsPath, ChartWeather.fromJson);
    }
    return chartDataMap[ChartDataType.weather] as ChartWeather;
  }
  
  /// 加载网络流量数据
  Future<ChartWebTraffic> loadWebTrafficData() async {
    if(chartDataMap[ChartDataType.webTraffic] == null){
      chartDataMap[ChartDataType.webTraffic] = await loadChartData(ChartWebTraffic.assetsPath, ChartWebTraffic.fromJson);
    }
    return chartDataMap[ChartDataType.webTraffic] as ChartWebTraffic;
  }
}

enum ChartDataType{
  sales,
  weather,
  webTraffic,
}