import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/data/user_model.dart';
import 'package:hungry/features/auth/views/login_view.dart';
import 'package:hungry/features/auth/widgets/custom_profile_textfield.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_snackBar.dart';
import 'package:image_picker/image_picker.dart';
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
  bool _isLoadingLogout = false;
  String? selectedImage;
  bool isGuest = false;

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

  Future<void> uploadImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage.path;
      });
    }
  }

  Future<void> updateProfile() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final user = await authRepo.updateProfile(
        name: _name.text.trim(),
        email: _email.text.trim(),
        address: _deliveryAddress.text.trim(),
        visa: userModel?.visa ?? _visa.text.trim(),
        imagePath: selectedImage,
      );

      setState(() {
        userModel = user; // تحديث بيانات المستخدم بالبيانات الجديدة

        // إعادة تعبئة الحقول بالبيانات الجديدة القادمة من السيرفر
        _name.text = userModel?.name ?? "";
        _email.text = userModel?.email ?? "";
        _deliveryAddress.text = userModel?.address ?? "";

        // تصفير الصورة المحلية لأنها رُفعت بنجاح والآن سنعرض رابط السيرفر
        selectedImage = null;

        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(customSnackBar("Profile updated successfully"));
      }
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

  Future<void> logout() async {
    setState(() {
      _isLoadingLogout = true;
    });
    try {
      await authRepo.logout();
      setState(() {
        _isLoadingLogout = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(customSnackBar("Logout successful"));
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      }
    } catch (e) {
      setState(() {
        _isLoadingLogout = false;
      });
      String msg = "Error in logout";
      if (e is ApiError) {
        msg = e.message;
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(msg));
      }
    }
  }

  Future<void> autoLogin() async {
    final user = await authRepo.autoLogin();
    setState(() => isGuest = authRepo.isGuest);
    if (user != null) {
      setState(() => userModel = user);
    }
  }

  @override
  void initState() {
    super.initState();
    autoLogin();
    getProfile();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _deliveryAddress.dispose();
    _visa.dispose(); // تأكد من عمل dispose لها أيضاً
    super.dispose();
  }

  // دالة مساعدة لتحديد الصورة المعروضة بشكل ذكي
  ImageProvider? _getProfileImage() {
    // 1. إذا اختار المستخدم صورة جديدة من المعرض ولم ترفع بعد
    if (selectedImage != null) {
      return FileImage(File(selectedImage!));
    }
    // 2. إذا كان هناك صورة قادمة من السيرفر (سواء عند فتح الصفحة أو بعد التحديث)
    if (userModel?.image != null && userModel!.image!.isNotEmpty) {
      return NetworkImage(userModel!.image!);
    }
    // 3. إذا لم يكن هناك أي صورة
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (!isGuest) {
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
                      // تم تعديل الـ CircleAvatar ليعرض الصورة بشكل صحيح
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: _getProfileImage(),
                        child: _getProfileImage() == null
                            ? const Icon(
                                Icons.person,
                                size: 70,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                      const Gap(20),

                      CustomButton(
                        text: "Upload Image",
                        width: 160,
                        onTap: uploadImage,
                      ),

                      const Gap(20),
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
                              inputType:
                                  const TextInputType.numberWithOptions(),
                            )
                          : ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              tileColor: const Color(0xffEEFBFE),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              leading: Image.asset(
                                "assets/icons/visa.png",
                                width: 50,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.credit_card),
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
                      const Gap(20),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                        ),
                        height: 100,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: _isLoading
                                  ? null
                                  : updateProfile, // تعطيل الزر أثناء التحميل
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                height: 70,
                                decoration: BoxDecoration(
                                  color: _isLoading
                                      ? Colors.grey
                                      : AppColors.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    const CustomText(
                                      text: "Edit Profile",
                                      textColor: Colors.white,
                                      textSize: 18,
                                    ),
                                    const Gap(5),
                                    _isLoading
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CupertinoActivityIndicator(
                                              color: Colors.white,
                                            ),
                                          )
                                        : const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: _isLoading ? null : logout,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.4,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    CustomText(
                                      text: "Logout",
                                      textColor: AppColors.primary,
                                      textSize: 18,
                                    ),
                                    const Gap(5),
                                    _isLoadingLogout == true
                                        ? SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CupertinoActivityIndicator(
                                              color: AppColors.primary,
                                            ),
                                          )
                                        : Icon(
                                            Icons.logout,
                                            color: AppColors.primary,
                                          ),
                                  ],
                                ),
                              ),
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
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Guest Mode"),
            const Gap(20),
            CustomButton(
              text: "Go To Login",
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );
              },
            ),
          ],
        ),
      );
    }
  }
}
