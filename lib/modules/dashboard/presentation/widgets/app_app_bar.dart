import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_resources.dart';
import '../../../../constants/app_styles.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  const AppAppBar(this.title, {super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: SvgPicture.asset(
          AppResources.arrowBack,
          height: 25,
          width: 25,
          fit: BoxFit.scaleDown,
        ),
      ),
      title: Text(title, style: AppTextStyles.montserratMedium(20)),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
