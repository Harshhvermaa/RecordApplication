import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heartztask/bloc/loginScreenBloc/login_event.dart';
import 'package:heartztask/bloc/loginScreenBloc/login_state.dart';
import 'package:heartztask/views/homeScreen.dart';

import '../../helper/loader_view.dart';

class LoginBloc extends Bloc<LoginScreenEvent,LoginScreenState>
{

    LoginBloc():super(LoginScreenInitialState()){

      on<LoginScreenButtonPressEvent>((event, emit) async {
        emit(LoginScreenLoadingState());
        try {
          final FirebaseAuth _auth = FirebaseAuth.instance;
          GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
          await _auth.signInWithProvider(_googleAuthProvider).then((value) {
          Fluttertoast.showToast(msg: "Logged In Successfully \n ${value?.user!.email}");
          emit(LoginScreenGoogleLoginSuccessState("true"));
          print("Emitted");
          });
        } catch (error) {
          print("Error during Google Sign-In: $error");
          Fluttertoast.showToast(msg: "Something went wrong");
          emit(LoginScreenGoogleLoginSuccessState("false"));
        }
      });

      on<LoginScreenGoogleLoginFailedEvent>((event, emit) {

        emit(LoginScreenGoogleLoginFailedState(state.googleLogin = "false"));
      });


    }

}