import 'package:app_gokai/feature/setting/firebase/database.dart';
import 'package:app_gokai/feature/setting/widget/setting_field_button_widget.dart';
import 'package:app_gokai/feature/setting/widget/setting_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppsMissingAddPage extends StatefulWidget {
  const AppsMissingAddPage({super.key});

  @override
  State<AppsMissingAddPage> createState() => _AppsMissingAddPageState();
}

class _AppsMissingAddPageState extends State<AppsMissingAddPage> {
  final TextEditingController appsAdd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 239, 242),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 221, 239, 242),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'This apps are very new. So many apps are missing. You can help us by adding these missing apps ? We will add these apps in the next update.',
              style: GoogleFonts.acme(
                textStyle: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 15),
            SettingFieldWidget(
              hintText: 'Adds Missing App Name only',
              textEditingController: appsAdd,
            ),
            SizedBox(height: 15),
            SettingFieldButtonWidget(
              buttonText: 'Add',
              onTap: () async {
                Map<String, dynamic> addQuiz = {
                  'Apps': appsAdd.text,
                };
                await DataBaseMethods().addQuizCategory(addQuiz, 'Missing').then(
                  (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Upload Complate'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
