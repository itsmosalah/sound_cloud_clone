import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_cloud_clone/cubits/login&Register/states.dart';
import 'package:sound_cloud_clone/models/user_data.dart';

import '../../models/playlist.dart';
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

  UserData? userLogged;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SoundCloudLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          // search in all users data
      FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          // to get user's logged data
          if (element['email'] == email)
            userLogged = UserData(name: element['name'],
                password: element['password'],
                phone: element['phone'],
                uId: element['uId']
            );
        });
      });
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
      createUser(
          uId: value.user!.uid,
          name: name,
          email: email,
          phone: phone,
          password: password);

      emit(SoundCloudRegisterSuccessState());
    }).catchError((error) {
      emit(SoundCloudRegisterErrorState());
    });
  }

  void createUser({
    required String email,
    required String phone,
    required String name,
    required String password,
    required String uId,
  }) {
    FirebaseFirestore.instance.collection('users').doc(uId).set({
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'uId': uId,
    }).then((value) {
      emit(SoundCloudCreateUserSuccessState());
    }).catchError((error) {
      emit(SoundCloudCreateUserErrorState());
    });
  }


  void updateUser({
    required String phone,
    required String name,
    required String password,
    required String uId,
  })
  {
    emit(SoundCloudUpdateUserLoadingState());
    FirebaseAuth.instance.currentUser!.updatePassword(password);
    FirebaseFirestore.instance.collection('users').doc(uId).update(
        {
          'name': name,
          'phone': phone,
          'password': password,
        }).then((value)
    {

      emit(SoundCloudUpdateUserSuccessState());
    }).catchError((error){
      emit(SoundCloudUpdateUserErrorState());
    });
  }




  //this should have access to ID of CURRENTLY LOGGED USER
  void updatePlaylists(List<Playlist> playlists){
    List<Map<String,dynamic>> sendJson = [];
    for (Playlist pl in playlists){
      sendJson.add(pl.toJson());
    }

    FirebaseFirestore.instance.collection('users').doc("RXynMNk76uPAmgJT5GXMobumTZA3").update(
        {
          'playlists': sendJson,
        }).then((value)
    {
      emit(SoundCloudUpdatePlaylistSuccessState());
    }).catchError((error){
      emit(SoundCloudUpdatePlaylistErrorState());
    });


  }
}
