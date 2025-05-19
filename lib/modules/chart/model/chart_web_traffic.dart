import 'chart_base.dart';

/// 网络流量数据模型类
/// 用于解析和存储网站流量相关的图表数据
class ChartWebTraffic extends ChartBase<WebTrafficData> {
  /// 构造函数
  const ChartWebTraffic({WebTrafficData? data}) : super(data: data);
  static const String assetsPath = 'assets/chart_data/chart_data_web_traffic.json';

  /// 从JSON映射创建ChartWebTraffic实例
  factory ChartWebTraffic.fromJson(Map<String, dynamic> json) {
    return ChartWebTraffic(
      data: json['webTrafficData'] != null
          ? WebTrafficData.fromJson(json['webTrafficData'])
          : null,
    );
  }
  
  /// 获取网络流量数据
  WebTrafficData? get webTrafficData => data;
}

/// 网络流量数据容器类
/// 包含年度、月度和周度网络流量数据
class WebTrafficData extends ChartDataContainer<AnnualWebTrafficData, MonthlyWebTrafficData, WeeklyWebTrafficData> {
  /// 构造函数
  const WebTrafficData({List<AnnualWebTrafficData>? annual, List<MonthlyWebTrafficData>? monthly, List<WeeklyWebTrafficData>? weekly})
      : super(annual: annual, monthly: monthly, weekly: weekly);

  /// 从JSON映射创建WebTrafficData实例
  factory WebTrafficData.fromJson(Map<String, dynamic> json) {
    return WebTrafficData(
      annual: json['annual'] != null
          ? List<AnnualWebTrafficData>.from(
              json['annual'].map((x) => AnnualWebTrafficData.fromJson(x)))
          : null,
      monthly: json['monthly'] != null
          ? List<MonthlyWebTrafficData>.from(
              json['monthly'].map((x) => MonthlyWebTrafficData.fromJson(x)))
          : null,
      weekly: json['weekly'] != null
          ? List<WeeklyWebTrafficData>.from(
              json['weekly'].map((x) => WeeklyWebTrafficData.fromJson(x)))
          : null,
    );
  }
}

/// 年度网络流量数据模型
class AnnualWebTrafficData extends AnnualDataBase {
  final int? visits;
  final int? uniqueVisitors;
  final double? avgSessionDuration;

  /// 构造函数
  const AnnualWebTrafficData({
    int? year,
    this.visits,
    this.uniqueVisitors,
    this.avgSessionDuration,
  }) : super(year: year);

  /// 从JSON映射创建AnnualWebTrafficData实例
  factory AnnualWebTrafficData.fromJson(Map<String, dynamic> json) {
    return AnnualWebTrafficData(
      year: json['year'],
      visits: json['visits'],
      uniqueVisitors: json['uniqueVisitors'],
      avgSessionDuration: json['avgSessionDuration']?.toDouble(),
    );
  }
}

/// 月度网络流量数据模型
class MonthlyWebTrafficData extends MonthlyDataBase {
  final int? visits;
  final int? bounceRate;
  final double? pagesPerSession;

  /// 构造函数
  const MonthlyWebTrafficData({
    int? month,
    this.visits,
    this.bounceRate,
    this.pagesPerSession,
  }) : super(month: month);

  /// 从JSON映射创建MonthlyWebTrafficData实例
  factory MonthlyWebTrafficData.fromJson(Map<String, dynamic> json) {
    return MonthlyWebTrafficData(
      month: json['month'],
      visits: json['visits'],
      bounceRate: json['bounceRate'],
      pagesPerSession: json['pagesPerSession']?.toDouble(),
    );
  }
}

/// 周度网络流量数据模型
class WeeklyWebTrafficData extends WeeklyDataBase {
  final int? visits;
  final int? newVisitorsPercentage;
  final int? mobilePercentage;

  /// 构造函数
  const WeeklyWebTrafficData({
    String? week,
    this.visits,
    this.newVisitorsPercentage,
    this.mobilePercentage,
  }) : super(week: week);

  /// 从JSON映射创建WeeklyWebTrafficData实例
  factory WeeklyWebTrafficData.fromJson(Map<String, dynamic> json) {
    return WeeklyWebTrafficData(
      week: json['week'],
      visits: json['visits'],
      newVisitorsPercentage: json['newVisitorsPercentage'],
      mobilePercentage: json['mobilePercentage'],
    );
  }
}