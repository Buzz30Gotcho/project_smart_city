import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/config/colors.dart';
import 'package:proximity/config/values.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/widgets/forms/border_type.dart';
import 'package:proximity/widgets/forms/drop_down_selector.dart';
import 'package:proximity/widgets/forms/section_divider.dart';
import 'package:proximity/widgets/top_bar.dart';
import 'package:proximity_commercant/domain/order_repository/src/order_service.dart';
import 'package:proximity_commercant/domain/statistic_repository/models/region_view.dart';

import 'package:proximity_commercant/domain/statistic_repository/src/Statistic_service.dart';
import 'package:proximity_commercant/ui/pages/stat_pages/widget/coloredCard.dart';
import 'package:proximity_commercant/ui/pages/stat_pages/widget/convertion_rate.dart';
import 'package:proximity_commercant/ui/pages/stat_pages/widget/product_monthly_view.dart';
import 'package:proximity_commercant/ui/pages/stat_pages/widget/product_sale.dart';
import 'package:proximity_commercant/ui/pages/stat_pages/widget/product_view.dart';
import 'package:proximity_commercant/ui/pages/stat_pages/widget/region_sale.dart';
import 'package:proximity_commercant/ui/pages/stat_pages/widget/store_sale.dart';
import 'package:proximity_commercant/ui/pages/stat_pages/widget/store_view.dart';

import '../widget/region_view.dart';

class GlobalStatisticsScreen extends StatefulWidget {
  const GlobalStatisticsScreen({Key? key}) : super(key: key);

  @override
  _GlobalStatisticsScreenState createState() => _GlobalStatisticsScreenState();
}

class _GlobalStatisticsScreenState extends State<GlobalStatisticsScreen> {
  // Replace this map with your actual data for stores and revenue

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Consumer<StatisticService>(
      builder: (context, statiscService, child) {
        return Scaffold(
          body: SafeArea(
            child: DefaultTabController(
              length: 2, // Number of tabs
              child: Column(
                children: [
                  TopBar(title: localizations!.globalStatistics),
                  TabBar(
                    labelColor: Colors.black,
                    labelStyle: Theme.of(context).textTheme.labelLarge,
                    tabs: [
                      Tab(
                        icon: Icon(Icons.visibility),
                        text: localizations!.views,
                        // Set the desired text color here
                      ),
                      Tab(
                        icon: Icon(Icons.shopping_cart),
                        text: localizations!.sales,
                        // Set the desired text color here
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Tab 1 content: Views
                        _buildViewsTab(statiscService),
                        // Tab 2 content: Sales
                        _buildSalesTab(statiscService),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Build the content for the "Views" tab
  Widget _buildViewsTab(StatisticService statiscService) {
    final localizations = AppLocalizations.of(context);

    return ListView(
      children: [
        Row(
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(normal_100).copyWith(right: 0),
              child: Container(
                width: 150,
                child: DropDownSelector<String>(
                  // labelText: 'Product Category.',
                  hintText: '',
                  onChanged: statiscService.changeStatisticPeriod,
                  borderType: BorderType.middle,
                  savedValue: statiscService.period.toString(),
                  items: [
                    localizations!.week,
                    localizations!.day,
                    localizations!.month
                  ]
                      .map((item) => DropdownItem<String>(
                          value: item,
                          child: Text(item,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontWeight: FontWeight.w600))))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            ColoredCard(
              title: statiscService.totalViews.toString(),
              subTitle: localizations!.productViewed,
              cardColor: blueSwatch.shade100,
            ),
            ColoredCard(
              title: statiscService.totalSales.toString(),
              subTitle: localizations!.productSold,
              cardColor: blueSwatch.shade300,
            ),
          ],
        ),
        const StoreViewWidget(),
        const ProductsIncome(),
        ProductMonthlyViews(),
        RegionChart(
          totalViews: statiscService.totalViews,
          regionViews: statiscService.regionsViews!,
        ),
      ],
    );
  }

  // Build the content for the "Sales" tab
  Widget _buildSalesTab(StatisticService statiscService) {
    return ListView(
      children: [
        const StoreSaleWidget(),
        const ProductSalesWidget(),
        RegionSalesWidget(
          totalSales: statiscService.totalSales,
          regionSales: statiscService.regionsSales!,
        ),
      ],
    );
  }
}

ListView getWidgets(StatisticService statiscService, BuildContext context) {
  final localizations = AppLocalizations.of(context);
  return ListView(
    children: [
      TopBar(title: localizations!.globalStatistics),
      Row(
        children: [
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(normal_100).copyWith(right: 0),
            child: Container(
              width: 150,
              child: DropDownSelector<String>(
                // labelText: 'Product Category.',
                hintText: '',
                onChanged: statiscService.changeStatisticPeriod,
                borderType: BorderType.middle,
                savedValue: statiscService.period.toString(),
                items: [
                  localizations!.week,
                  localizations.day,
                  localizations.month
                ]
                    .map((item) => DropdownItem<String>(
                        value: item,
                        child: Text(item,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontWeight: FontWeight.w600))))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          ColoredCard(
            title: statiscService.totalViews.toString(),
            subTitle: localizations!.productViewed,
            cardColor: blueSwatch.shade100,
          ),
          ColoredCard(
            title: statiscService.totalSales.toString(),
            subTitle: localizations!.productSold,
            cardColor: blueSwatch.shade300,
          ),
        ],
      ),
      const StoreViewWidget(),
      const ProductsIncome(),
      RegionChart(
        totalViews: statiscService.totalViews,
        regionViews: statiscService.regionsViews!,
      ),
      const StoreSaleWidget(),
      const ProductSalesWidget(),
      RegionSalesWidget(
        totalSales: statiscService.totalSales,
        regionSales: statiscService.regionsSales!,
      ),

      /*   ConversionRateWidget(
                conversionRate:
                    statiscService.calculateProducyConversionRates()),*/
    ],
  );
}
