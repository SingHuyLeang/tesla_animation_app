import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesla_animation_app/constant/constanins.dart';

class TeslaButtomNavigationBar extends StatelessWidget {
  TeslaButtomNavigationBar({
    Key? key,
    required this.selectedTap,
    required this.opTap,
  }) : super(key: key);

  final List<String> iconSvgScr = [
    'assets/icons/Lock.svg',
    'assets/icons/Charge.svg',
    'assets/icons/Temp.svg',
    'assets/icons/Tyre.svg',
  ];

  final int selectedTap;
  final ValueChanged<int> opTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: opTap,
      currentIndex: selectedTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      items: List.generate(
        iconSvgScr.length,
        (index) => BottomNavigationBarItem(
          icon: SvgPicture.asset(
            iconSvgScr[index],
            // ignore: deprecated_member_use
            color: index == selectedTap ? primaryColor : Colors.white54,
          ),
          label: '',
        ),
      ),
    );
  }
}
