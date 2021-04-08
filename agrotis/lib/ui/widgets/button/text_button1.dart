import 'package:agrotis/ui/media/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color color;
  final Color textColor;

  const AppTextButton({
    Key key,
    @required this.title,
    this.onPressed,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.sp),
      ),
      // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      color: color ?? Theme.of(context).buttonColor,

      child: Text(
        title,
        style: AppTextStyles.s1(color: textColor),
      ),
    );
  }
}
