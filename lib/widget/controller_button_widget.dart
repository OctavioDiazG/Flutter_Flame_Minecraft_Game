import 'package:flutter/material.dart';

class ControllerButtonWidget extends StatefulWidget {
  final String path; //the path where my asset is located
  final VoidCallback onPressed;
  const ControllerButtonWidget({Key? key, required this.path, required this.onPressed}) : super(key: key);

  @override
  State<ControllerButtonWidget> createState() => _ControllerButtonWidgetState();
}

class _ControllerButtonWidgetState extends State<ControllerButtonWidget> {
  bool isPressed = false; //bool for the buttons
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTapDown: (_){ //Redraw the widget when pressed 
          setState(() {
            isPressed = true;
            widget.onPressed();
          });
        },
        onTapUp: (_){
          setState(() {
            isPressed = false;
          });
        },
        child: Opacity(
          opacity: isPressed? 0.5 : 0.8,
          child: SizedBox(
            height: screenSize.width/20, 
            width: screenSize.width/20, 
            child: Image.asset(widget.path),
          ),
        ),
      ),
    );
  }
}