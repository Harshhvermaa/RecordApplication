abstract class LoginScreenState{
  String googleLogin = "false";

  LoginScreenState({required this.googleLogin});
}

class LoginScreenInitialState extends LoginScreenState{
  LoginScreenInitialState(): super(googleLogin: "false");
}

class LoginScreenLoadingState extends LoginScreenState{
  LoginScreenLoadingState(): super(googleLogin: "Loading");
}

class LoginScreenGoogleLoginSuccessState extends LoginScreenState{
  LoginScreenGoogleLoginSuccessState(String googleLogin): super(googleLogin: googleLogin);
}

class LoginScreenGoogleLoginFailedState extends LoginScreenState{
  LoginScreenGoogleLoginFailedState(String googleLogin): super(googleLogin: googleLogin);
}