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

  @override
  void initState() {
    _controller1 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _controller2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _animation1 = Tween<double>(begin: 0, end: -1).animate(_controller1);
    _animation2 = Tween<double>(begin: 0, end: 1).animate(_controller2);

    _controller1.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller2.forward();
      } else if (status == AnimationStatus.dismissed) {
        _controller2.reverse();
      }
    });

    _controller2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller1.reverse();
      } else if (status == AnimationStatus.dismissed) {
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
        AnimatedBuilder(
          animation: _controller1,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.bottomCenter,
              transform: Matrix4.identity()..rotateX(_animation1.value * pi),
              child: Image.asset('assets/images/logo_upper.png'),
            );
          },
        ),
        AnimatedBuilder(
          animation: _controller2,
          builder: (context, child) {
            return Transform(
              transform: Matrix4.identity()..rotateX(_animation2.value * pi),
              child: Image.asset('assets/images/logo_lower.png'),
            );
          },
        ),
      ],
    );
  }
}
