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
import 'package:hungry/shared/custom_text.dart';
import 'package:hungry/shared/custom_textField.dart';

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
        }
        setState(() => isLoading = false);
      } catch (e) {
        setState(() => isLoading = false);

        String errMas = "UnHandel Exception in Login";

        if (e is ApiError) {
          errMas = e.message;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            clipBehavior: Clip.none,
            elevation: 10,
            padding: const EdgeInsets.all(10),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red.shade900,
            margin: const EdgeInsets.only(bottom: 30, right: 20, left: 20),
            content: CustomText(
              text: errMas,
              textColor: Colors.white,
              textWeight: FontWeight.w600,
              textSize: 14,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: Column(
            children: [
              const Gap(200),
              SvgPicture.asset(
                "assets/logo/logo.svg",
                color: AppColors.primary,
              ),
              const Gap(10),
              CustomText(
                text: "Welcome Back, Discover Fast Food",
                textColor: AppColors.primary,
                textSize: 13,
                textWeight: FontWeight.w400,
              ),
              const Gap(60),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Gap(40),
                        CustomTextField(
                          controller: emailController,
                          hint: "Email Address",
                          isPassword: false,
                        ),
                        const Gap(20),
                        CustomTextField(
                          controller: passwordController,
                          hint: "Password",
                          isPassword: true,
                        ),
                        const Gap(40),

                        isLoading
                            ? const CupertinoActivityIndicator(
                          color: Colors.white,
                        )
                            : CustomAuthButton(
                          text: "Login",
                          color: Colors.transparent,
                          textColor: Colors.white,
                          onTap: login,
                        ),
                        const Gap(20),
                        CustomAuthButton(
                          text: "Create Account ?",
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupView(),
                              ),
                            );
                          },
                        ),
                        const Gap(20),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Root(),
                              ),
                            );
                          },
                          child: const CustomText(
                            text: "Continue as guest ?",
                            textColor: Colors.white,
                            textSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
