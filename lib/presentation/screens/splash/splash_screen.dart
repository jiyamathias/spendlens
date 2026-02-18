// lib/presentation/screens/splash/splash_screen.dart (Updated to use provided images)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import '../../../core/theme/app_theme.dart';
import '../main/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.6, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MainScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF0A0E21,
      ), // Dark background matching the images
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF0A0E21),
                  const Color(0xFF0A0E21).withOpacity(0.8),
                  const Color(0xFF141A30),
                ],
              ),
            ),
          ),

          // Main content with logo
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Try to load the provided logo, fallback to styled text
                        _buildLogo(),
                        const SizedBox(height: 40),
                        // App Name with gradient
                        ShaderMask(
                          shaderCallback: (bounds) {
                            return LinearGradient(
                              colors: [
                                AppTheme.primaryBlue,
                                AppTheme.primaryPurple,
                              ],
                            ).createShader(bounds);
                          },
                          child: const Text(
                            'SpendLens',
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: -1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Financial Intelligence Engine',
                          style: TextStyle(
                            color: AppTheme.textSecondary.withOpacity(0.8),
                            letterSpacing: 2,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Loading indicator at bottom
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppTheme.primaryBlue.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    // Check if asset exists, otherwise create a styled version
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryBlue,
            AppTheme.primaryPurple,
            AppTheme.primaryOrange,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBlue.withOpacity(0.4),
            blurRadius: 40,
            spreadRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Image.asset(
          'assets/icons/app_icon.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Fallback to icon if image not found
            return const Center(
              child: Icon(Icons.visibility, size: 70, color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}

// // lib/presentation/screens/splash/splash_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../../core/theme/app_theme.dart';
// import '../main/main_screen.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     );
//
//     _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0, 0.5, curve: Curves.easeOut),
//       ),
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0, 0.5, curve: Curves.easeOutBack),
//       ),
//     );
//
//     _controller.forward();
//
//     Future.delayed(const Duration(seconds: 3), () {
//       Navigator.of(context).pushReplacement(
//         PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) =>
//               const MainScreen(),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return FadeTransition(opacity: animation, child: child);
//           },
//           transitionDuration: const Duration(milliseconds: 800),
//         ),
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               AppTheme.backgroundDark,
//               AppTheme.backgroundCard,
//               AppTheme.backgroundDark,
//             ],
//           ),
//         ),
//         child: Center(
//           child: AnimatedBuilder(
//             animation: _controller,
//             builder: (context, child) {
//               return FadeTransition(
//                 opacity: _fadeAnimation,
//                 child: ScaleTransition(
//                   scale: _scaleAnimation,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // Logo Container with glow effect
//                       Container(
//                         width: 140,
//                         height: 140,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           gradient: AppTheme.primaryGradient,
//                           boxShadow: [
//                             BoxShadow(
//                               color: AppTheme.primaryBlue.withOpacity(0.5),
//                               blurRadius: 40,
//                               spreadRadius: 10,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Icon(
//                             Icons.visibility,
//                             size: 70,
//                             color: Colors.white.withOpacity(0.9),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 40),
//                       // App Name
//                       ShaderMask(
//                         shaderCallback: (bounds) {
//                           return LinearGradient(
//                             colors: [
//                               AppTheme.primaryBlue,
//                               AppTheme.primaryPurple,
//                             ],
//                           ).createShader(bounds);
//                         },
//                         child: const Text(
//                           'SpendLens',
//                           style: TextStyle(
//                             fontSize: 42,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             letterSpacing: -1,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Text(
//                         'Financial Intelligence Engine',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: AppTheme.textSecondary.withOpacity(0.8),
//                           letterSpacing: 2,
//                         ),
//                       ),
//                       const SizedBox(height: 60),
//                       // Loading indicator
//                       SizedBox(
//                         width: 40,
//                         height: 40,
//                         child: CircularProgressIndicator(
//                           strokeWidth: 3,
//                           valueColor: AlwaysStoppedAnimation<Color>(
//                             AppTheme.primaryBlue.withOpacity(0.8),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
