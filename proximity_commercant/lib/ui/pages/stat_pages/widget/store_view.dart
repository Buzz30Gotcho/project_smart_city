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
import 'package:proximity_commercant/domain/statistic_repository/models/store_view.dart';

import 'package:proximity_commercant/domain/statistic_repository/src/Statistic_service.dart';

class StoreViewWidget extends StatefulWidget {
  const StoreViewWidget({Key? key}) : super(key: key);

  @override
  State<StoreViewWidget> createState() => _StoreViewWidgetState();
}

class _StoreViewWidgetState extends State<StoreViewWidget> {
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
                  localizations!.storeViews,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                buildBarChart(statiscService.storeViews!),
              ],
            ),
          ),
        ),
      );
    });
  }

  Column builstoreViewsBarChart(List<StoreView> storeViews, int views) {
    return Column(
      children: [
        //     buildDropdownButton(),

        const SizedBox(height: 20),
        buildBarChart(storeViews!),
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
          // Update viewse data based on the selected time range
          updateviewseData(selectedTimeRange);
        });

      },
    );
  }*/

  /* void updateviewseData(String timeRange) {
    // Replace this logic with your actual data update based on the selected time range
    if (timeRange == 'this week') {
      StoreViewData = {
        'Store A': 8000,
        'Store B': 9000,
        'Store C': 7500,
        'Store D': 10000,
      };
    } else if (timeRange == 'this day') {
      StoreViewData = {
        'Store A': 2000,
        'Store B': 2500,
        'Store C': 1800,
        'Store D': 3000,
      };
    } else if (timeRange == 'this month') {
      StoreViewData = {
        'Store A': 15000,
        'Store B': 18000,
        'Store C': 13500,
        'Store D': 20000,
      };
    }
  }*/

  Widget buildSummarySection(int views) {
    final localizations = AppLocalizations.of(context);
    // Replace the below values with your actual total sales and viewse
    /*double totalSales =
        StoreViewData.values.reduce((sum, element) => sum + element);*/

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          localizations!.totalViews + '${views}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildBarChart(List<StoreView> _storeViews) {
    return Container(
      height: 200,
      width: 350,
      child: BarChart(
        BarChartData(
          barGroups: _chartGroups(_storeViews),
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
                  if (index >= 0 && index < (_storeViews?.length ?? 0)) {
                    return Text(_storeViews![index].storeName);
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
                  if (index >= 0 && index < (_storeViews?.length ?? 0)) {
                    return Text(_storeViews![index]..toString());
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

SideTitles _bottomTitles(List<StoreView> storeViews) {
  return SideTitles(
    showTitles: true,
    getTitlesWidget: (double value, TitleMeta titleMeta) {
      // Find the StoreView object with the matching viewse value
      StoreView? matchingViews = storeViews.firstWhere(
        (storeView) => storeView.views == value,
        //orElse: () => null,
      );

      if (matchingViews != null) {
        return Text(matchingViews.storeName);
      }

      return Text('');
    },
  );
}

/*

SideTitles _bottomTitles(List<StoreView> storeViews) {
  return SideTitles(
    showTitles: true,
    getTitlesWidget: (value, TitleMeta titleMeta) {
      int index = storeViews.indexOf(value);
      if (index >= 0 && index < storeViews.length) {
        return Text(storeViews[index].storeName);
      }
      return Text('');
    },
  );
}*/

List<BarChartGroupData> _chartGroups(List<StoreView>? StoreViews) {
  return StoreViews?.asMap().entries.map((entry) {
        final int index = entry.key;
        final StoreView storeView = entry.value;
        final double view = storeView.views.toDouble();

        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: view,
              // colors: [view > 0 ? Colors.blue : Colors.red],
            ),
          ],
        );
      }).toList() ??
      [];
}
