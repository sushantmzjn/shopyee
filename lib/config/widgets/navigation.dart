import 'package:flutter/cupertino.dart';

void navigatePush(BuildContext context, Widget page) {
  Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
    return page;
  }));
}

void navigatePushReplacement(BuildContext context, Widget page) {
  Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) {
    return page;
  }));
}
