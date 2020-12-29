import 'dart:async';
import 'package:flutter/material.dart';

class ButtonAnimation extends StatefulWidget
{
  final Widget child;
  final int delayTime;
  static bool disableButton = false;

  const ButtonAnimation({Key key, this.delayTime, this.child})
      : super(key: key);

  @override
  _ButtonAnimationState createState() => _ButtonAnimationState();
}

class _ButtonAnimationState extends State<ButtonAnimation> with TickerProviderStateMixin
{
  AnimationController _controller;

  @override
  void initState()
  {
    super.initState();

    // initialize animation controller with a ticker
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    //  listen for status as we have programmed it based on the animation
    //  status
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          ButtonAnimation.disableButton = false;
        });
      } else {
        setState(() {
          ButtonAnimation.disableButton = true;
        });
      }
    });

  // ints are nullable by default
    if (widget.delayTime == null)
    {
      _controller.forward();
    }
    else
    {
      Timer(Duration(milliseconds: widget.delayTime), ()
      {
        _controller.forward();
      });
    }
  }

  @override
  void dispose()
  {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return ScaleTransition(
      scale: CurvedAnimation(
        curve: Interval(0.0, 1.0, curve: Curves.elasticOut),
        parent: _controller,
      ),
      child: widget.child,
    );
  }
}