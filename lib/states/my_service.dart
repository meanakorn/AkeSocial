import 'package:akesocial/models/post_model.dart';
import 'package:akesocial/models/user_model.dart';
import 'package:akesocial/states/authen.dart';
import 'package:akesocial/utility/my_constant.dart';
import 'package:akesocial/utility/my_dialog.dart';
import 'package:akesocial/widgets/show_form.dart';
import 'package:akesocial/widgets/show_icon_button.dart';
import 'package:akesocial/widgets/show_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyService extends StatefulWidget {
  const MyService({Key? key}) : super(key: key);

  @override
  State<MyService> createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  String? post;
  var user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;
  TextEditingController textEditingController = TextEditingController();
  var postModels = <PostModel>[];
  bool load = true;

  @override
  void initState() {
    super.initState();
    findUserModel();
    readAllPost();
  }

  Future<void> readAllPost() async {
    await FirebaseFirestore.instance
        .collection('post').orderBy('timePost', descending: true)
        .snapshots()
        .listen((event) {
      if (postModels.isNotEmpty) {
        postModels.clear();
      }

      for (var element in event.docs) {
        PostModel postModel = PostModel.fromMap(element.data());
        print('###post ==> ${postModel.postBody}');
        postModels.add(postModel);
      }

      load = false;
      setState(() {});
    });
  }

  Future<void> findUserModel() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get()
        .then((value) {
      userModel = UserModel.fromMap(value.data()!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Social'),
        backgroundColor: MyConstant.primary,
        actions: [
          ShowIconButton(
            iconData: Icons.exit_to_app,
            pressFunc: () {
              MyDialog(context: context).twoWayAction(
                  title: 'SignOut',
                  subTitle: 'Please SignOut for SignOut',
                  label1: 'SignOut',
                  pressFunc1: () {
                    processSignOut(context: context);
                  });
            },
            colorIcon: Colors.white,
          )
        ],
      ),
      body: Stack(
        children: [
          load ? Center(child: CircularProgressIndicator()) : listPost(),
          addPost(),
        ],
      ),
    );
  }

  Widget listPost() => Padding(
    padding: const EdgeInsets.only(bottom: 80),
    child: ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: postModels.length,
          itemBuilder: (context, index) => Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(postModels[index].urlAvatar),
                        ),
                        ShowText(label: postModels[index].namePost),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShowText(
                          label: postModels[index].postBody,
                          textStyle: MyConstant().h2Style(),
                        ),
                        ShowText(label: findTimePost(timePost: postModels[index].timePost)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
  );

  Column addPost() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ShowForm(
                  controller: textEditingController,
                  label: 'New Post',
                  iconData: Icons.post_add,
                  changeFunc: (String string) {
                    post = string.trim();
                  }),
              ShowIconButton(
                  iconData: Icons.send,
                  pressFunc: () {
                    if (post?.isEmpty ?? true) {
                      MyDialog(context: context).twoWayAction(
                          title: 'No Post', subTitle: 'Please Fill Post');
                    } else {
                      processAddPost();
                    }
                  }),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> processSignOut({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Authen(),
          ),
          (route) => false);
    });
  }

  Future<void> processAddPost() async {
    Timestamp timePost = Timestamp.fromDate(DateTime.now());

    PostModel postModel = PostModel(
        namePost: userModel!.name,
        postBody: post!,
        timePost: timePost,
        uidPost: user!.uid,
        urlAvatar: userModel!.urlAvatar);

    await FirebaseFirestore.instance
        .collection('post')
        .doc()
        .set(postModel.toMap())
        .then((value) {
      print('Add Post Success');
      textEditingController.text = '';
    });
  }

  String findTimePost({required Timestamp timePost}) {

    DateTime dateTime = timePost.toDate(); 
    DateFormat dateFormat = DateFormat('dd MMMM yyyy HH:mm');
    String result = dateFormat.format(dateTime);
    return result;
  }
 
}

