import 'dart:io';
import 'dart:developer' as dev;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/data/repository/user/i_user_repository.dart';
import 'package:roadsyouwalked_app/data/repository/user/user_repository.dart';
import 'package:roadsyouwalked_app/model/authentication/user.dart';

part 'update_user_event.dart';
part 'update_user_state.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final IUserRepository _userRepository = UserRepository();
  final Future<void> Function(String username, String password) onUpdate;

  UpdateUserBloc({required final User user, required this.onUpdate})
    : super(UpdateUserInitial(
      user: user,
      newProfileImage: user.profileImagePath != null ? File(user.profileImagePath!) : null
    )) {
    on<TakeProfileImage>((event, emit) {
      emit(
        UserTakingProfileImage(
          user: state.user,
          newProfileImage: state.newProfileImage,
        ),
      );
    });
    on<AddProfileImage>(onAddProfileImage);
    on<UpdateUser>(onUpdateUser);
  }

  Future<void> onAddProfileImage(
    AddProfileImage event,
    Emitter<UpdateUserState> emit,
  ) async {
    try {
      emit(
        UpdateUserInProgress(
          user: state.user,
          newProfileImage: event.profileImage,
        ),
      );
    } catch (e) {
      dev.log(e.toString());
    }
  }

  Future<void> onUpdateUser(
    UpdateUser event,
    Emitter<UpdateUserState> emit,
  ) async {
    try {
      await _userRepository.deleteAutoLoginCredentials();
      await _userRepository.setAutoLoginCredentials(
        event.user.username,
        event.user.password
      );

      await _userRepository.updateUser(event.user);

      await _userRepository.updateProfileImage(
        event.user.username,
        state.newProfileImage,
      );

      final User? newUser = await _userRepository.getUser(
        event.user.username,
        event.user.password,
      );
      
      emit(
        UpdateUserInProgress(
          user: newUser!,
          newProfileImage: state.newProfileImage,
        ),
      );
      await onUpdate(
        newUser.username,
        newUser.password
      );
    } catch (e) {
      dev.log(e.toString());
    }
  }
}
