// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:akesocial/utility/my_constant.dart';
import 'package:akesocial/widgets/show_text.dart';
import 'package:flutter/material.dart';

class ShowListtile extends StatelessWidget {
  final String title;
  final Widget widget;

  const ShowListtile({
    Key? key,
    required this.title,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget,
      title: ShowText(
        label: title,
        textStyle: MyConstant().h2Style(),
      ),
    );
  }
} //End Class

