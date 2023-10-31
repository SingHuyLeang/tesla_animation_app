// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tesla_animation_app/constant/constanins.dart';
import 'package:tesla_animation_app/model/tyrepsi.dart';

class TyresPsiCard extends StatelessWidget {
  const TyresPsiCard({
    super.key,
    required this.isButtomTwoType,
    required this.tyrePsi,
  });
  final bool isButtomTwoType;
  final TyrePsi tyrePsi;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color:
            tyrePsi.isLowPressure ? redColor.withOpacity(0.2) : Colors.white10,
        border: Border.all(
            color: tyrePsi.isLowPressure
                ? redColor.withOpacity(0.2)
                : primaryColor,
            width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: isButtomTwoType
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tyrePsi.isLowPressure ? lowPressureText(context) : Text(''),
                Spacer(),
                psiText(context, psi: tyrePsi.psi.toString()),
                SizedBox(height: defaultPadding),
                Text(
                  '${tyrePsi.temp} \u2103',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                psiText(context, psi: tyrePsi.psi.toString()),
                SizedBox(height: defaultPadding),
                Text(
                  '${tyrePsi.temp} \u2103',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                tyrePsi.isLowPressure ? lowPressureText(context) : Text(''),
              ],
            ),
    );
  }

  Column lowPressureText(BuildContext context) {
    return Column(
      children: [
        Text(
          'low'.toUpperCase(),
          style: Theme.of(context).textTheme.headline3!.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
        ),
        Text(
          'Pressure'.toUpperCase(),
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  Text psiText(BuildContext context, {required String psi}) {
    return Text.rich(
      TextSpan(
        text: psi,
        style: Theme.of(context).textTheme.headline4!.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
        children: [
          TextSpan(
            text: 'psi',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
