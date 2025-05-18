import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {

  const CustomFilledButton({
    required this.text, super.key, 
    this.onPressed, 
    this.buttonColor,
  });

  final void Function()? onPressed;
  final String text;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {

    const radius = Radius.circular(10);

    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: buttonColor,
        shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: radius,
          bottomRight: radius,
          topLeft: radius,
        ),
      ),),
        
  
      onPressed: onPressed, 
      child: Text(text),
    );
  }
}