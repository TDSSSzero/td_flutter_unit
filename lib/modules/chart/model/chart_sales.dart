import 'chart_base.dart';

/// 销售数据模型类
/// 用于解析和存储销售相关的图表数据
class ChartSales extends ChartBase<SalesData> {
  /// 构造函数
  const ChartSales({SalesData? data}) : super(data: data);

  static const String assetsPath = 'assets/chart_data/chart_data_sales.json';

  /// 从JSON映射创建ChartSales实例
  factory ChartSales.fromJson(Map<String, dynamic> json) {
    return ChartSales(
      data: json['salesData'] != null
          ? SalesData.fromJson(json['salesData'])
          : null,
    );
  }
  
  /// 获取销售数据
  SalesData? get salesData => data;
}

/// 销售数据容器类
/// 包含年度、月度和周度销售数据
class SalesData extends ChartDataContainer<AnnualSalesData, MonthlySalesData, WeeklySalesData> {
  /// 构造函数
  const SalesData({List<AnnualSalesData>? annual, List<MonthlySalesData>? monthly, List<WeeklySalesData>? weekly})
      : super(annual: annual, monthly: monthly, weekly: weekly);

  /// 从JSON映射创建SalesData实例
  factory SalesData.fromJson(Map<String, dynamic> json) {
    return SalesData(
      annual: json['annual'] != null
          ? List<AnnualSalesData>.from(
              json['annual'].map((x) => AnnualSalesData.fromJson(x)))
          : null,
      monthly: json['monthly'] != null
          ? List<MonthlySalesData>.from(
              json['monthly'].map((x) => MonthlySalesData.fromJson(x)))
          : null,
      weekly: json['weekly'] != null
          ? List<WeeklySalesData>.from(
              json['weekly'].map((x) => WeeklySalesData.fromJson(x)))
          : null,
    );
  }
}

/// 年度销售数据模型
class AnnualSalesData extends AnnualDataBase {
  final int? revenue;
  final int? profit;
  final int? customers;

  /// 构造函数
  const AnnualSalesData({int? year, this.revenue, this.profit, this.customers})
      : super(year: year);

  /// 从JSON映射创建AnnualSalesData实例
  factory AnnualSalesData.fromJson(Map<String, dynamic> json) {
    return AnnualSalesData(
      year: json['year'],
      revenue: json['revenue'],
      profit: json['profit'],
      customers: json['customers'],
    );
  }
}

/// 月度销售数据模型
class MonthlySalesData extends MonthlyDataBase {
  final int? revenue;
  final int? orders;
  final int? avgOrderValue;

  /// 构造函数
  const MonthlySalesData({int? month, this.revenue, this.orders, this.avgOrderValue})
      : super(month: month);

  /// 从JSON映射创建MonthlySalesData实例
  factory MonthlySalesData.fromJson(Map<String, dynamic> json) {
    return MonthlySalesData(
      month: json['month'],
      revenue: json['revenue'],
      orders: json['orders'],
      avgOrderValue: json['avgOrderValue'],
    );
  }
}

/// 周度销售数据模型
class WeeklySalesData extends WeeklyDataBase {
  final int? revenue;
  final int? visits;
  final double? conversionRate;

  /// 构造函数
  const WeeklySalesData({String? week, this.revenue, this.visits, this.conversionRate})
      : super(week: week);

  /// 从JSON映射创建WeeklySalesData实例
  factory WeeklySalesData.fromJson(Map<String, dynamic> json) {
    return WeeklySalesData(
      week: json['week'],
      revenue: json['revenue'],
      visits: json['visits'],
      conversionRate: json['conversionRate']?.toDouble(),
    );
  }
}