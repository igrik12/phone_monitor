import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/res/custom_colors.dart';
import 'package:phone_monitor/res/fire_assets.dart';
import 'package:phone_monitor/screens/home.dart';
import 'package:phone_monitor/utils/g_authentication.dart';
import 'package:phone_monitor/widgets/custom_back_button.dart';
import 'package:phone_monitor/widgets/google_sign_in_button.dart';
import 'package:phone_monitor/widgets/rounded_button.dart';
import 'package:phone_monitor/widgets/sign_out_button.dart';

class GSignInScreen extends StatefulWidget {
  @override
  _GSignInScreenState createState() => _GSignInScreenState();
}

class _GSignInScreenState extends State<GSignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.firebaseNavy,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 20.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Image.asset(
                            FireAssets.phoneMonitorLogo,
                            height: 160,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Phone monitor',
                          style: TextStyle(
                            color: Palette.firebaseYellow,
                            fontSize: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder(
                    future:
                        GAuthentication.initializeFirebase(context: context),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error initializing Firebase');
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return GoogleSignInButton();
                      }
                      return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Palette.firebaseOrange,
                        ),
                      );
                    },
                  ),
                  SignOutButton()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
