// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gap/gap.dart';
// import 'package:hungry/core/constants/app_colors.dart';
// import 'package:hungry/core/utils/pref_helper.dart';
// import 'package:hungry/features/auth/data/auth_repo.dart';
// import 'package:hungry/features/auth/views/login_view.dart';
// import 'package:hungry/root.dart';
//
// class SplashView extends StatefulWidget {
//   const SplashView({super.key});
//
//   @override
//   State<SplashView> createState() => _SplashViewState();
// }
//
// class _SplashViewState extends State<SplashView> {
//   AuthRepo authRepo = AuthRepo();
//
//   Future<void> _checkLogin() async {
//     final user = await authRepo.autoLogin();
//
//     if (user != null) {
//       Navigator.pushReplacement(
//         context,
//         PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) => const Root(),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return FadeTransition(opacity: animation, child: child);
//           },
//           transitionDuration: const Duration(milliseconds: 600),
//         ),
//       );
//     } else if (authRepo.isGuest) {
//       Navigator.pushReplacement(
//         context,
//         PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) => const Root(),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return FadeTransition(opacity: animation, child: child);
//           },
//           transitionDuration: const Duration(milliseconds: 600),
//         ),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) =>
//               const LoginView(),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return FadeTransition(opacity: animation, child: child);
//           },
//           transitionDuration: const Duration(milliseconds: 600),
//         ),
//       );
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     Future.delayed(const Duration(milliseconds: 2500), () {
//       _checkLogin();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primary,
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           // Cleanly pushes elements apart
//           children: [
//             const Gap(150),
//             // Reduced slightly to ensure it fits nicely on smaller screens
//
//             // 1. Logo Animation
//             TweenAnimationBuilder<double>(
//               tween: Tween<double>(begin: 0.0, end: 1.0),
//               duration: const Duration(milliseconds: 1000),
//               curve: Curves.easeOutCubic,
//               builder: (context, value, child) {
//                 return Opacity(
//                   opacity: value.clamp(0.0, 1.0), // Kept safe
//                   child: Transform.scale(
//                     scale: 0.8 + (value * 0.2),
//                     child: child,
//                   ),
//                 );
//               },
//               child: SvgPicture.asset("assets/logo/logo.svg"),
//             ),
//
//             // 2. Bottom Image Layout (Safe from overflowing)
//             Expanded(
//               child: Align(
//                 alignment: Alignment.bottomCenter,
//                 child: TweenAnimationBuilder<double>(
//                   tween: Tween<double>(begin: 0.0, end: 1.0),
//                   duration: const Duration(milliseconds: 1200),
//                   curve: Curves.easeOutBack,
//                   builder: (context, value, child) {
//                     return Opacity(
//                       // CRITICAL FIX: .clamp() stops the opacity error during the curve's bounce effect
//                       opacity: value.clamp(0.0, 1.0),
//                       child: Transform.translate(
//                         offset: Offset(0, 50 * (1 - value)),
//                         child: child,
//                       ),
//                     );
//                   },
//                   child: Image.asset(
//                     "assets/splash/splash.png",
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/root.dart';

import 'core/constants/app_colors.dart';
import 'features/auth/data/auth_repo.dart';
import 'features/auth/views/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;

  // AuthRepo authRepo = AuthRepo();
  // Future <void> _checkLogin () async {
  //   try {
  //     final user = await authRepo.autoLogin();
  //     if (!mounted) return;
  //
  //     if(authRepo.isGuest) {
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => Root()));
  //     } else if (authRepo.isLoggedIn) {
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => Root()));
  //     } else {
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => LoginView()));
  //     }
  //   } catch (e) {
  //     debugPrint('Auto login failed: $e');
  //     if (mounted) {
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginView()));
  //     }
  //   }
  // }

  AuthRepo authRepo = AuthRepo();

  Future<void> _checkLogin() async {
    try {
      final user = await authRepo.autoLogin();
      if (!mounted) return;
      if (authRepo.isGuest) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (c) => Root()),
        );
      } else if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (c) => Root()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (c) => LoginView()),
        );
      }
    } catch (e) {
      debugPrint('Auto login failed: $e');
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginView()),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 200),
          () => setState(() => _opacity = 1.0),
    );
    Future.delayed(const Duration(seconds: 1), _checkLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.9),
            AppColors.primary.withOpacity(0.8),
            AppColors.primary.withOpacity(0.7),
            AppColors.primary.withOpacity(0.6),
            AppColors.primary.withOpacity(0.5),
            AppColors.primary.withOpacity(0.4),
            AppColors.primary.withOpacity(0.3),
            AppColors.primary.withOpacity(0.2),
            AppColors.primary.withOpacity(0.1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.green.withOpacity(0.1).withAlpha(1),
        body: Center(
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: _opacity,
            curve: Curves.easeInOut,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Gap(280),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.8, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutBack,
                  builder:
                      (context, scale, child) =>
                      Transform.scale(scale: scale, child: child),
                  child: SvgPicture.asset('assets/logo/logo.svg'),
                ),

                const Spacer(),

                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 40, end: 0),
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOutCubic,
                  builder:
                      (context, value, child) => Transform.translate(
                    offset: Offset(0, value),
                    child: child,
                  ),
                  child: Image.asset('assets/splash/splash.png'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}