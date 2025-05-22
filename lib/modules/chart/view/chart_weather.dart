import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:td_flutter_unit/modules/base/base_page.dart';
import 'package:td_flutter_unit/modules/chart/model/chart_weather.dart';
import 'package:td_flutter_unit/modules/chart/provider/chart_provider.dart';
import 'package:td_flutter_unit/modules/chart/widget/chart_item.dart';

class ChartOfWeatherPage extends ConsumerStatefulWidget {
  const ChartOfWeatherPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChartOfWeatherPageState();
}

class _ChartOfWeatherPageState extends ConsumerState<ChartOfWeatherPage> {

  @override
  Widget build(BuildContext context) {
    final weatherData = ref.watch(chartWeatherProvider).value;
    return BasePage(
      title: '天气统计',
      child: Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ChartItem(chartItem: _buildLineChart(weatherData))
          ],
        ),
      ),
    ));
  }

  LineChart _buildLineChart(WeatherData? weatherData) {
    return LineChart(
            LineChartData(
              minY: 0,
              maxY: 40,
              minX: 0,
              maxX: 11,
              lineTouchData: LineTouchData(enabled: false),
              titlesData: FlTitlesData(
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false)
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false)
                ),
                bottomTitles: AxisTitles(
                  axisNameWidget: Text('2025', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  sideTitles: SideTitles(
                        showTitles: true,
                    reservedSize: 18,
                    interval: 1,
                    getTitlesWidget: _bottomTitleWidgets
                  )
                ),
                leftTitles: AxisTitles(
                  axisNameWidget: Text('temperature', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  sideTitles: SideTitles(
                    showTitles: true,
                        
                  )
                ),
              ),
              gridData: FlGridData(show: false),
              lineBarsData: [
                LineChartBarData(
                spots: weatherData?.monthly?.map((e) => FlSpot((e.month ?? 1) - 1.toDouble(), e.avgTemp?.toDouble() ?? 0)).toList() ?? [],
                isCurved: true,
                barWidth: 8,
                color: Colors.amber,
              belowBarData: BarAreaData(
                show: true,
                applyCutOffY: true,
              ),
              aboveBarData: BarAreaData(
                show: true,
                applyCutOffY: true,
              ),
              dotData: const FlDotData(
                show: false,
              ),

              )
              ]
            )
          );
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
        break;
      case 1:
        text = 'Feb';
        break;
      case 2:
        text = 'Mar';
        break;
      case 3:
        text = 'Apr';
        break;
      case 4:
        text = 'May';
        break;
      case 5:
        text = 'Jun';
        break;
      case 6:
        text = 'Jul';
        break;
      case 7:
        text = 'Aug';
        break;
      case 8:
        text = 'Sep';
        break;
      case 9:
        text = 'Oct';
        break;
      case 10:
        text = 'Nov';
        break;
      case 11:
        text = 'Dec';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      meta: meta,
      space: 4,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  
}