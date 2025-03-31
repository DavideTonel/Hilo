import 'dart:developer' as dev;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/db/user/user_repository.dart';
import 'package:roadsyouwalked_app/model/authentication/user.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserRepository _userRepository;

  SignupBloc(this._userRepository) : super(SignupInitial()) {
    on<SignupRequest>(onSignupRequest);
    on<UsernameCheckRequest>(onUsernameCheckRequest);
  }

  Future<void> onUsernameCheckRequest(
    UsernameCheckRequest event,
    Emitter<SignupState> emit
  ) async {
    try {
      await _userRepository
        .isValidUsername(event.username)
        .then((res) => res ? emit(SignupLoading(validUsername: true)) : emit(SignupLoading(validUsername: false)));
    } catch (e) {
      dev.log(e.toString());
      emit(SignupLoading(validUsername: state.validUsername));
    }
  }

  Future<void> onSignupRequest(
    SignupRequest event,
    Emitter<SignupState> emit
  ) async {
    try {
      await _userRepository.createUser(
        User(
          username: event.username,
          password: event.password,
          firstName: event.firstName,
          lastName: event.lastName,
        )
        ).then((res) {
          if (res) {
            emit(SignupSuccess(validUsername: state.validUsername));
            dev.log("Signup success");
          } else {
            emit(SignupFailure(validUsername: state.validUsername));
            dev.log("Signup failure");
          }
        }
      );
      //).then((res) => res ? emit(SignupSuccess(validUsername: state.validUsername)) : emit(SignupFailure(validUsername: state.validUsername)));
    } catch (e) {
      dev.log(e.toString());
      emit(SignupFailure(validUsername: state.validUsername));  // TODO: add error message
    }
  }
}
