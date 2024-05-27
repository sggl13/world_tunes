
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {

  final VoidCallback? onPressed;
  EdgeInsets padding;
  BorderRadius? borderRadius;
  final double width;
  final double height;
  final Color primaryColor;
  final Color hoverColor;
  final Widget? text;
  final Widget? iconStart;
  final Widget? iconEnd;
  final double spacer;

  CustomButton({
    Key? key,
    required this.width,
    required this.height,
    required this.onPressed,
    required this.primaryColor,
    required this.hoverColor,
    BorderRadius? borderRadius,
    this.padding = EdgeInsets.zero,
    this.text,
    this.iconStart,
    this.iconEnd,
    this.spacer = 9.4,})
      : borderRadius = borderRadius ?? BorderRadius.circular(90), // Provide default here
        super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {

  late Color _backgroundColor;
  Color _borderColor = Colors.transparent;

  @override
  void initState() {
    _backgroundColor = widget.primaryColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _activeButton();
  }


  Widget _activeButton() {
    return MouseRegion(
        onEnter: (event) => _animateButton(enter: true),
        onExit: (event) => _animateButton(enter: false),
        child: GestureDetector(
          onTap: () {
            if (widget.onPressed != null) {
              widget.onPressed!();
            }
            setState(() {
              _borderColor = widget.primaryColor;
            });
          },
          child: Container(
            width: widget.width,
            height: widget.height,
            padding: widget.padding,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _backgroundColor,
              borderRadius: widget.borderRadius,
              border: Border.all(
                color: _borderColor,
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.iconStart != null) widget.iconStart!,
                if (widget.iconStart != null && widget.text != null) SizedBox(width: widget.spacer),
                if (widget.text != null) widget.text!,
                if (widget.iconEnd != null && widget.text != null) SizedBox(width: widget.spacer),
                if (widget.iconEnd != null) widget.iconEnd!,
              ],
            ),
          ),
        )
    );
  }


  void _animateButton({required bool enter}) {
    setState(() {
      _backgroundColor = enter ? widget.hoverColor : widget.primaryColor;
      _borderColor = Colors.transparent;
    });
  }
}




