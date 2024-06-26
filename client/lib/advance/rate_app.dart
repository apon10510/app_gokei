import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:url_launcher/url_launcher.dart';

class AppRating {
  rateApp(BuildContext context) {
    final RateMyApp rateMyApp = RateMyApp(
      googlePlayIdentifier: 'com.rosa.cosmetics',
      minDays: 2,
      minLaunches: 3,
      remindDays: 2,
      remindLaunches: 2,
    );

    rateMyApp.init().then((_) {
      print('RateMyApp initialized');

      if (rateMyApp.shouldOpenDialog) {
        print('RateMyApp dialog should open');

        _showCustomRateDialog(context, rateMyApp);
      } else {
        print('RateMyApp dialog should not open');
      }
    }).catchError((error) {
      print('RateMyApp initialization error: $error');
    });
  }

  void _showCustomRateDialog(BuildContext context, RateMyApp rateMyApp) {
    int selectedStars = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enjoy Our App'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('If you like the app, please rate us on Google Play.'),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < selectedStars ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 25,
                    ),
                    onPressed: () async {
                      selectedStars = index + 1;
                      if (selectedStars >= 4) {
                        _launchURL(rateMyApp.googlePlayIdentifier!);
                        rateMyApp
                            .callEvent(RateMyAppEventType.rateButtonPressed);
                        Navigator.pop(context);
                      } else {
                        rateMyApp
                            .callEvent(RateMyAppEventType.laterButtonPressed);
                      }
                    },
                  );
                }),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Later'),
              onPressed: () {
                rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('No thanks'),
              onPressed: () {
                rateMyApp.callEvent(RateMyAppEventType.noButtonPressed);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _launchURL(String googlePlayIdentifier) async {
    final url =
        'https://play.google.com/store/apps/details?id=$googlePlayIdentifier';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
