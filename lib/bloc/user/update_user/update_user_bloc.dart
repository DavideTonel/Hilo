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
  final void Function() onUpdate;

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
      await _userRepository.updateProfileImage(
        state.user.username,
        state.newProfileImage,
      );
      final User? newUser = await _userRepository.getUser(
        state.user.username,
        state.user.password,
      );
      emit(
        UpdateUserInProgress(
          user: newUser!,
          newProfileImage: state.newProfileImage,
        ),
      );
      onUpdate();
    } catch (e) {
      dev.log(e.toString());
    }
  }
}
