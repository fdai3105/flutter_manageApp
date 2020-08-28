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
  final EdgeInsetsGeometry padding;
  final double width;
  final double height;
  final double boundValue;
  final Text text;
  final BoxDecoration decoration; // custom color button and radius...

  const ButtonDefault({
    @required this.onTap,
    @required this.text,
    this.decoration,
    this.padding,
    this.width,
    this.height,
    this.boundValue,
    Key key,
  }) : super(key: key);

  @override
  _ButtonDefaultState createState() => _ButtonDefaultState();
}

class _ButtonDefaultState extends State<ButtonDefault>
    with TickerProviderStateMixin {
  AnimationController _animCtrlBtn;

  static const duration = Duration(milliseconds: 50);

  @override
  void initState() {
    _animCtrlBtn = AnimationController(
      vsync: this,
      duration: duration,
      lowerBound: 0,
      upperBound: widget.boundValue ?? 0.1,
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
        onTapUp: (g) => _animationPrimaryUp(),
        onTapDown: (g) => _animationPrimaryDown(),
        onTapCancel: _animationPrimaryUp,
        onTap: widget.onTap,
        child: Container(
          width: widget.width ?? 120,
          height: widget.height ?? 50,
          padding: widget.padding,
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

  void _animationPrimaryUp() {
    _animCtrlBtn.reverse();
  }

  void _animationPrimaryDown() {
    _animCtrlBtn.forward();
  }
}
