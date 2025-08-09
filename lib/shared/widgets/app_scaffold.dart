import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, this.top = true, this.bottom = true, this.left = true, this.right = true, required this.body, this.appBar, this.bottomNavigationBar});

  final bool top;
  final bool bottom;
  final bool left;
  final bool right;
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Scaffold(
        appBar: appBar,
        body: SizedBox(width: double.infinity, height: double.infinity, child: body),
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
