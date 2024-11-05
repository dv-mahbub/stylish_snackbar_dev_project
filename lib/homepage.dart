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

  // void showSnackbar(BuildContext context) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Container(
  //         width: 300,
  //         height: 100,
  //         decoration: BoxDecoration(color: Colors.amber),
  //         child: Text('data'),
  //       ),
  //       backgroundColor: Colors.transparent,
  //       elevation: 0,
  //       duration: const Duration(seconds: 3),
  //       action: SnackBarAction(
  //         label: 'Undo',
  //         textColor: Colors.yellow,
  //         onPressed: () {
  //           // Code to execute when 'Undo' is tapped
  //         },
  //       ),
  //     ),
  //     snackBarAnimationStyle: AnimationStyle(
  //       curve: Curves.easeInCirc,
  //     ),
  //   );
  // }
}

class DynamicIslandSnackBar extends StatefulWidget {
  final String message;
  final Duration duration;

  const DynamicIslandSnackBar({
    super.key,
    required this.message,
    this.duration = const Duration(seconds: 3),
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
      duration: const Duration(milliseconds: 500),
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
    return SafeArea(
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: AnimatedBuilder(
          animation: _widthAnimation,
          builder: (context, child) {
            return Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Container(
                  width: _widthAnimation.value,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Hello, Flutter!',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0.0,
                      wordSpacing: 0.0,
                      color: Color.fromARGB(255, 255, 255, 255),
                      backgroundColor: null,
                      decoration: TextDecoration.none,
                      decorationColor: Colors.white,
                      decorationStyle: TextDecorationStyle.solid,
                      shadows: [],
                      overflow: TextOverflow.clip,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    textDirection: TextDirection.ltr,
                    softWrap: true,
                    // textScaler: 1.0,
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
