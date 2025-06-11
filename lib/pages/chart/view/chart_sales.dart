import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:td_flutter_unit/pages/base/base_page.dart';
import 'package:td_flutter_unit/pages/chart/model/chart_sales.dart';
import 'package:td_flutter_unit/pages/chart/provider/chart_provider.dart';
import 'package:td_flutter_unit/pages/chart/widget/chart_item.dart';
import 'package:td_flutter_unit/pages/chart/widget/indicator.dart';
import 'package:td_flutter_unit/utils/ui_util.dart';

class ChartOfSalesPage extends ConsumerStatefulWidget {
  const ChartOfSalesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChartOfSalesPageState();
}

class _ChartOfSalesPageState extends ConsumerState<ChartOfSalesPage> {

  @override
  Widget build(BuildContext context) {
    final salesData = ref.watch(chartSalesProvider).value;
    return BasePage(
      title: '销售情况统计',
      child: 
    Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChartItem(chartItem: _buildLineChart(salesData)),
            ChartItem(chartItem:_buildBarChart(salesData)),
            ChartItem(chartItem: _buildPineArea(salesData)),
          ],
        ),
      ),
    ));
  }

  Widget _buildPineArea(SalesData? salesData){
    return Row(
      children: [
          const SizedBox(
            height: 18,
          ),
          Expanded(child: _buildPieChart(salesData)),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(
                salesData?.annual?.length ?? 0,
                (index) => Indicator(
                  color: _getPieChartColor(index),
                  text: '${salesData?.annual?[index].year}年',
                  isSquare: true,
                )),
            ],
          )
      ],
    );
  }

  Color _getPieChartColor(int index){
    switch (index) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.amber;
      case 2:
        return Colors.green;
      case 3:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
  
  int touchedIndex = -1;
  Widget _buildPieChart(SalesData? salesData) {
    // 计算monthly中所有orders的总和
    final totalCustomers = salesData?.annual?.fold<int>(0, (sum, item) =>sum + (item.customers ?? 0)) ?? 0;
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
        borderData: FlBorderData(show: false),
        sectionsSpace: 0,
        centerSpaceRadius: 40,
        sections: List.generate(
          salesData?.annual?.length ?? 0,
          (index){
            final isTouched = index == touchedIndex;
            final fontSize = isTouched ? 25.0 : 16.0;
            final radius = isTouched ? 60.0 : 50.0;
            Color color = _getPieChartColor(index);
            final value = (salesData?.annual?[index].customers?? 0) / totalCustomers.toDouble();
            return PieChartSectionData(
            color: color,
            value: value,
            // title: '${salesData?.annual?[index].year}年',
            title: '${(value * 100).toStringAsFixed(2)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          );
          }),
      )
    );
  }

  Widget _buildBarChart(SalesData? salesData) {
    return BarChart(
        BarChartData(
        gridData: FlGridData(show: false),
        titlesData: titlesData,
        barGroups: List.generate(salesData?.monthly?.length ?? 0,
         (index) => BarChartGroupData(
          x: index + 1,
          barRods: [
            BarChartRodData(
              toY: salesData?.monthly?[index].revenue?.toDouble()?? 0,
              color: Colors.blue,
              width: 20,
              borderRadius: BorderRadius.circular(4),
            )
          ]
          ),),
        
        )
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: (v,meta){
          return SideTitleWidget(space: 4, meta: meta, child: Text("${v.toInt()}月"));
        },
      ),
    ),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  LineChart _buildLineChart(SalesData? salesData) {
    return LineChart(
                LineChartData(
                  minX: 2019,
                  maxX: 2023,
                  minY: 0,
                  maxY: 3000,
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: _buildBottomTitle,
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false)
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false)
                    )
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: salesData?.annual?.map((e) => FlSpot(e.year?.toDouble() ?? 0, e.revenue?.toDouble() ?? 0)).toList()??[],
                    ),
                    LineChartBarData(
                      color: Colors.amber,
                      spots: salesData?.annual?.map((e) => FlSpot(e.year?.toDouble()?? 0, e.customers?.toDouble()?? 0)).toList()??[],
                    )
                  ],
                  
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: const Color(0xff37434d)),
                  ),
                  
                ),
              );
  }

  Widget _buildBottomTitle(double value,TitleMeta meta){
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    return SideTitleWidget(
      meta: meta,
      child: Text(value.toInt().toString(),style: style,),
    );
  }

}