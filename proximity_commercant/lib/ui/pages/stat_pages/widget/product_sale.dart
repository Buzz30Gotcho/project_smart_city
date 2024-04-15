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
import 'package:proximity_commercant/domain/statistic_repository/models/product_sale.dart';

import 'package:proximity_commercant/domain/statistic_repository/src/Statistic_service.dart';

class ProductSalesWidget extends StatefulWidget {
  const ProductSalesWidget({Key? key}) : super(key: key);

  @override
  State<ProductSalesWidget> createState() => _ProductSalesWidgetState();
}

class _ProductSalesWidgetState extends State<ProductSalesWidget> {
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
                            : builProductRevenuesBarChart(
                                statiscService.productSales!),
                      ]))));
    });
  }

  Widget builProductRevenuesBarChart(
    List<ProductSale> productsIncome,
  ) {
    return Column(
      children: [
        buildBarChart(productsIncome),
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
          // Update revenue data based on the selected time range
          updateRevenueData(selectedTimeRange);
        });
      },
    );
  }*/

  /* void updateRevenueData(String timeRange) {
    // Replace this logic with your actual data update based on the selected time range
    if (timeRange == 'this week') {
      storeRevenueData = {
        'Store A': 8000,
        'Store B': 9000,
        'Store C': 7500,
        'Store D': 10000,
      };
    } else if (timeRange == 'this day') {
      storeRevenueData = {
        'Store A': 2000,
        'Store B': 2500,
        'Store C': 1800,
        'Store D': 3000,
      };
    } else if (timeRange == 'this month') {
      storeRevenueData = {
        'Store A': 15000,
        'Store B': 18000,
        'Store C': 13500,
        'Store D': 20000,
      };
    }
  }*/

  Widget buildBarChart(List<ProductSale> productsIncome) {
    return Padding(
      padding: const EdgeInsets.all(normal_100),
      child: Container(
        height: 200,
        width: 350,
        child: BarChart(
          BarChartData(
            barGroups: _chartGroups(productsIncome),
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
                    if (index >= 0 && index < (productsIncome?.length ?? 0)) {
                      return Text(productsIncome![index].productName);
                    }
                    return Text('');
                  },
                ),
              ),
              /* leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, titleMeta) {
                    int index = value.toInt();
                    if (index >= 0 && index < (productsIncome?.length ?? 0)) {
                      return Text(productsIncome![index].toString());
                    }
                    return Text('');
                  },
                ),
              ),*/
              topTitles: AxisTitles(),
              rightTitles: AxisTitles(),
            ),
          ),
        ),
      ),
    );
  }

/*

SideTitles _bottomTitles(List<StoreRevenue> storesRevenues) {
  return SideTitles(
    showTitles: true,
    getTitlesWidget: (value, TitleMeta titleMeta) {
      int index = storesRevenues.indexOf(value);
      if (index >= 0 && index < storesRevenues.length) {
        return Text(storesRevenues[index].storeName);
      }
      return Text('');
    },
  );
}*/

  List<BarChartGroupData> _chartGroups(List<ProductSale>? productsSales) {
    return productsSales?.asMap().entries.map((entry) {
          final int index = entry.key;
          final ProductSale productSales = entry.value;
          final double numberOfSales = productSales.sales.toDouble();
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: numberOfSales,
                //colors: [Colors.blue],
              ),
            ],
          );
        }).toList() ??
        [];
  }
}
