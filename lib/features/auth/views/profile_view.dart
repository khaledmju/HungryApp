import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/auth/widgets/custom_profile_textfield.dart';

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

  @override
  void initState() {
    super.initState();
    _name.text = "Knuckles";
    _email.text = "Knuckles@gmail.com";
    _deliveryAddress.text = "55Dubai, UAE";
  }

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _email.dispose();
    _deliveryAddress.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: AppColors.primary,
          actions: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(Icons.settings, color: Colors.white),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),

          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 129,
                    width: 129,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadiusGeometry.circular(20),
                      border: Border.all(color: Colors.white, width: 5),
                    ),
                    child: Image.asset("assets/test/test.png"),
                  ),
                ),
                const Gap(30),
                CustomProfileTextField(controller: _name, labelText: "Name"),
                const Gap(30),

                CustomProfileTextField(controller: _email, labelText: "Email"),
                const Gap(30),

                CustomProfileTextField(
                  controller: _deliveryAddress,
                  labelText: "Delivery address",
                ),
                const Gap(30),
                const Divider(),
                const Gap(30),
                ListTile(
                  contentPadding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  tileColor: AppColors.grayColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                  leading: Image.asset("assets/icons/visa.png", width: 50),
                  title: const CustomText(
                    text: "Debit card",
                    textSize: 20,
                    textColor: Colors.black,
                    textWeight: FontWeight.w500,
                  ),
                  subtitle: CustomText(
                    text: "3566 **** **** 0505",
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
        bottomSheet: Container(
          decoration: const BoxDecoration(
            // color: Colors.white,
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
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 70,
                  // width: 185,
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
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  // width: 185,
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
    );
  }
}
