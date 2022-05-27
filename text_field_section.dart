
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:to_point/view/common/emoji.dart';
import 'package:to_point/view/page/new_post_page/new_post/controller/new_post_controller.dart';
import 'package:to_point/view/page/new_post_page/new_post/text_field_section/text_field.dart';

class TextSection extends StatefulWidget {

  @override
  State<TextSection> createState() => _TextSectionState();
}

class _TextSectionState extends State<TextSection> with SingleTickerProviderStateMixin {
  NewPostController _newPostController = Get.find(tag: "new_post_controller");
  bool animateBool = false;
  late AnimationController animateController;
  late Animation animation;
  bool emojiShowLocal = false;
  FocusNode _textFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    animateController = AnimationController(
        duration: Duration(milliseconds: 60),
        vsync: this
    );
    animateController.addListener(() {
      setState(() {});
    });
    animation = Tween(begin: 3.0, end: 22.0).animate(animateController);
    animateController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(         
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 3, right: 4, bottom: 1.5),
                  child: IconButton(
                      padding: EdgeInsets.all(0),
                      alignment: Alignment.center,
                      splashRadius: 14,
                      onPressed: () {
                          buttonClickEmoji();
                      },
                      icon: Transform.translate(
                        offset: Offset(emojiShowLocal ? -1 : 0, 0),
                        child: Container(
                            child: Icon(
                              !emojiShowLocal 
                              ? FontAwesomeIcons.faceSmile
                              : FontAwesomeIcons.keyboard,
                              color: Theme.of(context).textTheme.subtitle2!.color,
                              size: animation.value
                            ))),
                    ),
                ) ,
                Flexible(
                  child: InputTextField(_newPostController.textControllersPost.value, _textFocusNode, _tapTextCall, _textChangedCall),
                ),
                Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 14),
                    child: InkResponse(
                      child: Icon(
                        Icons.send,
                        color: _newPostController.textControllersPost.value.text.trim().isNotEmpty 
                          ? Colors.blue[300] : Theme.of(context).textTheme.subtitle2!.color,
                        size: 23,
                      ),
                      onTap: () async {
                        if (_newPostController.textControllersPost.value.text.trim().isNotEmpty) {
                          if (_newPostController.titlePost.value.isEmpty) {
                            _newPostController.titlePost.value = _newPostController.textControllersPost.value.text;
                           } else { _newPostController.subTitlePost.value = _newPostController.textControllersPost.value.text; }
                          _newPostController.textControllersPost.value.text = "";
                          await Future.delayed(Duration(milliseconds: 100)).then((value) 
                            => _newPostController.scrollToBottom.value = !_newPostController.scrollToBottom.value);
                        }
                      },
                    ),
                ),
              ],
            ),
        ),
        Offstage(
            offstage: !emojiShowLocal,
            child: SizedBox(
              height: 211,
              child: EmojiCommonWidget(_newPostController.textControllersPost.value, _emojiCallBack))
        )
      ],
    );
  }

  _emojiCallBack() {
    setState(() {});
  }

  _textChangedCall() {
    setState(() {});
  }
 
  _tapTextCall() async {
    if (emojiShowLocal) {
       emojiShowLocal = false;
       await animateController.reverse();
       setState(() {
        SystemChannels.textInput.invokeMethod('TextInput.show'); 
        animateController.forward();
       });
    }
  }

  buttonClickEmoji() async {
    FocusScope.of(context).requestFocus(_textFocusNode);
    _textFocusNode.consumeKeyboardToken();
    emojiShowLocal = !emojiShowLocal;
    if (emojiShowLocal) SystemChannels.textInput.invokeMethod('TextInput.hide'); 
      else SystemChannels.textInput.invokeMethod('TextInput.show'); 
    await animateController.reverse();
    setState(() {
      if (emojiShowLocal) SystemChannels.textInput.invokeMethod('TextInput.hide'); 
        else SystemChannels.textInput.invokeMethod('TextInput.show'); 
      animateController.forward();
    });
  }
}