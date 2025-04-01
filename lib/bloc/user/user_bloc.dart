import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/db/user/user_repository.dart';
import 'package:roadsyouwalked_app/model/authentication/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  
  UserBloc(this._userRepository) : super(UserInitial()) {
    on<Login>(onLogin);
    on<Logout>(onLogout);
  }

  Future<void> onLogin(
    Login event,
    Emitter<UserState> emit
  ) async {
    await _userRepository.getUser(event.username, event.password).then((user) {
      if (user != null) {
        emit(UserLoaded(user: user));
      } else {
        emit(UserInitial());
      }
    });
  }

  Future<void> onLogout(
    Logout event,
    Emitter<UserState> emit
  ) async {
    await _userRepository.deleteAutoLoginCredentials();
    emit(UserInitial());
  }
}
