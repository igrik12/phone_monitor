import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:package_info/package_info.dart';
import 'package:phone_monitor/controllers/themeController.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockInBackground = Get.isDarkMode;
  String theme = Get.isDarkMode ? 'Dark Theme' : 'Light Theme';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings UI')),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: 'Theme',
            tiles: [
              SettingsTile.switchTile(
                title: theme,
                leading: Icon(Icons.phonelink_lock),
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
                  leading: Icon(Icons.star),
                  onTap: () => LaunchReview.launch(
                      androidAppId: "com.twarkapps.phone_monitor"),
                  subtitle: "Please rate the app on Play Store"),
            ],
          ),
          CustomSection(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 22, bottom: 8),
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
                          style: TextStyle(color: Color(0xFF777777)),
                        );
                      }
                      return Text(
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
