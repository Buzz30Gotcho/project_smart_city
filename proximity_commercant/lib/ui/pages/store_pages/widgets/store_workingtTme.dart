/*import 'package:flutter/material.dart';
import 'package:proximity/config/colors.dart';
import 'package:proximity/config/values.dart';
import 'package:proximity/widgets/buttons/icon_buttons.dart';
import 'package:proximity/widgets/buttons/tertiary_button.dart';
import 'package:proximity_commercant/domain/store_repository/models/timeRange_model.dart';

class TimeRangeUI extends StatefulWidget {
  @override
  _TimeRangeUIState createState() => _TimeRangeUIState();
}

class _TimeRangeUIState extends State<TimeRangeUI> {
  List<TimeRange> timeRanges = [];

  get storeCreationValidation => null;

  void addTimeRange() {
    setState(() {
      timeRanges
          .add(TimeRange(startTime: DateTime.now(), endTime: DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Column(
        children: [
          Expanded(
               MasonryGrid(
                  padding: const EdgeInsets.symmetric(
                      vertical: normal_100, horizontal: small_100),
                  column: 2,
                  children: [
                    ...List.generate(
                        productService.products!.length,
                        (index) => ProductCard(
                            product: productService.products![index]))
              itemBuilder: (context, index) {
                TimeRange timeRange = timeRanges[index];
                return 
                    Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: normal_100),
                        child: Row(children: [
                          Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: small_100),
                                  child: TimeButton(
                                    onPressed: (() async {
                                      storeCreationValidation.getStartTime(
                                          context,
                                          storeCreationValidation.openTime);
                                    }),
                                    /* selected:
                                    (storeCreationValidation.selfPickup ?? false),*/
                                    text: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: normal_100),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${storeCreationValidation.openTime?.hour.toString().padLeft(2, '0')}:${storeCreationValidation.openTime?.minute.toString().padLeft(2, '0')}',
                                            style:
                                                const TextStyle(fontSize: 15),
                                            textAlign: TextAlign.center,
                                          ),
                                          Icon(
                                            Icons.timer_outlined,
                                            size: normal_200,
                                            color: redSwatch.shade500,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))),
                          const Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: small_100),
                            child: Text(
                              ' To ',
                              style: const TextStyle(fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: small_100),
                                  child: TimeButton(
                                    onPressed: (() async {
                                      storeCreationValidation.getClosingTime(
                                          context,
                                          storeCreationValidation.closeTime);
                                    }),
                                    /* selected:
                                    (storeCreationValidation.selfPickup ?? false),*/
                                    text: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: normal_100),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${storeCreationValidation.closeTime?.hour.toString().padLeft(2, '0')}:${storeCreationValidation.closeTime?.minute.toString().padLeft(2, '0')}',
                                            style:
                                                const TextStyle(fontSize: 15),
                                            textAlign: TextAlign.center,
                                          ),
                                          Icon(
                                            Icons.timer_outlined,
                                            size: normal_200,
                                            color: redSwatch.shade500,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))),
                        ])),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TertiaryButton(
                onPressed: () {
                  addTimeRange();
                },
                title: 'Select Address.'),
          ),
        ],
      ),
    );
  }
}
*/