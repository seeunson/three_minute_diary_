import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:three_minute_diary/controller/auth/signup_controller.dart';
import 'package:three_minute_diary/view/pages/auth_page/Login_page.dart';
import 'package:three_minute_diary/view/widget/custom_submit_button.dart';
import 'package:three_minute_diary/view/widget/custom_text_form_field.dart';
import 'package:validators/validators.dart';

class SignupPage extends GetView<SignupController> {
  const SignupPage({super.key});

  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('회원가입')),
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
                    //이름
                    CustomTextFormField(
                        controller: controller.nameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '이름을 확인해주세요.';
                          } else if (value.length < 3 || value.length > 10) {
                            return '이름은 3자 이상 10자 이하로 입력해주세요.';
                          }
                          return null;
                        },
                        hintText: 'Name',
                        icon: Icons.person),
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

                    //패스워드 확인
                    CustomTextFormField(
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '비밀번호를 입력해주세요.';
                          } else if (value.length < 6) {
                            return '비밀번호는 6자 이상 입력해주세요.';
                          } else if (value != controller.pwController.text) {
                            return '비밀번호와 일치하지 않습니다.';
                          }
                          //firebase 자체에서 비밀번호는 6자 이상 받도록 강제하고 있다.
                          return null;
                        },
                        hintText: 'Confirm Password',
                        icon: Icons.lock),
                    SizedBox(height: 40),
                  ],
                )),
            CustomSubmitButton(
              onPressed: () {
                controller.enableAutoValidation();
                final _form = controller.formKey.currentState;
                if (_form == null || !_form.validate()) {
                  return null;
                }

                print('회원가입 버튼 클릭');

                //회원가입 로직
                controller.handleSignupButton();
              },
              child: Text('회원가입'),
            ),
            SizedBox(height: 10),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SigninPage()));
                },
                child: Text(
                  '이미 계정이 있으신가요? 로그인 하기',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                )),
          ].reversed.toList(),
        ));
  }
}
