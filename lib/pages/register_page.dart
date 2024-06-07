import 'package:flutter/material.dart';
import 'package:kchat/widgets/custom_button.dart';
import 'package:kchat/widgets/custom_input.dart';
import 'package:kchat/widgets/labels.dart';
import 'package:kchat/widgets/logo.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Logo(text: 'Register',),
                _Form(),
                Labels(route: 'login', text: '¿Ya tienes una cuenta?', textLink: 'Ingresa con ella ahora!',),
                Text(
                  'Terminos y condiciones de uso',
                  style: TextStyle(fontWeight: FontWeight.w200),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({super.key});

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.person,
            placeHolder: 'Name',
            textController: nameController,
            keyboardType: TextInputType.emailAddress,
          ),
          CustomInput(
            icon: Icons.email_outlined,
            placeHolder: 'Email',
            textController: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          CustomInput(
            icon: Icons.password,
            placeHolder: 'Password',
            textController: passwordController,
            isPassword: true,
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 8),
          CustomButton(
            text: 'Register',
            onPressed: () {
              print(emailController.text);
            },
          ),
        ],
      ),
    );
  }
}
