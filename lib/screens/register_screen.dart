import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:sound_cloud_clone/components/components.dart';
import 'package:sound_cloud_clone/cubits/login&Register/cubit.dart';
import 'package:sound_cloud_clone/cubits/login&Register/states.dart';

import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();
    var cubit = SoundCloudLoginAndRegCubit.get(context);
    return BlocConsumer<SoundCloudLoginAndRegCubit,
        SoundCloudLoginAndRegStates>(
      listener: (context, state) {
        if (state is SoundCloudRegisterSuccessState) {
          Fluttertoast.showToast(
              msg: 'Registration Successfully',
              backgroundColor: Colors.green,
              textColor: Colors.white);
          navigateAndFinish(context, LoginScreen());
        } else if (state is SoundCloudRegisterErrorState) {
          Fluttertoast.showToast(
              msg: 'This Email is Already exist, try another one',
              backgroundColor: Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Image(
                    image: AssetImage('assets/images/soundcloud.png'),
                    width: 290,
                  ),
                  SizedBox(
                    height: 55,
                  ),
                  defaultTextField(
                    labeltxt: 'Username',
                    controller: nameController,
                    prefixIcon: Icon(Icons.person),
                    txtinput: TextInputType.name,
                    suffix: Icons.clear,
                    SuffixPressed: () {
                      nameController.clear();
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  defaultTextField(
                    labeltxt: 'Phone',
                    controller: phoneController,
                    prefixIcon: Icon(Icons.phone),
                    txtinput: TextInputType.phone,
                    suffix: Icons.clear,
                    SuffixPressed: () {
                      phoneController.clear();
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  defaultTextField(
                    labeltxt: 'Email Address',
                    controller: emailController,
                    prefixIcon: Icon(Icons.email_outlined),
                    txtinput: TextInputType.emailAddress,
                    suffix: Icons.clear,
                    SuffixPressed: () {
                      emailController.clear();
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  defaultTextField(
                    labeltxt: 'Password',
                    isPass: cubit.isPass,
                    controller: passwordController,
                    prefixIcon: Icon(Icons.lock_outline),
                    txtinput: TextInputType.visiblePassword,
                    suffix: cubit.isPass
                        ? Icons.remove_red_eye
                        : Icons.visibility_off_outlined,
                    SuffixPressed: () {
                      cubit.changePasswordVisibility();
                    },
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Center(
                    child: ConditionalBuilder(
                      condition: state is! SoundCloudRegisterLoadingState,
                      builder: (context) => defaultBtn(
                        txt: 'Register',
                        isUpperCase: true,
                        function: () {
                          cubit.userRegister(
                              email: emailController.text,
                              phone: phoneController.text,
                              name: nameController.text,
                              password: passwordController.text);
                        },
                        icon: Icons.app_registration,
                      ),
                      fallback: (context) => Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      defaultText(text: 'Already have an account? '),
                      defaultTextButton(
                        text: 'Login',
                        fn: () {
                          navigateTo(context, LoginScreen());
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
