import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/data/user_model.dart';
import 'package:hungry/features/auth/views/login_view.dart';
import 'package:hungry/features/auth/widgets/custom_profile_textfield.dart';
import 'package:hungry/shared/custom_snackBar.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../shared/custom_text.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _deliveryAddress = TextEditingController();
  final TextEditingController _visa = TextEditingController();

  final AuthRepo authRepo = AuthRepo();
  UserModel? userModel;
  bool _isLoading = true;

  Future<void> getProfile() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final user = await authRepo.getProfile();

      setState(() {
        userModel = user;
        _name.text = userModel?.name ?? "";
        _email.text = userModel?.email ?? "";
        _deliveryAddress.text = userModel?.address ?? "";
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      String msg = "Error in profile";
      if (e is ApiError) {
        msg = e.message;
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(msg));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _deliveryAddress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppColors.primary,
      color: Colors.white,
      displacement: 60,
      onRefresh: () async => await getProfile(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Colors.white,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Icon(Icons.settings, color: AppColors.primary),
              ),
            ],
          ),

          body: Skeletonizer(
            enabled: _isLoading,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // Gap(200),

                    // Center(
                    //   child: Container(
                    //     height: 129,
                    //     width: 129,
                    //     decoration: BoxDecoration(
                    //       color: Colors.grey,
                    //       borderRadius: BorderRadius.circular(20),
                    //       border: Border.all(color: Colors.white, width: 5),
                    //     ),
                    //     child: _isLoading
                    //         ? const SizedBox.shrink()
                    //         : Image.network(userModel!.image!),
                    //   ),
                    // ),
                    Center(
                      child: _isLoading
                          ? const CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                            )
                          : CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(userModel!.image!),
                            ),
                    ),
                    const Gap(30),
                    CustomProfileTextField(
                      controller: _name,
                      labelText: "Name",
                    ),
                    const Gap(30),
                    CustomProfileTextField(
                      controller: _email,
                      labelText: "Email",
                    ),
                    const Gap(30),
                    CustomProfileTextField(
                      controller: _deliveryAddress,
                      labelText: "Delivery address",
                    ),
                    const Gap(30),
                    const Divider(),
                    const Gap(30),

                    userModel?.visa == null || userModel!.visa!.isEmpty
                        ? CustomProfileTextField(
                            controller: _visa,
                            labelText: "Visa",
                            hintText: "ADD VISA CARD",
                            inputType: const TextInputType.numberWithOptions(),
                          )
                        : ListTile(
                            contentPadding:
                                const EdgeInsetsDirectional.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                            // tileColor: AppColors.grayColor,
                            tileColor: const Color(0xffEEFBFE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            leading: Image.asset(
                              "assets/icons/visa.png",
                              width: 50,
                            ),
                            title: const CustomText(
                              text: "Debit card",
                              textSize: 20,
                              textColor: Colors.black,
                              textWeight: FontWeight.w500,
                            ),
                            subtitle: CustomText(
                              text: _isLoading
                                  ? "xxxx **** **** xxxx"
                                  : (userModel?.visa ?? ""),
                              textColor: Colors.grey.shade500,
                            ),
                            trailing: const CustomText(
                              text: "Default",
                              textColor: Colors.black,
                              textSize: 14,
                              textWeight: FontWeight.w500,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          bottomSheet: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: _isLoading ? null : () {}, // Disable when loading
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 70,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        CustomText(
                          text: "Edit Profile",
                          textColor: Colors.white,
                          textSize: 18,
                        ),
                        Gap(5),
                        Icon(Icons.edit, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _isLoading
                      ? null
                      : () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const LoginView(),
                            ),
                          );
                        },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 1.4),
                    ),
                    child: Row(
                      children: [
                        CustomText(
                          text: "Logout",
                          textColor: AppColors.primary,
                          textSize: 18,
                        ),
                        const Gap(5),
                        Icon(Icons.logout, color: AppColors.primary),
                      ],
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
