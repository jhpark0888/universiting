import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universiting/constant.dart';

enum ButtonState {
  primary,
  secondary,
  negative,
  general,
  enabled,
}

class CustomButtonWidget extends StatelessWidget {
  CustomButtonWidget({
    required this.buttonTitle,
    required this.buttonState,
    required this.onTap,
    this.contentPadding
  });
  final String buttonTitle;
  final ButtonState buttonState;
  final VoidCallback onTap;
  EdgeInsetsGeometry? contentPadding;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: contentPadding ??const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 18,
        ),
        decoration: BoxDecoration(
            color: buttonColor(buttonState),
            borderRadius: BorderRadius.circular(16),
            border:
                Border.all(width: buttonState != ButtonState.enabled ? 1.6 : 0, color: buttonBorderColor(buttonState))),
        child: Text(
          buttonTitle,
          style: buttonTextStyle(buttonState),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Color buttonColor(ButtonState buttonState) {
    switch (buttonState) {
      case ButtonState.primary:
        return kPrimary;
      case ButtonState.secondary:
        return kBackgroundWhite;
      case ButtonState.negative:
        return kBackgroundWhite;
      case ButtonState.general:
        return kBackgroundWhite;
      case ButtonState.enabled:
        return kMainBlack.withOpacity(0.4);
      default:
        kMainBlack;
    }
    return kMainBlack;
  }

  TextStyle buttonTextStyle(ButtonState buttonState) {
    switch (buttonState) {
      case ButtonState.primary:
        return kActiveButtonStyle.copyWith(color: kMainWhite);
      case ButtonState.secondary:
        return kActiveButtonStyle.copyWith(color: kPrimary);
      case ButtonState.negative:
        return kActiveButtonStyle.copyWith(color: kErrorColor);
      case ButtonState.general:
        return kActiveButtonStyle;
      case ButtonState.enabled:
        return kInActiveButtonStyle.copyWith(
            color: kMainWhite);
      default:
        kActiveButtonStyle;
    }
    return kActiveButtonStyle;
  }

  Color buttonBorderColor(ButtonState buttonState) {
    switch (buttonState) {
      case ButtonState.primary:
        return kPrimary;
      case ButtonState.secondary:
        return kPrimary;
      case ButtonState.negative:
        return kErrorColor;
      case ButtonState.general:
        return kMainBlack;
      case ButtonState.enabled:
        return kMainBlack.withOpacity(0.4);
      default:
        kMainBlack;
    }
    return kMainBlack;
  }
}
