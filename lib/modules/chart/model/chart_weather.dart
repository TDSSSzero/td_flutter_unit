import 'chart_base.dart';

/// 天气数据模型类
/// 用于解析和存储天气相关的图表数据
class ChartWeather extends ChartBase<WeatherData> {
  /// 构造函数
  const ChartWeather({WeatherData? data}) : super(data: data);
  static const String assetsPath = 'assets/chart_data/chart_data_weather.json';

  /// 从JSON映射创建ChartWeather实例
  factory ChartWeather.fromJson(Map<String, dynamic> json) {
    return ChartWeather(
      data: json['weatherData'] != null
          ? WeatherData.fromJson(json['weatherData'])
          : null,
    );
  }
  
  /// 获取天气数据
  WeatherData? get weatherData => data;
}

/// 天气数据容器类
/// 包含年度、月度和周度天气数据
class WeatherData extends ChartDataContainer<AnnualWeatherData, MonthlyWeatherData, WeeklyWeatherData> {
  /// 构造函数
  const WeatherData({List<AnnualWeatherData>? annual, List<MonthlyWeatherData>? monthly, List<WeeklyWeatherData>? weekly})
      : super(annual: annual, monthly: monthly, weekly: weekly);

  /// 从JSON映射创建WeatherData实例
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      annual: json['annual'] != null
          ? List<AnnualWeatherData>.from(
              json['annual'].map((x) => AnnualWeatherData.fromJson(x)))
          : null,
      monthly: json['monthly'] != null
          ? List<MonthlyWeatherData>.from(
              json['monthly'].map((x) => MonthlyWeatherData.fromJson(x)))
          : null,
      weekly: json['weekly'] != null
          ? List<WeeklyWeatherData>.from(
              json['weekly'].map((x) => WeeklyWeatherData.fromJson(x)))
          : null,
    );
  }
}

/// 年度天气数据模型
class AnnualWeatherData extends AnnualDataBase {
  final double? avgTemp;
  final int? maxTemp;
  final int? minTemp;
  final int? precipitation;

  /// 构造函数
  const AnnualWeatherData({
    int? year,
    this.avgTemp,
    this.maxTemp,
    this.minTemp,
    this.precipitation,
  }) : super(year: year);

  /// 从JSON映射创建AnnualWeatherData实例
  factory AnnualWeatherData.fromJson(Map<String, dynamic> json) {
    return AnnualWeatherData(
      year: json['year'],
      avgTemp: json['avgTemp']?.toDouble(),
      maxTemp: json['maxTemp'],
      minTemp: json['minTemp'],
      precipitation: json['precipitation'],
    );
  }
}

/// 月度天气数据模型
class MonthlyWeatherData extends MonthlyDataBase {
  final double? avgTemp;
  final int? rainyDays;
  final int? sunshineHours;

  /// 构造函数
  const MonthlyWeatherData({
    int? month,
    this.avgTemp,
    this.rainyDays,
    this.sunshineHours,
  }) : super(month: month);

  /// 从JSON映射创建MonthlyWeatherData实例
  factory MonthlyWeatherData.fromJson(Map<String, dynamic> json) {
    return MonthlyWeatherData(
      month: json['month'],
      avgTemp: json['avgTemp']?.toDouble(),
      rainyDays: json['rainyDays'],
      sunshineHours: json['sunshineHours'],
    );
  }
}

/// 周度天气数据模型
class WeeklyWeatherData extends WeeklyDataBase {
  final double? avgTemp;
  final int? maxTemp;
  final int? minTemp;
  final int? precipitation;

  /// 构造函数
  const WeeklyWeatherData({
    String? week,
    this.avgTemp,
    this.maxTemp,
    this.minTemp,
    this.precipitation,
  }) : super(week: week);

  /// 从JSON映射创建WeeklyWeatherData实例
  factory WeeklyWeatherData.fromJson(Map<String, dynamic> json) {
    return WeeklyWeatherData(
      week: json['week'],
      avgTemp: json['avgTemp']?.toDouble(),
      maxTemp: json['maxTemp'],
      minTemp: json['minTemp'],
      precipitation: json['precipitation'],
    );
  }
}