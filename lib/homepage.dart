import 'dart:ui';

import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stylish Snackbar'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton(
          // onPressed: () => showSnackbar(context),
          onPressed: () => showDynamicIslandSnackBar(context, 'Hello World'),
          child: Text(
            'Show Snackbar',
            style: TextStyle(color: Colors.red.shade900),
          ),
        ),
      ),
    );
  }

  void showDynamicIslandSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => DynamicIslandSnackBar(message: message),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 4), () {
      overlayEntry.remove();
    });
  }
}

class DynamicIslandSnackBar extends StatefulWidget {
  final String message;
  final Duration duration;
  final TextStyle? textStyle;

  const DynamicIslandSnackBar({
    super.key,
    required this.message,
    this.duration = const Duration(seconds: 3),
    this.textStyle,
  });

  @override
  createState() => _DynamicIslandSnackBarState();
}

class _DynamicIslandSnackBarState extends State<DynamicIslandSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _widthAnimation = Tween<double>(begin: 0, end: 450).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
    Future.delayed(widget.duration, () {
      if (mounted) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = widget.textStyle?.copyWith(
          fontSize: widget.textStyle?.fontSize ?? 14.0,
          fontWeight: widget.textStyle?.fontWeight ?? FontWeight.normal,
          letterSpacing: widget.textStyle?.letterSpacing ?? 0.0,
          wordSpacing: widget.textStyle?.wordSpacing ?? 0.0,
          color: widget.textStyle?.color ?? Colors.black,
          backgroundColor: widget.textStyle?.backgroundColor,
          decoration: widget.textStyle?.decoration ?? TextDecoration.none,
          decorationColor: widget.textStyle?.decorationColor ?? Colors.white,
          decorationStyle:
              widget.textStyle?.decorationStyle ?? TextDecorationStyle.solid,
          shadows: widget.textStyle?.shadows ?? [],
          overflow: widget.textStyle?.overflow ?? TextOverflow.clip,
        ) ??
        const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.0,
          wordSpacing: 0.0,
          color: Color.fromARGB(255, 0, 0, 0),
          backgroundColor: null,
          decoration: TextDecoration.none,
          decorationColor: Colors.white,
          decorationStyle: TextDecorationStyle.solid,
          shadows: [],
          overflow: TextOverflow.clip,
        );
    return SafeArea(
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: AnimatedBuilder(
          animation: _widthAnimation,
          builder: (context, child) {
            return Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 6, top: 40, right: 6),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: _widthAnimation
                        .value, // Control the max width of the snackbar
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: _widthAnimation.value,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 33, 255, 4)
                              .withOpacity(.4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Hello, Flutter!',
                          style: textStyle,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          textDirection: TextDirection.ltr,
                          softWrap: true,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
