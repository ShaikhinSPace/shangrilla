// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class ViewMoreViewLessButton extends StatefulWidget {
  final bool initialVisibility;
  final String showText;
  final String hideText;
  final Widget child;

  const ViewMoreViewLessButton({
    super.key,
    required this.initialVisibility,
    required this.showText,
    required this.hideText,
    required this.child,
  });

  @override
  _ViewMoreViewLessButtonState createState() => _ViewMoreViewLessButtonState();
}

class _ViewMoreViewLessButtonState extends State<ViewMoreViewLessButton> {
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    isVisible = widget.initialVisibility;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: isVisible,
          maintainState: true,
          maintainAnimation: true,
          child: widget.child,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
          child: Text(
            isVisible ? widget.hideText : widget.showText,
            style: const TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
