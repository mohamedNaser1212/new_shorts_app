import 'package:flutter/material.dart';

enum NavigationAnimationType {
  normal,
  fading,
  rotation,
  scaling,
  sizing,
  sliding,
}

abstract class NavigationManager {
  const NavigationManager();

  static Future<void> navigateTo({
    required BuildContext context,
    required Widget screen,
    NavigationAnimationType navigationAnimationType =
        NavigationAnimationType.sliding,
  }) async {
    Navigator.push(
      context,
      _selectTransitionPageRoute(
        navigationAnimationType: navigationAnimationType,
        widget: screen,
      ),
    );
  }

  static void navigateAndFinishWithTransition({
    required BuildContext context,
    required Widget screen,
    NavigationAnimationType navigationAnimationType =
        NavigationAnimationType.sliding,
  }) {
    Navigator.pushReplacement(
      context,
      _selectTransitionPageRoute(
        widget: screen,
        navigationAnimationType: navigationAnimationType,
      ),
    );
  }

  static void navigateAndFinish({
    required BuildContext context,
    required Widget screen,
    NavigationAnimationType navigationAnimationType =
        NavigationAnimationType.sliding,
  }) {
    Navigator.pushAndRemoveUntil(
      context,
      _selectTransitionPageRoute(
        navigationAnimationType: navigationAnimationType,
        widget: screen,
      ),
      (route) => false,
    );
  }

  static Route _selectTransitionPageRoute({
    required NavigationAnimationType navigationAnimationType,
    required Widget widget,
  }) {
    switch (navigationAnimationType) {
      case NavigationAnimationType.fading:
        return FadeTransitionBuilder(page: widget);
      case NavigationAnimationType.rotation:
        return PageRotation(page: widget);
      case NavigationAnimationType.scaling:
        return PageScaleTransition(page: widget);
      case NavigationAnimationType.sizing:
        return SizeTransitionBuilder(page: widget);
      case NavigationAnimationType.sliding:
        return SlideTransitionBuilder(page: widget);
      default:
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}

// Transition PageRouteBuilders
class FadeTransitionBuilder extends PageRouteBuilder {
  final Widget page;
  FadeTransitionBuilder({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: Tween<double>(begin: 0, end: 1).animate(animation),
              child: child,
            );
          },
        );
}

class PageRotation extends PageRouteBuilder {
  final Widget page;
  PageRotation({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return RotationTransition(
              turns: Tween<double>(begin: 0, end: 1).animate(animation),
              child: child,
            );
          },
        );
}

class PageScaleTransition extends PageRouteBuilder {
  final Widget page;
  PageScaleTransition({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return ScaleTransition(
              scale: Tween<double>(begin: 0, end: 1).animate(animation),
              child: child,
            );
          },
        );
}

class SizeTransitionBuilder extends PageRouteBuilder {
  final Widget page;
  SizeTransitionBuilder({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SizeTransition(
              sizeFactor: animation,
              child: child,
            );
          },
        );
}

class SlideTransitionBuilder extends PageRouteBuilder {
  final Widget page;
  SlideTransitionBuilder({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}
