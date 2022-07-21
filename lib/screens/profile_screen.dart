import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_cloud_clone/components/components.dart';
import 'package:sound_cloud_clone/components/constants.dart';
import 'package:sound_cloud_clone/cubits/login&Register/cubit.dart';
import 'package:sound_cloud_clone/cubits/login&Register/states.dart';
import 'package:sound_cloud_clone/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = SoundCloudLoginAndRegCubit.get(context);
    var nameController = TextEditingController(text: cubit.userLogged!.name);
    var phoneController = TextEditingController(text: cubit.userLogged!.phone);
    var passwordController =
        TextEditingController(text: cubit.userLogged!.password);
    return BlocConsumer<SoundCloudLoginAndRegCubit,
        SoundCloudLoginAndRegStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Profile",
              style: Theme.of(context).textTheme.headline1,
            ),
            centerTitle: true,
            backgroundColor: Colors.deepOrange,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(29.0),
                child: Column(
                  children: [
                    CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 75)),
                    SizedBox(
                      height: 40,
                    ),
                    if (state is SoundCloudUpdateUserLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    defaultTextField(
                        labeltxt: 'Name',
                        controller: nameController,
                        prefixicon: Icon(Icons.person),
                        txtinput: TextInputType.name,
                        suffix: Icons.close,
                        hintStyle: Theme.of(context).textTheme.subtitle1,
                        SuffixPressed: () {
                          nameController.text = "";
                        }),
                    SizedBox(
                      height: 40,
                    ),

                    defaultTextField(
                        labeltxt: 'Phone',
                        controller: phoneController,
                        prefixicon: Icon(Icons.phone),
                        txtinput: TextInputType.phone,
                        suffix: Icons.close,
                        SuffixPressed: () {
                          phoneController.text = "";
                        }),
                    SizedBox(
                      height: 40,
                    ),
                    defaultTextField(
                      labeltxt: 'Password',
                      isPass: cubit.isPass,
                      controller: passwordController,
                      prefixicon: Icon(Icons.lock_outline),
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
                    defaultBtn(
                        txt: 'Edit Profile',
                        icon: Icons.update,
                        function: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      title: const Text(
                                          "Please relogin to update your data",style: TextStyle(fontSize: 15),),
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: defaultText(
                                                    text: "Cancel",
                                                    textColor: Colors.white)),
                                            width: 80,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: defaultColor,
                                            ),
                                          ),
                                          Container(
                                            width: 80,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: defaultColor,
                                            ),

                                            child: TextButton(
                                                onPressed: () {
                                                  cubit.updateUser(
                                                      phone: phoneController.text,
                                                      name: nameController.text,
                                                      password: passwordController.text,
                                                      uId: cubit.userLogged!.uId!);


                                                  navigateAndFinish(
                                                      context, LoginScreen());
                                                },
                                                child: defaultText(
                                                    text: "OK",
                                                    textColor: Colors.white)),
                                          ),
                                        ],
                                      ));
                                });
                          }
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
