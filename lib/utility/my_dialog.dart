// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:akesocial/widgets/show_image.dart';
import 'package:akesocial/widgets/show_listtile.dart';
import 'package:akesocial/widgets/show_text.dart';
import 'package:akesocial/widgets/show_text_button.dart';
import 'package:flutter/material.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  Future<void> twoWayAction({
    required String title,
    required String subTitle,
    String? label1,
    String? label2,
    Function()? pressFunc1,
    Function()? pressFunc2,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: ShowListtile(
          title: title,
          widget: const SizedBox(
              width: 80,
              child: ShowImage(
                path: 'images/avatar.png',
              )),
        ),
        content: ShowText(label: subTitle),
        actions: [
          pressFunc1 == null
              ? const SizedBox()
              : ShowTextButton(label: label1!, pressFunc: pressFunc1),
          pressFunc2 == null
              ? const SizedBox()
              : ShowTextButton(label: label2!, pressFunc: pressFunc2),
          ShowTextButton(
              label: pressFunc1 == null ? 'Ok' : 'Cancel',
              pressFunc: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
