import 'package:flaconi_weather/theme/colors.dart';
import 'package:flutter/material.dart';

class FlaconiCircleButton extends StatelessWidget {
  const FlaconiCircleButton({super.key, required this.onPressed, required this.icon, this.size});
  final Function() onPressed;
  final IconData icon;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 0.0,
      constraints: BoxConstraints.tightFor(
        width: size ?? 45,
        height: size ?? 45,
      ),
      shape: const CircleBorder(
        side: BorderSide(
          color: FlaconiColors.border,
          width: 1,
        ),
      ),
      fillColor: FlaconiColors.white,
      child: Icon(icon),
    );
  }
}
