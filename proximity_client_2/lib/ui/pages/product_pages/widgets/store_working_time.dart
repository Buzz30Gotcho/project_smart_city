import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/config/values.dart';
import 'package:proximity_client/domain/store_repository/models/workingTime_model.dart';
import 'package:proximity_client/domain/store_repository/src/store_service.dart';
import 'package:proximity_client/ui/pages/store_pages/widgets/loading_skeletons/store_section_skeleton.dart';

class StoreWorkingTime extends StatelessWidget {
  const StoreWorkingTime({this.idStore, Key? key}) : super(key: key);
  final String? idStore;
  @override
  Widget build(BuildContext context) {
    String getWorkingTimeText(WorkingTime workingTime) {
      if (workingTime.option == 'fixed' &&
          workingTime.fixedHours != null &&
          workingTime.fixedHours!.isNotEmpty) {
        // Fixed working hours for all days
        final startTime =
            workingTime.fixedHours!.first.openTime!.format(context);
        final endTime =
            workingTime.fixedHours!.first.closeTime!.format(context);
        return 'Open from $startTime to $endTime';
      } else if (workingTime.option == 'custom' &&
          workingTime.customizedHours != null &&
          workingTime.customizedHours!.isNotEmpty) {
        // Customized working hours for specific days
        final days = workingTime.customizedHours!.keys.toList();
        final workingTimeText = StringBuffer();

        for (final day in days) {
          final ranges = workingTime.customizedHours![day]!;
          final timeRanges = ranges.map((range) {
            final startTime = range.openTime!.format(context);
            final endTime = range.closeTime!.format(context);
            return '$startTime - $endTime';
          }).join(', ');

          workingTimeText.writeln('$day: $timeRanges');
        }

        return workingTimeText.toString();
      }

      return 'No working hours available';
    }

    return Consumer<StoreService>(builder: (_, storeService, __) {
      ///  getWorkingHoursData(storeService.store!.workingTime!);
      print(storeService.store);
      print("store${storeService.store}");
      return storeService.store == null
          ? const StoreSectionSkeleton()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: small_100),
              child: Text(
                getWorkingTimeText(storeService.store!.workingTime!),
                style: const TextStyle(fontSize: 16),
              ));
    });
  }
}
