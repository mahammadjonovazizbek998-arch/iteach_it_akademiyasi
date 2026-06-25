import 'package:bloc/bloc.dart';
import 'package:iteach_it_akademiyasi/data/repository/auth.dart';
import 'package:iteach_it_akademiyasi/data/users/groups/login_class.dart';
import 'package:iteach_it_akademiyasi/logon/login/login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial(toHider: true, token: null)) {
    userRole();
  }

  Future<void> userRole() async {
    emit(LoginLoding(token: null, toHider: state.toHider));
    AuthRepository authRepository = AuthRepository();
    final preference = await authRepository.getSharedPreferences();
    if (preference != null) {
      emit(LoginFinish(toHider: state.toHider, token: preference));
    } else {
      emit(LoginSignOut(toHider: state.toHider, token: null));
    }
  }

  void hider() {
    emit(LoginButton(toHider: !state.toHider, token: state.token));
  }

  Future<void> signIn(String login, String parol) async {
    AuthRepository authRepository = AuthRepository();
    emit(LoginLoding(token: null, toHider: state.toHider));
    final result = await authRepository.signIn(login, parol);
    if (result is Map) {
      await authRepository.setSharedPreferences(
        result["access_token"],
        result["refresh_token"],
        result["role"],
      );
      emit(
        LoginFinish(
          token: Token(
            accessToken: result["access_token"],
            refreshToken: result["refresh_token"],
            role: result["role"],
          ),
          toHider: state.toHider,
        ),
      );
    }
    if (result is String) {
      emit(LoginError(error: result, token: null, toHider: state.toHider));
    }
  }

  Future<void> refreshToken() async {

    AuthRepository authRepository = AuthRepository();
    if (state.token?.refreshToken == null) {
      emit(LoginSignOut(token: null, toHider: state.toHider));
    } else {

      String refreshToken = state.token!.refreshToken!;
      final result = await authRepository.refreshToken(refreshToken);
      if (result is String) {
        emit(LoginSignOut(token: null, toHider: state.toHider));
      }

      if (result is Map) {
        await authRepository.setSharedPreferences(
          result["access_token"],
          result["refresh_token"],
          result["role"],
        );

        emit(LoginFinish(token: state.token, toHider: state.toHider));
      } else {
        emit(LoginSignOut(token: null, toHider: state.toHider));
      }
    }
  }
}
