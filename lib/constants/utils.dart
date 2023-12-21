import 'package:flutter/cupertino.dart';

class Utils{

  double SCREEN_HEIGHT(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  double SCREEN_WIDTH(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

}