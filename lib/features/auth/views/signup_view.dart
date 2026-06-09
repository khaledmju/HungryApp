import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/views/login_view.dart';
import 'package:hungry/shared/custom_snackBar.dart';

import '../../../core/constants/app_colors.dart';
import '../../../root.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/custom_textField.dart';
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

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                        isLoading
                            ? const CupertinoActivityIndicator(
                          color: Colors.white,
                        )
                            : CustomAuthButton(
                          text: "SignUp",
                          textSize: 16,
                          color: AppColors.primary,
                          textColor: Colors.white,
                          isBorder: false,
                          onTap: signUp,
                        ),
                        const Gap(20),

                        Row(
                          children: [
                            Expanded(
                              child: CustomAuthButton(
                                text: "Login",
                                textSize: 16,
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginView(),
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
