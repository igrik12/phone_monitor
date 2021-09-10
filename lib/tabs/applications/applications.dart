import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/applications.dart';
import 'package:phone_monitor/widgets/custom_card.dart';

class Applications extends StatefulWidget {
  const Applications({Key key}) : super(key: key);

  @override
  _ApplicationsState createState() => _ApplicationsState();
}

class _ApplicationsState extends State<Applications> {
  String filter = "";
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return GetX<ApplicationsController>(
      init: ApplicationsController(),
      autoRemove: false,
      builder: (appController) {
        if (appController.applications.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Application> filteredApps = _filterApps(
            appController.applications, appController.appType, filter);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomCard(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: isSearching
                      ? searchBar()
                      : buildAppSelectorRow(filteredApps, appController),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredApps.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () async {
                          return showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                  'Do you want to open ${filteredApps[index].appName}'),
                              actions: <Widget>[
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: const Text("Cancel"),
                                ),
                                OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    onPressed: () async {
                                      final canOpen = await DeviceApps.openApp(
                                          filteredApps[index].packageName);
                                      if (!canOpen) {
                                        Navigator.of(context).pop(true);
                                        Get.snackbar("Sorry",
                                            "This app cannot be opened",
                                            snackPosition:
                                                SnackPosition.BOTTOM);
                                        return;
                                      }
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text("Open")),
                              ],
                            ),
                          );
                        },
                        child: ListTile(
                            title: Text(
                                '${filteredApps[index].appName} (${filteredApps[index].packageName})'),
                            subtitle: Text(
                                'Version: ${filteredApps[index].versionName}\n'
                                'System app: ${filteredApps[index].systemApp}\n'
                                'Installed: ${DateTime.fromMillisecondsSinceEpoch(filteredApps[index].installTimeMillis).toString()}\n'
                                'Updated: ${DateTime.fromMillisecondsSinceEpoch(filteredApps[index].updateTimeMillis).toString()}'),
                            leading: filteredApps[index] is ApplicationWithIcon
                                ? CircleAvatar(
                                    backgroundImage: MemoryImage(
                                        (filteredApps[index]
                                                as ApplicationWithIcon)
                                            .icon),
                                  )
                                : null),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Row buildAppSelectorRow(
      List<Application> filteredApps, ApplicationsController appController) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text("${filteredApps.length}",
            style: Get.theme.textTheme.bodyText2.copyWith(fontSize: 14)),
        const SizedBox(
          width: 30,
        ),
        Obx(() => DropdownButton(
              value: appController.appType,
              items: [
                DropdownMenuItem(
                    child: Text(AppType.all.displayValue,
                        style: Get.theme.textTheme.bodyText1
                            .copyWith(fontSize: 16)),
                    value: AppType.all),
                DropdownMenuItem(
                  child: Text(AppType.user.displayValue,
                      style:
                          Get.theme.textTheme.bodyText1.copyWith(fontSize: 16)),
                  value: AppType.user,
                ),
                DropdownMenuItem(
                  child: Text(AppType.system.displayValue,
                      style:
                          Get.theme.textTheme.bodyText1.copyWith(fontSize: 16)),
                  value: AppType.system,
                )
              ],
              onChanged: (value) {
                appController.setAppType(value);
              },
            )),
        Expanded(
          child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(context).textTheme.bodyText2.color,
                  ),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  })),
        )
      ],
    );
  }

  List<Application> _filterApps(
      List<Application> applications, AppType appType, String filter) {
    switch (appType) {
      case AppType.all:
        return applications
            .where((app) => app.appName.toLowerCase().contains(filter))
            .toList();
      case AppType.system:
        return applications
            .where((app) =>
                app.systemApp & app.appName.toLowerCase().contains(filter))
            .toList();
      case AppType.user:
        return applications
            .where((app) =>
                !app.systemApp & app.appName.toLowerCase().contains(filter))
            .toList();
      default:
        return [];
    }
  }

  searchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 1,
          child: TextField(
            autofocus: true,
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: 'Enter app name'),
            onChanged: (value) => setState(() {
              filter = value.toLowerCase();
            }),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.close,
            color: Theme.of(context).textTheme.bodyText2.color,
          ),
          onPressed: () {
            setState(() {
              isSearching = false;
              filter = "";
            });
          },
        )
      ],
    );
  }
}
