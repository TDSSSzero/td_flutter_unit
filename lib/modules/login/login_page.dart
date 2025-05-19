import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:td_flutter_unit/modules/login/widget/text_input.dart';
import 'package:td_flutter_unit/pages/home_provider.dart';
import 'package:td_flutter_unit/utils/ui_util.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(ref.watch(curMenuItemProvider).name)),
      body: SingleChildScrollView(
        child: 
        Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 300),
          Text("Log in",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
          SizedBox(height: 10),
          Text("Hello! welcome"),
          SizedBox(height: 40),
          Textinput(),
          SizedBox(height: 40),
          Padding(
          //外围填充
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0), //四周填充10
          child: SelectionContainer.disabled(
            //文字不可选定，会影响按钮点击
            child: MaterialButton(
              color: const Color.fromARGB(255, 35, 102, 37), //按钮颜色
              textColor: Colors.white, //文本的颜色
              minWidth: 188, //最小的宽度 默认是 88
              height: 40, // 高度， 默认是 36
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: const Text("Let’s start"), //显示的文字
            ),
          )),
        ],
            ),),
      ));
  }


}