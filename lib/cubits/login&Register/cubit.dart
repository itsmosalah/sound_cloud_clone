

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_cloud_clone/cubits/login&Register/states.dart';

import '../../models/track_data.dart';
import '../../shared/network/remote/sound_api.dart';

class SoundCloudLoginAndRegCubit extends Cubit<SoundCloudLoginAndRegStates> {
  SoundCloudLoginAndRegCubit() : super(SoundCloudLoginInitialState());

  static SoundCloudLoginAndRegCubit get(context) => BlocProvider.of(context);
  bool isPass = true;

  void changePasswordVisibility() {
    isPass = !isPass;
    emit(SoundCloudLoginChangeVisibilityState());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SoundCloudLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(SoundCloudLoginSuccessState());
    }).catchError((error) {
      emit(SoundCloudLoginErrorState());
    });
  }

  void userRegister({
    required String email,
    required String phone,
    required String name,
    required String password,
  }) {
    emit(SoundCloudRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(uId: value.user!.uid, name: name, email: email, phone: phone);
      emit(SoundCloudRegisterSuccessState());
    }).catchError((error) {
      emit(SoundCloudRegisterErrorState());
    });
  }

  void createUser({
    required String email,
    required String phone,
    required String name,
    required String uId,
  }) {
    FirebaseFirestore.instance.collection('users').doc(uId).set({
      'name': name,
      'phone': phone,
      'email': email,
      'uId': uId,
    }).then((value) {
      emit(SoundCloudCreateUserSuccessState());
    }).catchError((error) {
      emit(SoundCloudCreateUserErrorState());
    });
  }





}
