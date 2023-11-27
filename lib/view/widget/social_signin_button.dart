import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialSigninButton extends StatelessWidget {
  final String assetName;
  final void Function()? onTap;
  const SocialSigninButton({super.key, required this.assetName, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(assetName),
    );
  }
}
