// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tesla_animation_app/constant/constanins.dart';
import 'package:tesla_animation_app/views/components/temp_button.dart';
import 'package:tesla_animation_app/views/controller/home_controller.dart';

class TempDetails extends StatelessWidget {
  const TempDetails({
    super.key,
    required HomeController controller,
  }) : _controller = controller;

  final HomeController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            child: Row(
              children: [
                TempButton(
                  svgSrc: 'assets/icons/coolShape.svg',
                  title: 'Cool',
                  isActive: _controller.isCoolSelected,
                  activeCooler: primaryColor,
                  press: _controller.updateCoolSelectedTab,
                ),
                SizedBox(width: defaultPadding),
                TempButton(
                  svgSrc: 'assets/icons/heatShape.svg',
                  title: 'heat',
                  activeCooler: redColor,
                  isActive: !_controller.isCoolSelected,
                  press: _controller.updateCoolSelectedTab,
                ),
              ],
            ),
          ),
          Spacer(),
          Column(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: Icon(Icons.arrow_drop_up, size: 48),
              ),
              Text(
                "20 " + "\u2103",
                style: TextStyle(
                  fontSize: 86,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: Icon(Icons.arrow_drop_down, size: 48),
              ),
            ],
          ),
          Spacer(),
          Text('current temperature'.toUpperCase()),
          SizedBox(height: defaultPadding),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Inside'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                  Text(
                    '20 ' + '\u2103',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              SizedBox(width: defaultPadding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Outside'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                  Text(
                    '35 ' + '\u2103',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
