import 'package:flutter/material.dart';
import 'package:td_flutter_unit/utils/ui_util.dart';

class Textinput extends StatelessWidget {
  const Textinput({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      //外围填充
      padding: EdgeInsets.symmetric(horizontal: context.screenWidth - (context.screenWidth * 0.8)), //前后填充，缩短框的长度
      child: Column(//垂直布局
          children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0), //上边部分填充
          child: TextField(
            style:
                const TextStyle(fontSize: 12, color: Colors.black87), //文字大小、颜色
            //输入组件
            decoration: InputDecoration(
              fillColor: Colors.grey[80], //背景颜色，
              filled: true, //必须设置为true，fillColor才有效
              isCollapsed: true, //相当于高度包裹的意思，必须设置为true
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15, vertical: 15), //内容内边距
              hintText: "Email",
              enabledBorder: OutlineInputBorder(
                  //设置输入框可编辑时的边框样式
                  borderRadius: BorderRadius.circular(20.0), //输入框圆角
                  borderSide:
                      const BorderSide(color: Colors.white, width: 0) //输入框白色隐藏

                  ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0), //输入框圆角
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0), //上边部分填充
          child: TextField(
            obscureText: true, //密码隐藏
            style:
                const TextStyle(fontSize: 12, color: Colors.black87), //文字大小、颜色
            //输入组件
            decoration: InputDecoration(
              fillColor: Colors.grey[80], //背景颜色，必须结合filled: true,才有效
              filled: true, //必须设置为true，fillColor才有效
              isCollapsed: true, //相当于高度包裹的意思，必须设置为true
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15, vertical: 15), //内容内边距，影响高度
              hintText: "Password",
              enabledBorder: OutlineInputBorder(
                  //设置输入框可编辑时的边框样式

                  borderRadius: BorderRadius.circular(20.0), //输入框圆角
                  borderSide:
                      const BorderSide(color: Colors.white, width: 0) //输入框白色隐藏

                  ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0), //输入框圆角
                  borderSide: const BorderSide(color: Colors.white, width: 0)),
            ),
          ),
        ),
      ]),
    );
  }
}