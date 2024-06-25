import 'package:app_version_update/app_version_update.dart';
import 'package:flutter/material.dart';

void verifyVersion(BuildContext context ) async {
  await AppVersionUpdate.checkForUpdates(
    appleId: '284882215',
    playStoreId: 'com.rosa.cosmetics',
  ).then((result) async {
    if (result.canUpdate!) {
      await AppVersionUpdate.showAlertUpdate(
        appVersionResult: result,
        context: context,
        backgroundColor: Colors.grey[200],
        title: 'New version available',
        titleTextStyle: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 24.0),
        content: 'Would you like to update your application?',
        contentTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        updateButtonText: 'UPDATE',
        cancelButtonText: 'UPDATE LATER',
      );
    }
  });
}
