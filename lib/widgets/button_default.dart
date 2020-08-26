// @author Hoàng Phi Đại
// @version
// @link ff3105.github.io
// @created  $
// @Usage

import 'package:flutter/material.dart';

/// my vip pro button
/// how to use:
///ButtonDefault(
/// onTap: () => Navigator.pop(context),
/// text: Text("Cancel"),
/// decoration: BoxDecoration(
/// color: Colors.black26,
/// borderRadius: BorderRadius.circular(10))) should be 10 :)
class ButtonDefault extends StatefulWidget {
  final VoidCallback onTap;
  final Text text;
  final BoxDecoration decoration; // custom color button and radius...

  const ButtonDefault({
    @required this.onTap,
    @required this.text,
    this.decoration,
    Key key,
  }) : super(key: key);

  @override
  _ButtonDefaultState createState() => _ButtonDefaultState();
}

class _ButtonDefaultState extends State<ButtonDefault>
    with TickerProviderStateMixin {
  AnimationController _animCtrlBtn;

  static const duration = Duration(milliseconds: 50);
  static const double upperBoundValue = 0.1; // button animation value
  static const double kButtonW = 120;
  static const double kButtonH = 50;

  @override
  void initState() {
    _animCtrlBtn = AnimationController(
      vsync: this,
      duration: duration,
      lowerBound: 0,
      upperBound: upperBoundValue,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1 - _animCtrlBtn.value,
      child: GestureDetector(
        onTapUp: (g) => _animationButton(),
        onTapDown: (g) => _animationButton(),
        onTapCancel: _animationButton,
        onTap: widget.onTap,
        child: Container(
          width: kButtonW,
          height: kButtonH,
          decoration: widget.decoration ??
              BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: widget.text,
          ),
        ),
      ),
    );
  }

  void _animationButton() {
    _animCtrlBtn.isCompleted ? _animCtrlBtn.reverse() : _animCtrlBtn.forward();
  }
}
