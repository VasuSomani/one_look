import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({Key? key}) : super(key: key);

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late Animation<double> _animation1;
  late Animation<double> _animation2;

  double _lastAnimation1Value = 0;
  double _lastAnimation2Value = 0;

  @override
  void initState() {
    _controller1 =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller2 =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _animation1 = Tween<double>(
            begin: 0 + _lastAnimation1Value, end: pi + _lastAnimation1Value)
        .animate(_controller1)
      ..addListener(() {
        _lastAnimation1Value = _animation1.value;
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller2.reset();
          _controller2.forward();
        }
      });

    _animation2 = Tween<double>(
            begin: 0 + _lastAnimation2Value, end: -pi + _lastAnimation2Value)
        .animate(_controller2)
      ..addListener(() {
        _lastAnimation2Value = _animation2.value;
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller1.reset();
          _controller1.forward();
        }
      });

    _controller1.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            AnimatedBuilder(
              animation: _controller1,
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.bottomCenter,
                  transform: Matrix4.identity()..rotateX(_animation1.value),
                  child: Image.asset('assets/images/logo_upper.png'),
                );
              },
            ),
            AnimatedBuilder(
              animation: _controller2,
              builder: (context, child) {
                return Transform(
                  transform: Matrix4.identity()..rotateX(_animation2.value),
                  child: Image.asset('assets/images/logo_lower.png'),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
