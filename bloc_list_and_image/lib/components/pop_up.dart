import 'package:bloc_list_and_image/models/image_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PopUpDialogs {
  static bool isDialogOpen = false;

  static Future<bool> openDialog({
    required ImageDetails imageDetails,
    required BuildContext context,
    required String title,
    required String message,
  }) async {
    if (PopUpDialogs.isDialogOpen) {
      debugPrint('Another dialog is already open.');
      return false;
    }
    PopUpDialogs.isDialogOpen = true;

    var result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      imageDetails.name,
                    ),
                  ],
                ),
                CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, progress) => Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                    ),
                  ),
                  imageUrl: imageDetails.image,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      imageDetails.text,
                    ),
                  ],
                ),
                ElevatedButton(onPressed: () => Navigator.pop(context, false), child: const Text('Close')),
              ],
            ),
          );
        });
    PopUpDialogs.isDialogOpen = false;
    if (result != null) {
      return result;
    } else {
      return false;
    }
  }
}
