import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PaywallWidget extends StatefulWidget {
  final String title;
  final String description;
  final List<Package> packages;
  final ValueChanged<Package> onClickedPackage;

  const PaywallWidget(
      {Key key,
      this.title,
      this.description,
      this.packages,
      this.onClickedPackage})
      : super(key: key);

  @override
  State<PaywallWidget> createState() => _PaywallWidgetState();
}

class _PaywallWidgetState extends State<PaywallWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: Get.height * 0.75),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(widget.title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode ? Colors.amber : Colors.white)),
            const SizedBox(
              height: 16,
            ),
            Text(widget.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: Get.isDarkMode ? Colors.amber : Colors.white)),
            const SizedBox(
              height: 16,
            ),
            buildPackages()
          ],
        ),
      ),
    );
  }

  Widget buildPackages() => ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: widget.packages.length,
      itemBuilder: (context, index) {
        final package = widget.packages[index];
        return buildPackage(context, package);
      });
  Widget buildPackage(BuildContext context, Package package) {
    final product = package.product;

    return Card(
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Theme(
          data: ThemeData.light(),
          child: ListTile(
            contentPadding: const EdgeInsets.all(8),
            title: Text(
              product.title,
              style: TextStyle(
                  fontSize: 18,
                  color: Get.isDarkMode ? Colors.black : Colors.white),
            ),
            subtitle: Text(
              product.priceString,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Get.isDarkMode ? Colors.black : Colors.white),
            ),
            onTap: () => widget.onClickedPackage(package),
          )),
    );
  }
}
