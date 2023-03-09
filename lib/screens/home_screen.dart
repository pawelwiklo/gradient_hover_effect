import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  double maxWidth = 500.0;
  // double maxWidth = double.infinity;
  double maxHeight = 80.0;
  Duration duration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    List items = ['Cool', 'Hover', 'Effect', 'Cool', 'Hover', 'Effect'];

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
                items.length,
                (index) => InfoRow(
                      duration: duration,
                      text: items[index],
                      maxWidth: maxWidth,
                      height: maxHeight,
                    )),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatefulWidget {
  const InfoRow({
    super.key,
    required this.duration,
    required this.text,
    required this.maxWidth,
    required this.height,
  });

  final Duration duration;
  final String text;
  final double maxWidth;
  final double height;

  @override
  State<InfoRow> createState() => _InfoRowState();
}

class _InfoRowState extends State<InfoRow> with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: widget.duration);

  late Animation widthAnim = Tween(
    begin: 0.0,
    end: widget.maxWidth,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.ease));

  Color textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: widthAnim,
          builder: (_, child) {
            return Container(
              width: widthAnim.value,
              height: widget.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.purple[200]!, Colors.amber],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
              ),
            );
          },
        ),
        MouseRegion(
          onEnter: onEnter,
          onExit: onExit,
          child: Container(
            width: widget.maxWidth,
            height: widget.height,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white60),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  widget.text,
                  style: GoogleFonts.righteous(
                      textStyle: TextStyle(color: textColor, fontSize: 50)),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void onEnter(PointerEvent details) {
    setState(() {
      _controller.forward();
      textColor = Colors.amber;
    });
  }

  void onExit(PointerEvent details) {
    setState(() {
      _controller.reset();
      textColor = Colors.white;
    });
  }
}
