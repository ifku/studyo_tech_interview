import 'package:flutter/material.dart';
import 'package:studyo_tech_interview/core/gen/assets.gen.dart';
import 'package:studyo_tech_interview/core/theme/app_colors.dart';

class CustomProfileStatus extends StatelessWidget {
  const CustomProfileStatus({
    super.key,
    required this.isReview,
  });

  final bool isReview;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: isReview ? AppColors.green500 : AppColors.yellow500,
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
            color: Colors.black,
            width: 2,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(isReview ? "Profile Completed" : "Incomplete Profile"),
          const SizedBox(width: 8),
          isReview
              ? Assets.icons.iconCheck.svg(
                  width: 24.0,
                  height: 24.0,
                  colorFilter:
                      const ColorFilter.mode(AppColors.green700, BlendMode.srcIn),
                )
              : Assets.icons.iconWarning.svg(
                  width: 24.0,
                  height: 24.0,
                )
        ],
      ),
    );
  }
}
