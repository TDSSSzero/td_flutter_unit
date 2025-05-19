import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:td_flutter_unit/modules/base/base_page.dart';
import 'package:td_flutter_unit/modules/chart/model/chart_sales.dart';
import 'package:td_flutter_unit/modules/chart/provider/chart_provider.dart';
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
    return BasePage(child: 
    Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildChartItem(context,_buildLineChart(salesData)),
            _buildChartItem(context,_buildBarChart(salesData)),
            _buildChartItem(context,_buildPieChart(salesData)),
          ],
        ),
      ),
    ));
  }
  
  int touchedIndex = -1;
  Widget _buildPieChart(SalesData? salesData) {
    // 计算monthly中所有orders的总和
    final totalOrders = salesData?.monthly?.fold<int>(0, (sum, item) =>sum + (item.orders ?? 0)) ?? 0;
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
        sections: List.generate(
          salesData?.monthly?.length ?? 0,
          (index){
            final isTouched = index == touchedIndex;
            final fontSize = isTouched ? 25.0 : 16.0;
            final radius = isTouched ? 60.0 : 50.0;
            return PieChartSectionData(
            color: Colors.blue,
            value: (salesData?.monthly?[index].orders?? 0) / totalOrders.toDouble(),
            title: '${salesData?.monthly?[index].month}月',
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

  SizedBox _buildChartItem(BuildContext context,Widget chartItem) {
    return SizedBox(
            width: context.screenWidth,
            height: context.screenHeight * 0.7,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: chartItem,
            ),
          );
  }

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