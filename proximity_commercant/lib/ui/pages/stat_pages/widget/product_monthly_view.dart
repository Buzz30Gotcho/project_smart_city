import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:proximity/config/config.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity_commercant/domain/statistic_repository/src/Statistic_service.dart';

class ProductMonthlyViews extends StatelessWidget {
  const ProductMonthlyViews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Consumer<StatisticService>(
        builder: (context, statiscService, child) {
      return Padding(
          padding: const EdgeInsets.all(normal_100),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 4,
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localizations!.productSales,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        statiscService.productSales!.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(normal_100),
                                child: Row(
                                  children: [
                                    Container(
                                        child: Text(
                                            localizations!.noProductViewed +
                                                '${statiscService.period}')),
                                  ],
                                ))
                            : buildLineChart(statiscService.monthlyViews)
                      ]))));
    });
  }
}

Widget buildLineChart(Map<String, int> data) {
  final List<String> dates = data.keys.toList();
  final List<int> views = data.values.toList();

  return Container(
    height: 300,
    width: 350,
    child: LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: false,
          )),
          topTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: false,
          )),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, titleMeta) {
              int index = value.toInt();
              if (index >= 0 && index < dates.length) {
                return Text(dates![index]);
              }
              return Text('');
            },
          )),
          leftTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, titleMeta) {
              int viewValue = value.toInt();
              if (viewValue >= 0 &&
                  viewValue <= views.reduce((a, b) => a > b ? a : b)) {
                return Text(viewValue.toString());
              }
              return Text('');
            },
          )),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              dates.length,
              (index) => FlSpot(index.toDouble(), views[index].toDouble()),
            ),
            isCurved: true,
            color: Colors.blue, // You can change the line color here
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
        borderData: FlBorderData(
          show: false,
          // Set to false to hide the borders
        ),
        minX: 0,
        maxX: dates.length.toDouble() - 1,
        minY: 0,
        maxY: views.reduce((a, b) => a > b ? a : b).toDouble() + 2,
      ),
    ),
  );
}
