// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesla_animation_app/constant/constanins.dart';

class TempButton extends StatelessWidget {
  const TempButton({
    super.key,
    required this.svgSrc,
    required this.title,
    this.isActive = false,
    required this.press,
    this.activeCooler = primaryColor,
  });

  final String svgSrc, title;
  final bool isActive;
  final VoidCallback press;
  final Color activeCooler;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOutBack,
            width: isActive ? 76 : 50,
            height: isActive ? 76 : 50,
            child: SvgPicture.asset(
              svgSrc,
              color: isActive ? activeCooler : Colors.white38,
            ),
          ),
          SizedBox(height: defaultPadding / 2),
          AnimatedDefaultTextStyle(
            duration: Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 18,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? activeCooler : Colors.white38,
            ),
            child: Text(
              isActive ? title.toUpperCase() : title.toLowerCase(),
            ),
          ),
        ],
      ),
    );
  }
}
