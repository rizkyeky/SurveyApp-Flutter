import 'package:flutter/material.dart';
import 'package:flash/flash.dart';

void showNetworkFlash(BuildContext context, {
    Duration duration,
    String text,
    Color color,
    FlashPosition flashPosition = FlashPosition.bottom,
}) {
  showFlash(
    context: context,
    duration: duration,
    builder: (context, controller) {
      return Flash(
        controller: controller,
        style: FlashStyle.grounded,
        boxShadows: kElevationToShadow[0],
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        position: flashPosition,
        backgroundColor: color ?? Colors.white,
        child: FlashBar(
          message: Text(text ?? '', style: const TextStyle(color: Colors.white),),
          primaryAction: TextButton(
            onPressed: () => controller.dismiss(), 
            child: const Text('DISMISS', style: TextStyle(
              color: Colors.white
            ),)),
        ),
      );
    },
  );
}