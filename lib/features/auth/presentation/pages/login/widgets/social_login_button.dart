import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialLoginButton extends StatelessWidget {
  final String icon;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const SocialLoginButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: 48,
          height: 48,
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            icon,
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }
}