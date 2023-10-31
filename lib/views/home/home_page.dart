// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesla_animation_app/constant/constanins.dart';
import 'package:tesla_animation_app/model/tyrepsi.dart';
import 'package:tesla_animation_app/views/components/battery_status.dart';
import 'package:tesla_animation_app/views/components/door_lock.dart';
import 'package:tesla_animation_app/views/components/temp_details.dart';
import 'package:tesla_animation_app/views/components/tesla_buttom_navbar.dart';
import 'package:tesla_animation_app/views/components/tyres.dart';
import 'package:tesla_animation_app/views/components/tyres_psi_card.dart';
import 'package:tesla_animation_app/views/controller/home_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final HomeController _controller = HomeController();

  late AnimationController _batteryAnimationController;
  late Animation<double> _animationBattery, _animationBatteryStatus;

  late AnimationController _tempAnimationController;
  late Animation<double> _animationCarShift,
      _animationTempShowInfo,
      _animationCoolGlow;

  late AnimationController _tyreAnimetionController;
  late Animation<double> _animationTyre1Psi,
      _animationTyre2Psi,
      _animationTyre3Psi,
      _animationTyre4Psi;

  late List<Animation<double>> tyreAnimation;

  void setUpBatteryAnimation() {
    _batteryAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _animationBattery = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: Interval(0.0, 0.5),
    );
    _animationBatteryStatus = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: Interval(0.6, 1),
    );
  }

  void setUpTempAnimation() {
    _tempAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _animationCarShift = CurvedAnimation(
      parent: _tempAnimationController,
      curve: Interval(0.2, 0.4),
    );
    _animationTempShowInfo = CurvedAnimation(
      parent: _tempAnimationController,
      curve: Interval(0.45, 0.65),
    );
    _animationCoolGlow = CurvedAnimation(
      parent: _tempAnimationController,
      curve: Interval(0.7, 1),
    );
  }

  void setUpTyreAnimetion() {
    _tyreAnimetionController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    _animationTyre1Psi = CurvedAnimation(
      parent: _tyreAnimetionController,
      curve: Interval(0.34, 0.5),
    );
    _animationTyre2Psi = CurvedAnimation(
      parent: _tyreAnimetionController,
      curve: Interval(0.5, 0.66),
    );
    _animationTyre3Psi = CurvedAnimation(
      parent: _tyreAnimetionController,
      curve: Interval(0.66, 0.82),
    );
    _animationTyre4Psi = CurvedAnimation(
      parent: _tyreAnimetionController,
      curve: Interval(0.82, 1.0),
    );
  }

  @override
  void initState() {
    setUpBatteryAnimation();
    setUpTempAnimation();
    setUpTyreAnimetion();
    tyreAnimation = [
      _animationTyre1Psi,
      _animationTyre2Psi,
      _animationTyre3Psi,
      _animationTyre4Psi,
    ];
    super.initState();
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    _tempAnimationController.dispose();
    _tyreAnimetionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _controller,
        _batteryAnimationController,
        _tempAnimationController,
        _tyreAnimetionController,
      ]),
      builder: (context, _) {
        return Scaffold(
          bottomNavigationBar: TeslaButtomNavigationBar(
            opTap: (index) {
              if (index == 1)
                _batteryAnimationController.forward();
              else if (_controller.selectedBottomTab == 1 && index != 1)
                _batteryAnimationController.reverse(from: 0.7);

              if (index == 2)
                _tempAnimationController.forward();
              else if (_controller.selectedBottomTab == 2 && index != 2)
                _tempAnimationController.reverse(from: 0.4);

              if (index == 3)
                _tyreAnimetionController.forward();
              else if (_controller.selectedBottomTab == 3 && index != 3)
                _tyreAnimetionController.reverse(from: 0.4);

              _controller.showTyreController(index);
              _controller.tyreStatusController(index);
              _controller.onBottomNavigationBarChange(index);
            },
            selectedTap: _controller.selectedBottomTab,
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constrains) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: constrains.maxWidth,
                      height: constrains.maxHeight,
                    ),
                    // car
                    Positioned(
                      left: constrains.maxWidth / 2 * _animationCarShift.value,
                      width: constrains.maxWidth,
                      height: constrains.maxHeight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: constrains.maxHeight * 0.1,
                        ),
                        child: SvgPicture.asset(
                          width: double.infinity,
                          'assets/icons/Car.svg',
                        ),
                      ),
                    ),
                    // right door
                    AnimatedPositioned(
                      duration: defaultDuration,
                      right: _controller.selectedBottomTab == 0
                          ? constrains.minWidth * 0.05
                          : constrains.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isRightDoorLock,
                          press: _controller.updateRightDoorLock,
                        ),
                      ),
                    ),
                    // left door
                    AnimatedPositioned(
                      duration: defaultDuration,
                      left: _controller.selectedBottomTab == 0
                          ? constrains.minWidth * 0.05
                          : constrains.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isLeftDoorLock,
                          press: _controller.updateLeftDoorLock,
                        ),
                      ),
                    ),
                    // top door
                    AnimatedPositioned(
                      duration: defaultDuration,
                      top: _controller.selectedBottomTab == 0
                          ? constrains.maxHeight * 0.13
                          : constrains.maxHeight / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isBonnetDoorLock,
                          press: _controller.updateBonnetDoorLock,
                        ),
                      ),
                    ),
                    // bottom door
                    AnimatedPositioned(
                      duration: defaultDuration,
                      bottom: _controller.selectedBottomTab == 0
                          ? constrains.maxHeight * 0.17
                          : constrains.maxHeight / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isTrunkDoorLock,
                          press: _controller.updateTrunkDoorLock,
                        ),
                      ),
                    ),
                    // Battery
                    Opacity(
                      opacity: _animationBattery.value,
                      child: SvgPicture.asset(
                        'assets/icons/Battery.svg',
                        width: constrains.maxWidth * 0.45,
                      ),
                    ),
                    Positioned(
                      top: 50 * (1 - _animationBatteryStatus.value),
                      width: constrains.maxWidth,
                      height: constrains.maxHeight,
                      child: Opacity(
                        opacity: _animationBatteryStatus.value,
                        child: BatteryStatus(constrains: constrains),
                      ),
                    ),
                    // Temp
                    Positioned(
                      width: constrains.maxWidth,
                      height: constrains.maxHeight,
                      top: 60 * (1 - _animationTempShowInfo.value),
                      child: Opacity(
                        opacity: _animationTempShowInfo.value,
                        child: TempDetails(controller: _controller),
                      ),
                    ),
                    Positioned(
                      right: -180 * (1 - _animationCoolGlow.value),
                      child: AnimatedSwitcher(
                        duration: defaultDuration,
                        child: _controller.isCoolSelected
                            ? Image.asset(
                                'assets/images/Cool_glow_2.png',
                                width: 200,
                                key: UniqueKey(),
                              )
                            : Image.asset(
                                'assets/images/Hot_glow_4.png',
                                width: 200,
                                key: UniqueKey(),
                              ),
                      ),
                    ),

                    // Tyre
                    if (_controller.isShowTyre) ...ryres(constrains),
                    if (_controller.isShowTyreStatus)
                      GridView.builder(
                        itemCount: 4,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: defaultPadding,
                          mainAxisSpacing: defaultPadding,
                          childAspectRatio:
                              constrains.maxWidth / constrains.maxHeight,
                        ),
                        itemBuilder: (context, index) => ScaleTransition(
                          scale: tyreAnimation[index],
                          child: TyresPsiCard(
                            isButtomTwoType: index > 1,
                            tyrePsi: demoPsiList[index],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
