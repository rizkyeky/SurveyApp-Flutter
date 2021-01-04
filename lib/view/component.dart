import 'package:flutter/material.dart';
import 'package:flash/flash.dart';

void showNetworkFlash(BuildContext context, {
    String text,
    Color color,
    Color textColor,
    FlashPosition flashPosition = FlashPosition.bottom,
}) {
  showFlash(
    context: context,
    duration: const Duration(seconds: 2),
    builder: (context, controller) {
      return Flash(
        controller: controller,
        style: FlashStyle.grounded,
        boxShadows: kElevationToShadow[0],
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        position: flashPosition,
        backgroundColor: color ?? Colors.white,
        child: FlashBar(
          message: Text(text ?? '', style: TextStyle(color: textColor ?? Colors.white),),
          primaryAction: TextButton(
            onPressed: () => controller.dismiss(), 
            child: Text('DISMISS', style: TextStyle(
              color: textColor ?? Colors.white
            ),)),
        ),
      );
    },
  );
}