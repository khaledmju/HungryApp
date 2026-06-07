import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/features/auth/views/login_view.dart';

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
    GlobalKey<FormState> formKey = GlobalKey();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
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
                  text: "Welcome to our Food App",
                  textColor: AppColors.primary,
                  textSize: 13,
                  textWeight: FontWeight.w400,
                ),
                const Gap(100),

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
                            controller: nameController,
                            hint: "Name",
                            isPassword: false,
                          ),
                          const Gap(20),
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

                          CustomAuthButton(
                            text: "SingUp",

                            color: Colors.transparent,
                            textColor: Colors.white,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                              }
                            },
                          ),
                          const Gap(20),
                          CustomAuthButton(
                            text: "Go To Login",
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginView(),
                                ),
                              );
                            },
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
      ),
    );
  }
}
