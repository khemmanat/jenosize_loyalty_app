import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.top = true,
    this.bottom = true,
    this.left = true,
    this.right = true,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.statusBarColor = Colors.white,
    this.floatingActionButton,
  });

  final bool top;
  final bool bottom;
  final bool left;
  final bool right;
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Color statusBarColor;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return Container(
      color: statusBarColor,
      child: SafeArea(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
        child: Scaffold(
          appBar: appBar,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
          body: SizedBox(width: double.infinity, height: double.infinity, child: body),
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
        ),
      ),
    );
  }
}
