import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:package_info/package_info.dart';
import 'package:phone_monitor/api/purchase_api.dart';
import 'package:phone_monitor/controllers/themeController.dart';
import 'package:phone_monitor/widgets/paywall_widget.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockInBackground = Get.isDarkMode;
  String theme = Get.isDarkMode ? 'Dark Theme' : 'Light Theme';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings UI')),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: 'Theme',
            tiles: [
              SettingsTile.switchTile(
                title: theme,
                leading: const Icon(Icons.phonelink_lock),
                switchValue: lockInBackground,
                onToggle: (bool value) {
                  setState(() {
                    lockInBackground = !lockInBackground;
                    theme = Get.isDarkMode ? 'Light Theme' : 'Dark Theme';
                    ThemeController.to.setThemeMode(
                        Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                  });
                },
              ),
            ],
          ),
          SettingsSection(
            title: 'Misc',
            tiles: [
              SettingsTile(
                  title: 'Rate',
                  leading: const Icon(Icons.star),
                  onPressed: (context) {
                    LaunchReview.launch(
                        androidAppId: "com.twarkapps.phone_monitor");
                  },
                  subtitle: "Please rate the app on Play Store"),
              SettingsTile(
                  title: 'Remove Ads',
                  leading: const Icon(Icons.star),
                  onPressed: (context) async {
                    await PurchaseApi.init();
                    final packages = await PurchaseApi.fetchOffers();
                    Get.bottomSheet(
                      PaywallWidget(
                        packages: packages
                            .map((offer) => offer.availablePackages)
                            .expand((pair) => pair)
                            .toList(),
                        title: "Remove ads",
                        description: "Remove ads and support developer ",
                        onClickedPackage: (package) async {
                          await PurchaseApi.purchasePackage(package);
                          Get.back();
                        },
                      ),
                    );
                  },
                  subtitle: "Remove ads and support the developer")
            ],
          ),
          CustomSection(
            child: Column(
              children: [
                const Padding(
                    padding: EdgeInsets.only(top: 22, bottom: 8),
                    child: Icon(
                      Icons.settings,
                      color: Color(0xFF777777),
                      size: 40,
                    )),
                FutureBuilder<PackageInfo>(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          'Version: ${snapshot.data.version}',
                          style: const TextStyle(color: Color(0xFF777777)),
                        );
                      }
                      return const Text(
                        'Version: N/A',
                        style: TextStyle(color: Color(0xFF777777)),
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
