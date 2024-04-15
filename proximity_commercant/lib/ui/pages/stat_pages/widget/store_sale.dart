import 'package:flutter/src/foundation/key.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/config/values.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/widgets/forms/section_divider.dart';
import 'package:proximity/widgets/top_bar.dart';
import 'package:proximity_commercant/domain/order_repository/src/order_service.dart';
import 'package:proximity_commercant/domain/statistic_repository/models/store_sale.dart';
import 'package:proximity_commercant/domain/statistic_repository/models/store_sale.dart';

import 'package:proximity_commercant/domain/statistic_repository/src/Statistic_service.dart';

class StoreSaleWidget extends StatefulWidget {
  const StoreSaleWidget({Key? key}) : super(key: key);

  @override
  State<StoreSaleWidget> createState() => _StoreSaleWidgetState();
}

class _StoreSaleWidgetState extends State<StoreSaleWidget> {
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
                  localizations!.storeSales,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                buildBarChart(statiscService.storeSales!),
              ],
            ),
          ),
        ),
      );
    });
  }

  Column builstoreSalesBarChart(List<StoreSale> storeSales, int sales) {
    return Column(
      children: [
        //     buildDropdownButton(),

        const SizedBox(height: 20),
        buildBarChart(storeSales!),
        const SizedBox(height: 20),
      ],
    );
  }
/*
  Widget buildDropdownButton() {
    return DropdownButton<String>(
      value: selectedTimeRange,
      items: ['this week', 'this day', 'this month'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedTimeRange = newValue!;
          // Update salese data based on the selected time range
          updatesaleseData(selectedTimeRange);
        });

      },
    );
  }*/

  /* void updatesaleseData(String timeRange) {
    // Replace this logic with your actual data update based on the selected time range
    if (timeRange == 'this week') {
      StoreSaleData = {
        'Store A': 8000,
        'Store B': 9000,
        'Store C': 7500,
        'Store D': 10000,
      };
    } else if (timeRange == 'this day') {
      StoreSaleData = {
        'Store A': 2000,
        'Store B': 2500,
        'Store C': 1800,
        'Store D': 3000,
      };
    } else if (timeRange == 'this month') {
      StoreSaleData = {
        'Store A': 15000,
        'Store B': 18000,
        'Store C': 13500,
        'Store D': 20000,
      };
    }
  }*/

  Widget buildSummarySection(int sales) {
    // Replace the below values with your actual total sales and salese
    /*double totalSales =
        StoreSaleData.values.reduce((sum, element) => sum + element);*/

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Total Sales : \$${sales}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildBarChart(List<StoreSale> _storeSales) {
    return Container(
      height: 200,
      width: 350,
      child: BarChart(
        BarChartData(
          barGroups: _chartGroups(_storeSales),
          borderData: FlBorderData(
            border: const Border(bottom: BorderSide(), left: BorderSide()),
          ),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, titleMeta) {
                  int index = value.toInt();
                  if (index >= 0 && index < (_storeSales?.length ?? 0)) {
                    return Text(_storeSales![index].storeName);
                  }
                  return Text('');
                },
              ),
            ),
            /*leftTitles: AxisTitles(
                /*sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, titleMeta) {
                  int index = value.toInt();
                  if (index >= 0 && index < (_storeSales?.length ?? 0)) {
                    return Text(_storeSales![index]..toString());
                  }
                  return Text('');
                },
              ),*/
                ),*/
            topTitles: AxisTitles(),
            rightTitles: AxisTitles(),
          ),
        ),
      ),
    );
  }
}

SideTitles _bottomTitles(List<StoreSale> storeSales) {
  return SideTitles(
    showTitles: true,
    getTitlesWidget: (double value, TitleMeta titleMeta) {
      // Find the StoreSale object with the matching salese value
      StoreSale? matchingSales = storeSales.firstWhere(
        (storeSale) => storeSale.sales == value,
        //orElse: () => null,
      );

      if (matchingSales != null) {
        return Text(matchingSales.storeName);
      }

      return Text('');
    },
  );
}

/*

SideTitles _bottomTitles(List<StoreSale> storeSales) {
  return SideTitles(
    showTitles: true,
    getTitlesWidget: (value, TitleMeta titleMeta) {
      int index = storeSales.indexOf(value);
      if (index >= 0 && index < storeSales.length) {
        return Text(storeSales[index].storeName);
      }
      return Text('');
    },
  );
}*/

List<BarChartGroupData> _chartGroups(List<StoreSale>? StoreSales) {
  return StoreSales?.asMap().entries.map((entry) {
        final int index = entry.key;
        final StoreSale storeSale = entry.value;
        final double sale = storeSale.sales.toDouble();

        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: sale,
              // colors: [sale > 0 ? Colors.blue : Colors.red],
            ),
          ],
        );
      }).toList() ??
      [];
}
