import 'package:app_gokai/feature/home/model/app_list_model.dart';
import 'package:flutter/material.dart';
import 'package:app_gokai/feature/home/widget/alert_dialog_button.dart';
import 'package:app_gokai/feature/home/widget/alert_dialog_field.dart';

class AddAppFloatingActionButton extends StatefulWidget {
  final AppListModel yourAppsListModel;

  const AddAppFloatingActionButton(this.yourAppsListModel, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddAppFloatingActionButtonState createState() =>
      _AddAppFloatingActionButtonState();
}

class _AddAppFloatingActionButtonState
    extends State<AddAppFloatingActionButton> {
  final TextEditingController appName = TextEditingController();
  final TextEditingController appImage = TextEditingController();
  final TextEditingController appUrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Add Your App'),
              content: SizedBox(
                height: 250,
                child: Column(
                  children: [
                    AlertDialogField(
                      hintText: 'App Name',
                      textEditingController: appName,
                    ),
                    AlertDialogField(
                      hintText: 'App Valid Image',
                      textEditingController: appImage,
                    ),
                    AlertDialogField(
                      hintText: 'App Link',
                      textEditingController: appUrl,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AlertDialogButton(
                          buttonText: 'Exit',
                          color: Colors.red,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        AlertDialogButton(
                          buttonText: 'Add',
                          onTap: () {
                            widget.yourAppsListModel.addApp({
                              'appName': appName.text,
                              'appImage': appImage.text,
                              'appUrl': appUrl.text,
                            });
                            appName.clear();
                            appImage.clear();
                            appUrl.clear();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
