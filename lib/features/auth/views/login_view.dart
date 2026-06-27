import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/views/signup_view.dart';
import 'package:hungry/features/auth/widgets/custom_auth_button.dart';
import 'package:hungry/root.dart';
import 'package:hungry/shared/custom_snackBar.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:hungry/shared/custom_textField.dart';

import '../../../shared/custom_button.dart';
import '../../../shared/glass_container.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  AuthRepo authRepo = AuthRepo();

  bool isLoading = false;

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      try {
        final user = await authRepo.login(
          emailController.text.trim(),
          passwordController.text.trim(),
        );

        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Root()),
          );
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(customSnackBar("Login successful"));
        }
        setState(() => isLoading = false);
      } catch (e) {
        setState(() => isLoading = false);

        String errMas = "UnHandel Exception in Login";

        if (e is ApiError) {
          errMas = e.message;
        }

        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(errMas));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    emailController.text = "mohe@gmail.com";
    passwordController.text = "123456789";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: glassContainer(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: formKey,
            child: Column(
              children: [
                const Gap(140),
                Banner(
                  color: Colors.green.shade700,
                  message: 'Rich Sonic',
                  location: BannerLocation.topStart,
                  child: SvgPicture.asset(
                    'assets/logo/logo.svg',
                    color: Colors.white70,
                  ),
                ),
                const Gap(10),
                const CustomText(
                  text: 'Welcome Back, Discover The Fast Food',
                  textColor: Colors.white70,
                  textSize: 13,
                  textWeight: FontWeight.w500,
                ),
                const Gap(50),
                Column(
                  children: [
                    CustomTextField(
                      controller: emailController,
                      hint: 'Email Address',
                      isPassword: false,
                    ),
                    const Gap(10),
                    CustomTextField(
                      controller: passwordController,
                      hint: 'Password',
                      isPassword: true,
                    ),
                    const Gap(20),
                    CustomButton(
                      // height: 45,
                      // gap: 10,
                      text: 'Login',
                      color: Colors.white.withOpacity(0.9),
                      textColor: AppColors.primary,
                      widget: isLoading
                          ? CupertinoActivityIndicator(color: AppColors.primary)
                          : null,
                      onTap: login,
                    ),
                    const Gap(20),
                    Row(
                      children: [
                        Expanded(
                          child: CustomAuthButton(
                            text: 'Signup',
                            textColor: Colors.black,

                            onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SignupView(),
                              ),
                            ),
                          ),
                        ),
                        const Gap(15),
                        Expanded(
                          child: CustomAuthButton(
                            text: 'Guest',
                            // isIcon: true,
                            textColor: Colors.black,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => Root()),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(bottom: 55),
                  child: Center(
                    child: CustomText(
                      textSize: 12,
                      textColor: Colors.white,
                      text: '@RichSonic2025',
                      textWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Gap(30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
