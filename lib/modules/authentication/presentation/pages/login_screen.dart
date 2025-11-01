import 'package:flutter/material.dart';
import 'package:reel_lessons/constants/app_colors.dart';
import 'package:reel_lessons/constants/app_styles.dart';
import 'package:reel_lessons/modules/dashboard/presentation/pages/add_feed_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController(text: "8129466718");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._renderHeaderText(),
                _renderField(),
                SizedBox(height: MediaQuery.of(context).size.width / 1.5),
                _renderButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _renderHeaderText() {
    return [
      Text(
          "Enter Your\nMobile Number",
          style: AppTextStyles.montserratMedium(30)
      ),
      const SizedBox(height: 15),
      Text(
          "Lorem ipsum dolor sit amet consectetur. Porta id rhoncus mi. At vehicula euismod mi viverra et tortor.",
          style: AppTextStyles.montserratRegular(14, color: AppColors.containerBorder)
      ),
      const SizedBox(height: 50)
    ];
  }

  Widget _renderField(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.transparent,
              border: Border.all(color: AppColors.containerBorder, width: 0.5)
          ),
          child: Text(
            "+91",
            style: AppTextStyles.montserratBold(16),
            textAlign: TextAlign.center
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: TextFormField(
            controller: phoneController,
            style: AppTextStyles.montserratBold(16),
            keyboardType: TextInputType.phone,
            decoration: AppInputDecorationStyles.formFieldDecoration("Enter Mobile Number", 12),
            maxLength: 10,
          ),
        )
      ],
    );
  }

  Widget _renderButton(){
    return InkWell(
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      hoverColor: AppColors.transparent,
      focusColor: AppColors.transparent,
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddFeedScreen()));
      },
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          padding: EdgeInsets.fromLTRB(16, 6, 6, 6),
          decoration: BoxDecoration(
            border: Border.all(
                color: AppColors.containerBorder,
                width: 0.5
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "Continue",
                  style: AppTextStyles.montserratRegular(16)
              ),
              CircleAvatar(
                  maxRadius: 18,
                  backgroundColor: AppColors.secondary,
                  child: Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: AppColors.white
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}