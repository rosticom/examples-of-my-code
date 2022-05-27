
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_point/view/page/new_post_page/new_post/controller/new_post_controller.dart';

class SubTitlePostSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  NewPostController _newPostController = Get.find(tag: "new_post_controller");
    return Obx(() => _newPostController.subTitlePost.value.isNotEmpty 
      ? Stack(
        children: [
          Container(
              width: Get.width,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
              decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _newPostController.subTitlePost.value,
                    style: TextStyle(
                      fontSize: 17,
                      letterSpacing: 0.32,
                      height: 1.27,
                      fontFamily: 'Roboto',
                      color: Theme.of(context).textTheme.headline6!.color
                  )),
            ],
          )),
          Positioned(
              right: -2,
              top: -1,
              child: RawMaterialButton(
                  constraints: BoxConstraints(minWidth: 30, minHeight: 30),
                  onPressed: () async { 
                    _newPostController.subTitlePost.value = "";
                    _newPostController.checkPostCompleted();
                    await Future.delayed(Duration(milliseconds: 100)).then((value) => _newPostController.scrollToBottom.value = !_newPostController.scrollToBottom.value);
                  },
                  elevation: 0.0,
                  child: Icon(
                    Icons.close_rounded,
                    color: Theme.of(context).secondaryHeaderColor,
                    size: 21.0,
                  ),
                  padding: EdgeInsets.all(5.0),
                  shape: CircleBorder(),
          )),
        ],
      )
      : SizedBox()
    );
  }
}