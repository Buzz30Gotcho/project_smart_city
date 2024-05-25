/*
import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_dashboard/pages/pages.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 2.0,
          child: Container(
            padding: const EdgeInsets.all(normal_300),
            width: MediaQuery.of(context).size.width / 2.5,
            height: MediaQuery.of(context).size.height / 1.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                    child: Text("Proximity Dashboard.",
                        style: Theme.of(context).textTheme.displaySmall)),
                const SizedBox(height: large_100),

                /// Login Forms

                EditText(
                    hintText: "Email or Phone Number.",
                    prefixIcon: ProximityIcons.user,
                    onChanged: (value) {},
                    borderType: BorderType.top),
                EditText(
                    hintText: "Password.",
                    prefixIcon: ProximityIcons.password,
                    suffixIcon: isVisible
                        ? ProximityIcons.eye_off
                        : ProximityIcons.eye_on,
                    suffixOnPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    obscureText: !isVisible,
                    onChanged: (value) {},
                    borderType: BorderType.bottom),

                Padding(
                  padding: const EdgeInsets.only(
                      left: normal_100,
                      top: small_100,
                      right: normal_100,
                      bottom: normal_100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Text("Remember Me"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: normal_100),
                  child: PrimaryButton(
                      title: "Login",
                      buttonState: ButtonState.enabled,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      }),
                ),

                const SizedBox(height: normal_200)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

*/

// FREDERIC POUR LE SIMULATEUR ANDROID
import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_dashboard/pages/pages.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 2.0,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            width: MediaQuery.of(context).size.width / 1.5,
            height: MediaQuery.of(context).size.height / 1.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Text(
                    "Proximity Dashboard",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                const SizedBox(height: 20.0),

                /// Login Forms

                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Email or Phone Number",
                    prefixIcon: Icon(ProximityIcons.user),
                  ),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(ProximityIcons.password),
                    suffixIcon: IconButton(
                      icon: isVisible
                          ? Icon(ProximityIcons.eye_off)
                          : Icon(ProximityIcons.eye_on),
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !isVisible,
                  onChanged: (value) {},
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Text("Remember Me"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    child: Text("Login"),
                  ),
                ),

                const SizedBox(height: 20.0)
              ],
            ),
          ),
        ),
      ),
    );
  }
}


