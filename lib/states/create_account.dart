import 'package:akesocial/utility/my_constant.dart';
import 'package:akesocial/widgets/show_button.dart';
import 'package:akesocial/widgets/show_form.dart';
import 'package:akesocial/widgets/show_icon_button.dart';
import 'package:akesocial/widgets/show_image.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Account'),
        backgroundColor: MyConstant.primary,
      ),
      body: ListView(
        children: [
          newWidget(widget: newAvatar()),
          newWidget(
              widget: ShowForm(label: 'Name :', iconData: Icons.fingerprint)),
          newWidget(
              widget:
                  ShowForm(label: 'Email :', iconData: Icons.email_outlined)),
          newWidget(
              widget:
                  ShowForm(label: 'Password :', iconData: Icons.lock_outline)),
          newWidget(
              widget:
                  ShowButton(label: 'Create New Account', pressFunc: () {})),
        ],
      ),
    );
  }

  Row newWidget({required Widget widget}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          child: widget,
        ),
      ],
    );
  }

  Container newAvatar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 32),
      width: 250,
      height: 250,
      child: Stack(
        children: [
          Positioned(bottom: 0,right: 0,
            child: ShowIconButton(
              pressFunc: () {},
              iconData: Icons.add_a_photo,
            ),
          ),
          const ShowImage(
            path: 'images/avatar.png',
          ),
        ],
      ),
    );
  }
}
