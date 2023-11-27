import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:three_minute_diary/controller/auth/signin_controller.dart';
import 'package:three_minute_diary/view/widget/custom_submit_button.dart';
import 'package:three_minute_diary/view/widget/custom_text_form_field.dart';
import 'package:validators/validators.dart';

class SigninPage extends GetView<SigninController> {
  const SigninPage({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('로그인'),
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          shrinkWrap: true,
          reverse: true,
          children: [
            Form(
                autovalidateMode: controller.autovalidateMode.value,
                key: controller.formKey,
                child: Column(
                  children: <Widget>[
                    //이메일
                    CustomTextFormField(
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !isEmail(value.trim())) {
                            return '이메일을 확인해주세요.';
                          }
                          return null;
                        },
                        hintText: 'Email',
                        icon: Icons.email),
                    SizedBox(height: 20),

                    //패스워드
                    CustomTextFormField(
                        controller: controller.pwController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '비밀번호를 확인해주세요.';
                          } else if (value.length < 6) {
                            return '비밀번호는 6자 이상 입력해주세요.';
                          }
                          //firebase 자체에서 비밀번호는 6자 이상 받도록 강제하고 있다.

                          return null;
                        },
                        hintText: 'Password',
                        icon: Icons.lock),

                    SizedBox(height: 20),
                  ],
                )),
            CustomSubmitButton(
              onPressed: () {
                final _form = controller.formKey.currentState;
                if (_form == null || !_form.validate()) {
                  return null;
                }

                //로그인 로직
                controller.handleSigninButton();
              },
              child: Text('로그인'),
            ),
            SizedBox(height: 10),
            TextButton(
                onPressed: () {},
                child: Text(
                  ' 계정이 없으신가요? 회원가입 하기',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                )),
            Row(
              children: [
                // SocialSigninButton(
                //     onTap: () async {
                //       User? user = await controller.handleGoogleSigninButton();
                //       if (user != null) {
                //         // 로그인 성공
                //         // 로그인 성공 후 처리
                //       }
                //     },
                //     assetName: 'asset/image/auth/btn_google.svg'),
              ],
            )
          ].reversed.toList(),
        ));
  }
}
