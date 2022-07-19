
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sound_cloud_clone/components/components.dart';
import 'package:sound_cloud_clone/cubits/login&Register/cubit.dart';
import 'package:sound_cloud_clone/cubits/login&Register/states.dart';
import 'package:sound_cloud_clone/screens/register_screen.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passController = TextEditingController();
    var cubit = SoundCloudLoginAndRegCubit.get(context);
    return BlocConsumer<
        SoundCloudLoginAndRegCubit,
        SoundCloudLoginAndRegStates>(
      listener: (context, state)
      {
        if(state is SoundCloudLoginSuccessState)
          {
            Fluttertoast.showToast(
                msg: 'Login Successfully',
                backgroundColor: Colors.green,textColor: Colors.white);
            navigateAndFinish(context, HomeScreen());
          }
        else if (state is SoundCloudLoginErrorState) {
          Fluttertoast.showToast(
              msg: 'Invalid Email Or Password',
              backgroundColor: Colors.red);
        }
      },
      builder: (context, state) {

        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultText(text: "Login",fontsize: 40),
                    SizedBox(height: 20,),
                    defaultTextField(
                      labeltxt: 'EmailAddress',
                      controller: emailController,
                      prefixicon: Icon(Icons.email_outlined),
                      txtinput: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    defaultTextField(
                      labeltxt: 'Password',
                      isPass: SoundCloudLoginAndRegCubit
                          .get(context)
                          .isPass,
                      controller: passController,
                      prefixicon: Icon(Icons.lock_outline),
                      txtinput: TextInputType.visiblePassword,
                      suffix: SoundCloudLoginAndRegCubit
                          .get(context)
                          .isPass
                          ? Icons.remove_red_eye
                          : Icons.visibility_off_outlined,
                      SuffixPressed: () {
                        SoundCloudLoginAndRegCubit.get(context)
                            .changePasswordVisibility();
                      },
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    ConditionalBuilder(
                      condition: state is! SoundCloudLoginLoadingState,
                      builder: (context) =>
                          defaultBtn(
                            txt: 'Login',
                            isUpperCase: true,
                            function: () {
                              cubit.userLogin(email: emailController.text,
                                  password: passController.text);

                            },
                            icon: Icons.login,
                          ),
                      fallback: (context) =>
                          Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 5,
                            ),
                          ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        defaultText(
                            text: 'Don\'t have an account? ', fontsize: 15),
                        defaultTextButton(
                            text: 'register',
                            fn: () {
                              navigateTo(context, RegisterScreen());
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
