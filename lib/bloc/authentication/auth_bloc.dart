import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<CheckAutoLogin>(onCheckAutoLogin);
    on<RequestLogin>((event, emit) => emit(LoginRequested()));
  }

  Future<void> onCheckAutoLogin(
    CheckAutoLogin event,
    Emitter<AuthState> emit,
  ) async {
    // Simulate a delay for auto-login check
    await Future.delayed(const Duration(seconds: 1));

    // Here you would typically check if the user is already logged in
    // For this example, we'll just emit the Unauthenticated state
    emit(Unauthenticated());
  }
}
