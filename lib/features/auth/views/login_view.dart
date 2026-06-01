import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/auth/widgets/custom_auth_button.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:hungry/shared/custom_textField.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Gap(100),
                  SvgPicture.asset("assets/logo/logo.svg"),
                  Gap(10),

                  CustomText(
                    text: "Welcome Back, Discover Fast Food",
                    textColor: Colors.white,
                    textSize: 13,
                    textWeight: FontWeight.w400,
                  ),

                  Gap(40),
                  CustomTextField(
                    controller: emailController,
                    hint: "Email Address",
                    isPassword: false,
                  ),
                  Gap(20),
                  CustomTextField(
                    controller: passwordController,
                    hint: "Password",
                    isPassword: true,
                  ),
                  Gap(40),

                  CustomAuthButton(
                    text: "Login",
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        print("object");
                      }
                    },
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
