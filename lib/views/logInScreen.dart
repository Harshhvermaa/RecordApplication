import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heartztask/bloc/loginScreenBloc/login_bloc.dart';
import 'package:heartztask/bloc/loginScreenBloc/login_event.dart';
import 'package:heartztask/bloc/loginScreenBloc/login_state.dart';
import 'package:heartztask/helper/loader_view.dart';
import 'package:heartztask/views/homeScreen.dart';

class LoginScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: BlocListener<LoginBloc,LoginScreenState>(
                listener: (context, state) {
                  print("state ${state}");
                  if (state.googleLogin == "true") {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  }
                },
                child: BlocBuilder<LoginBloc, LoginScreenState>(
                  builder: (context, state) {
                    return state.googleLogin == "false"
                        ? InkWell(
                      onTap: () {
                        context.read<LoginBloc>().add(LoginScreenButtonPressEvent());
                      },
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.redAccent.withOpacity(0.2)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("SignUp with"),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                height: 30,
                                width: 30,
                                child: Image(image: AssetImage("assets/google.png")),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                        : CircularProgressIndicator();
                  },
                ),
              )
          ),
        ],
      ),
    );
  }
}
