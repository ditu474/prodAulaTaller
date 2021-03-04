import 'package:flutter/material.dart';

class CustomSnackBar {
  const CustomSnackBar._();

  static void showSuccessSnackBar({
    @required BuildContext ctx,
    @required Widget leftWidget,
  }) {
    Scaffold.of(ctx)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: leftWidget),
              Icon(Icons.check_circle),
            ],
          ),
          backgroundColor: Colors.green,
        ),
      );
  }

  static void showLoadingSnackBar({
    @required BuildContext ctx,
    @required Widget leftWidget,
  }) {
    Scaffold.of(ctx)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: leftWidget),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
          backgroundColor: Colors.orange,
        ),
      );
  }

  static void showErrorSnackBar({
    @required BuildContext ctx,
    @required Widget leftWidget,
  }) {
    Scaffold.of(ctx)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: leftWidget),
              Icon(Icons.block),
            ],
          ),
          backgroundColor: Colors.red,
        ),
      );
  }
}
