import 'package:flutter/material.dart';
import 'package:studyo_tech_interview/core/theme/app_colors.dart';

class CustomConfirmButton extends StatelessWidget {
  const CustomConfirmButton({
    super.key,
    required this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.0,
      width: MediaQuery.of(context).size.width * 0.7,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.green500,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
        onPressed: onPressed,
        child:
            Text("Confirm", style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }
}
