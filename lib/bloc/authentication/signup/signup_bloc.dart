import 'dart:developer' as dev;
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/data/repository/user_repository.dart';
import 'package:roadsyouwalked_app/model/authentication/user.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserRepository _userRepository;

  SignupBloc(this._userRepository) : super(SignupInitial()) {
    on<SignupRequest>(onSignupRequest);
    on<UsernameCheckRequest>(onUsernameCheckRequest);
    on<TakeProfileImage>((event, emit) {
      emit(
        SignupTakingProfileImage(
          validUsername: state.validUsername,
          profileImage: state.profileImage,
          birthday: state.birthday
        ),
      );
    });
    on<AddProfileImage>(onAddProfileImage);
    on<AddBirthday>(onAddBirthday);
  }

  Future<void> onUsernameCheckRequest(
    UsernameCheckRequest event,
    Emitter<SignupState> emit,
  ) async {
    try {
      await _userRepository
          .isValidUsername(event.username)
          .then(
            (res) =>
                res
                    ? emit(
                      SignupLoading(
                        validUsername: true,
                        profileImage: state.profileImage,
                        birthday: state.birthday
                      ),
                    )
                    : emit(
                      SignupLoading(
                        validUsername: false,
                        profileImage: state.profileImage,
                        birthday: state.birthday
                      ),
                    ),
          );
    } catch (e) {
      dev.log(e.toString());
      emit(
        SignupLoading(
          validUsername: state.validUsername,
          profileImage: state.profileImage,
          birthday: state.birthday
        ),
      );
    }
  }

  Future<void> onSignupRequest(
    SignupRequest event,
    Emitter<SignupState> emit,
  ) async {
    try {
      await _userRepository
          .createUser(
            User(
              username: event.username,
              password: event.password,
              firstName: event.firstName,
              lastName: event.lastName,
              profileImagePath: state.profileImage?.path,
              birthday: state.birthday!.toIso8601String()
            ),
          )
          .then((res) {
            if (res) {
              emit(
                SignupSuccess(
                  validUsername: state.validUsername,
                  profileImage: state.profileImage,
                  birthday: state.birthday
                ),
              );
              dev.log("Signup success");
            } else {
              emit(
                SignupFailure(
                  validUsername: state.validUsername,
                  profileImage: state.profileImage,
                  birthday: state.birthday
                ),
              );
              dev.log("Signup failure");
            }
          });
    } catch (e) {
      dev.log(e.toString());
      emit(
        SignupFailure(
          validUsername: state.validUsername,
          profileImage: state.profileImage,
          birthday: state.birthday
        ),
      ); // TODO: add error message
    }
  }

  Future<void> onAddProfileImage(
    AddProfileImage event,
    Emitter<SignupState> emit,
  ) async {
    try {
      emit(
        SignupLoading(
          validUsername: state.validUsername,
          profileImage: event.profileImage,
          birthday: state.birthday
        ),
      );
    } catch (e) {
      emit(
        SignupLoading(
          validUsername: state.validUsername,
          profileImage: state.profileImage,
          birthday: state.birthday
        ),
      );
    }
  }

  Future<void> onAddBirthday(
    AddBirthday event,
    Emitter<SignupState> emit,
  ) async {
    try {
      emit(
        SignupLoading(
          validUsername: state.validUsername,
          profileImage: state.profileImage,
          birthday: event.date
        ),
      );
    } catch (e) {
      emit(
        SignupLoading(
          validUsername: state.validUsername,
          profileImage: state.profileImage,
          birthday: state.birthday
        ),
      );
    }
  }
}
