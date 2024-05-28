import 'package:flutter/cupertino.dart';
import 'package:proximity_client/domain/data_persistence/src/boxes.dart';
import 'package:proximity_client/ui/pages/main_pages/view/main_screen.dart';


class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var credentialsBox = Boxes.getCredentials();
    final isFirsttime = credentialsBox.get('first_time');

    return const MainScreen(); //is_firstTime == null ? const WelcomeScreen() : const MainScreen();
  }
}
