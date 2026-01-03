import 'package:flutter/material.dart';

class ScaffoldWithBackground extends StatelessWidget {
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool extendBodyBehindAppBar;

  const ScaffoldWithBackground({
    super.key,
    this.body,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.extendBodyBehindAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    print(
      'DEBUG: ScaffoldWithBackground building. Brightness: ${Theme.of(context).brightness}',
    );
    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: Stack(
        children: [
          // Premium Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.0, 0.4, 1.0],
                colors: Theme.of(context).brightness == Brightness.dark
                    ? [
                        const Color(0xFF121212), // Deep Matte Black
                        const Color(0xFF1E1E1E), // Dark Grey
                        const Color(0xFF121212), // Deep Matte Black
                      ]
                    : [
                        const Color(0xFFFAFAFA), // Off-white/Cream
                        const Color(0xFFF5F5F5), // Very light grey
                        const Color(0xFFEEEEEE), // Light grey
                      ],
              ),
            ),
          ),
          // Subtle Mesh/Noise overlay (Optional, keeping it simple for now)
          if (Theme.of(context).brightness == Brightness.dark)
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.03),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

          // Main Body
          if (body != null) body!,
        ],
      ),
    );
  }
}
