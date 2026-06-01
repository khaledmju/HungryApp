import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/custom_textField.dart';
import '../widgets/custom_auth_button.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
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

                  Gap(40),
                  CustomTextField(
                    controller: nameController,
                    hint: "Name",
                    isPassword: false,
                  ),
                  Gap(20),
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
                  Gap(20),
                  CustomTextField(
                    controller: confirmPasswordController,
                    hint: "Confirm Password",
                    isPassword: true,
                  ),
                  Gap(40),

                  CustomAuthButton(
                    text: "SingUp",
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
