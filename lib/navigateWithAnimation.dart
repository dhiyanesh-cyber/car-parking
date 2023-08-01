import 'package:flutter/material.dart';

enum AnimationType {
  defaultTransition,
  fade,
  slideUp,
  slideDown,
  scale,
  customSlide,
  rotate,
  size,
  flip,
  circularReveal,
  ripple,
  bounce, // New bounce animation
}

void navigateWithAnimation({
  required BuildContext context,
  required Widget Function() pageClass,
  required AnimationType animationType,
}) {
  PageRouteBuilder<dynamic> _getPageRoute(Widget Function() pageClass) {
    return PageRouteBuilder<dynamic>(
      transitionDuration: Duration(milliseconds: 370), // Reduce the transitionDuration for a faster effect
      pageBuilder: (context, animation, secondaryAnimation) => pageClass(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (animationType) {
          case AnimationType.fade:
            return FadeTransition(opacity: animation, child: child);
          case AnimationType.slideUp:
            return SlideTransition(
                position: Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
                    .animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
                child: child);
          case AnimationType.slideDown:
            return SlideTransition(
                position: Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset.zero)
                    .animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
                child: child);
          case AnimationType.scale:
            return ScaleTransition(scale: animation, child: child);
          case AnimationType.customSlide:
            // Replace with your custom animation implementation
            // Make the custom slide faster with a faster curve (e.g., Curves.easeOut)
            return SlideTransition(
                position: Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero)
                    .animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
                child: child);
          case AnimationType.rotate:
            return RotationTransition(turns: animation, child: child);
          case AnimationType.size:
            return SizeTransition(sizeFactor: animation, child: child);
          case AnimationType.flip:
            return RotationTransition(
                turns: animation,
                child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..scale(1.0, 1.0 - animation.value.abs()),
                    child: child));
          case AnimationType.circularReveal:
            final tween = Tween(begin: 0.0, end: 1.0);
            final curveAnimation =
                CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            return ScaleTransition(scale: tween.animate(curveAnimation), child: child);
          case AnimationType.ripple:
            // Assumes you're using the InkWell widget for ripple effect
            return child; // InkWell already has built-in ripple effect
          case AnimationType.bounce:
            // A cool bounce animation effect
            // Feel free to adjust the values for the bounce effect
            final animationValue =
                CurvedAnimation(parent: animation, curve: Curves.easeOutBack);
            return ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(animationValue),
              child: child,
            );
          case AnimationType.defaultTransition:
          default:
            return child; // Use default navigation transition
        }
      },
    );
  }

  Navigator.push(context, _getPageRoute(pageClass));
}
