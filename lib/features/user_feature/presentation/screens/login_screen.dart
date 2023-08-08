import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/widgets/custom_button.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/widgets/custom_header.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/widgets/custom_text_field.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/widgets/form_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantsColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            const CustomFormHeader(text: 'ورود به اپل لند'),
            FormContainer(
              fields: [
                CustomTextField(
                  hintText: 'نام کاربری',
                  icon: Icons.person_outline,
                  controller: userNameController,
                ),
                CustomTextField(
                  hintText: 'رمز عبور',
                  icon: Icons.lock_outline,
                  controller: passwordController,
                  isSecret: true,
                ),
                CustomButton(
                  text: 'ورود',
                  whenClick: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'با ثبت نام در اپل لند ، قوانین و شرایط را می پذیرید.',
                  style: TextStyle(
                    color: ConstantsColors.grey,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
