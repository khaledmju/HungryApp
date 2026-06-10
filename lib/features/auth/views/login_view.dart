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
          ScaffoldMessenger.of(context).showSnackBar(customSnackBar("Login successful"));
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
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Form(
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
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      bottom: 25,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffC8D0CF),
                      borderRadius: BorderRadius.circular(20),
                    ),
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
                                textSize: 16,
                                color: AppColors.primary,
                                textColor: Colors.white,
                                isBorder: false,
                                onTap: login,
                              ),
                        const Gap(20),
                        Row(
                          children: [
                            Expanded(
                              child: CustomAuthButton(
                                text: "SingUp",
                                textSize: 16,
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignupView(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const Gap(20),
                            Expanded(
                              child: CustomAuthButton(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Root(),
                                    ),
                                  );
                                },
                                text: "Guest",
                                textSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
