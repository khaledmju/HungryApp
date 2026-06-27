import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/views/login_view.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_snackBar.dart';

import '../../../core/constants/app_colors.dart';
import '../../../root.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/custom_textField.dart';
import '../../../shared/glass_container.dart';
import '../widgets/custom_auth_button.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  AuthRepo authRepo = AuthRepo();

  bool isLoading = false;

  Future<void> signUp() async {
    if (formKey.currentState!.validate()) {
      try {
        setState(() => isLoading = true);
        final user = await authRepo.singUp(
          nameController.text,
          emailController.text,
          passwordController.text,
        );
        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Root()),
          );
        }
        setState(() => isLoading = false);
      } catch (e) {
        setState(() => isLoading = false);

        String msg = "UnHandle Error Sign Up page";

        if (e is ApiError) {
          msg = e.message;
        }

        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(msg));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: glassContainer(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Gap(140),
                    SvgPicture.asset(
                      'assets/logo/logo.svg',
                      color: Colors.white70,
                    ),
                    const Gap(10),
                    const Center(
                      child: CustomText(
                        text: 'Welcome to our Food App',
                        textColor: Colors.white70,
                      ),
                    ),
                    const Gap(40),
                    Column(
                      children: [
                        const Gap(30),
                        CustomTextField(
                          controller: nameController,
                          hint: 'Name',
                          isPassword: false,
                        ),
                        const Gap(8),
                        CustomTextField(
                          controller: emailController,
                          hint: 'Email Address',
                          isPassword: false,
                        ),
                        const Gap(8),
                        CustomTextField(
                          controller: passwordController,
                          hint: 'Password',
                          isPassword: true,
                        ),
                        const Gap(20),

                        /// Sign up
                        CustomButton(
                          // height: 45,
                          // gap: 10,
                          widget: isLoading
                              ? CupertinoActivityIndicator(
                                  color: AppColors.primary,
                                )
                              : null,
                          color: Colors.white,
                          textColor: AppColors.primary,
                          text: 'Sign up',
                          onTap: signUp,
                        ),

                        const Gap(20),
                        Row(
                          children: [
                            ///  Login
                            Expanded(
                              child: CustomAuthButton(
                                color: Colors.transparent,
                                textColor: Colors.white,
                                text: 'Login',
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (c) {
                                        return const LoginView();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                            const Gap(15),

                            /// Guest
                            Expanded(
                              child: CustomAuthButton(
                                color: Colors.transparent,
                                textColor: Colors.white,
                                text: 'Guest',
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (c) {
                                      return const Root();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Gap(240),
                    const CustomText(
                      text: '@RichSonic2025',
                      textColor: Colors.white,
                      textSize: 12,
                      textWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
