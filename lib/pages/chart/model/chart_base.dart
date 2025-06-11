/// 图表数据基础模型抽象类
/// 为所有图表数据模型提供统一的接口和结构
abstract class ChartBase<T> {
  final T? data;

  const ChartBase({this.data});

  /// 从JSON映射创建实例的抽象工厂方法
  /// 子类需要实现此方法以提供具体的解析逻辑
  factory ChartBase.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError('ChartBase.fromJson() 必须在子类中实现');
  }
}

/// 图表数据容器基础抽象类
/// 为所有图表数据容器提供统一的接口和结构
abstract class ChartDataContainer<A, M, W> {
  final List<A>? annual;
  final List<M>? monthly;
  final List<W>? weekly;

  const ChartDataContainer({this.annual, this.monthly, this.weekly});

  /// 从JSON映射创建实例的抽象工厂方法
  /// 子类需要实现此方法以提供具体的解析逻辑
  factory ChartDataContainer.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError('ChartDataContainer.fromJson() 必须在子类中实现');
  }
}

/// 年度数据基础抽象类
abstract class AnnualDataBase {
  final int? year;
  
  const AnnualDataBase({this.year});
}

/// 月度数据基础抽象类
abstract class MonthlyDataBase {
  final int? month;
  
  const MonthlyDataBase({this.month});
}

/// 周度数据基础抽象类
abstract class WeeklyDataBase {
  final String? week;
  
  const WeeklyDataBase({this.week});
}