import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final Widget child;
  final String? title;
  const BasePage({super.key,required this.child,this.title});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),automaticallyImplyLeading: true, title: title == null ? null : Text(title!)),
      body: child,
    );
  }


}
