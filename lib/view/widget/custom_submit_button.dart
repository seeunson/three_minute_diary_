import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  const CustomSubmitButton({
    super.key,
    this.onPressed, // 여기에서 전달받은 onPressed를 사용
    required this.child,
  });

  final void Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, // 여기에 onPressed 함수를 할당
      child: child,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        textStyle: TextStyle(
          fontSize: 20,
        ),
        minimumSize: Size(350, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
