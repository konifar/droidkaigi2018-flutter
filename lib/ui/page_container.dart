import 'package:flutter/material.dart';

class PageContainer {
  PageContainer({
    this.title,
    this.icon,
    this.hasTab,
    this.body,
    TickerProvider tickerProvider,
  })
      : controller = new AnimationController(
          duration: kThemeAnimationDuration,
          vsync: tickerProvider,
        ) {
    _animation = new CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
  }

  final String title;
  final Widget icon;
  final bool hasTab;
  final ValueGetter<Widget> body;
  final AnimationController controller;
  CurvedAnimation _animation;

  FadeTransition transition() {
    return new FadeTransition(
      opacity: _animation,
      child: body(),
    );
  }
}
