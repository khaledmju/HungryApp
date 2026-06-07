import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              "assets/logo/logo.svg",
              color: AppColors.primary,
              height: 35,
            ),
            const Gap(5),
            const CustomText(
              text: "Hello, Rich Sonic",
              textSize: 16,
              textWeight: FontWeight.w500,
              textColor: Colors.grey,
            ),
          ],
        ),
        const Spacer(),
        CircleAvatar(
          radius: 31,
          backgroundColor: AppColors.primary,
          child: const Icon(CupertinoIcons.person, color: Colors.white),
        ),
      ],
    );
  }
}
