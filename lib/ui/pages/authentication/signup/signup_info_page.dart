import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/bloc/authentication/signup/signup_bloc.dart';
import 'package:roadsyouwalked_app/bloc/camera/camera_bloc.dart';
import 'package:roadsyouwalked_app/ui/components/authentication/add_profile_image_button.dart';
import 'package:roadsyouwalked_app/ui/components/authentication/profile_image_preview_widget.dart';
import 'package:roadsyouwalked_app/ui/components/input/confirm_button_widget.dart';
import 'package:roadsyouwalked_app/ui/components/input/date_selector_widget.dart';
import 'package:roadsyouwalked_app/ui/components/input/text_input_widget.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';
import 'package:roadsyouwalked_app/ui/pages/camera/camera_page.dart';

class SignupInfoPage extends StatelessWidget {
  final TextEditingController _firstNameTextController =
      TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();

  SignupInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        switch (state) {
          case SignupSuccess _:
            GoRouter.of(context).pop();
            break;
          case SignupFailure _:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Impossible to create user",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: const Color.fromARGB(255, 159, 23, 14),
                duration: Duration(seconds: 3),
              ),
            );
            break;
          default:
        }
      },
      builder: (context, state) {
        final Widget page;
        if (state is SignupTakingProfileImage) {
          page = BlocProvider(
            create: (context) => CameraBloc()..add(InitCamera()),
            child: CameraPage(
              onSaveMedia: (localFile, remoteUri, mediaType) {
                context.read<SignupBloc>().add(AddProfileImage(localFile));
              },
            ),
          );
        } else {
          page = Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                state.profileImage == null
                    ? AddProfileImageButton(
                      onPressed: () {
                        context.read<SignupBloc>().add(TakeProfileImage());
                      },
                    )
                    : ProfileImagePreviewWidget(
                      path: state.profileImage!.path,
                      onTap: () {
                        context.read<SignupBloc>().add(TakeProfileImage());
                      },
                    ),
                SizedBox(height: size.height * 0.05),
                TextInputWidget(
                  textController: _firstNameTextController,
                  labelText: "First name",
                ),
                const SizedBox(height: AppSpacingConstants.xs),
                TextInputWidget(
                  textController: _lastNameTextController,
                  labelText: "Last name",
                ),
                const SizedBox(height: AppSpacingConstants.xs),
                DateSelectorWidget(
                  label: "Birthday",
                  value: state.birthday,
                  onDateSelected: (date) {
                    //dev.log("Date picked: ${DateFormat("dd/mm")}")
                    context.read<SignupBloc>().add(AddBirthday(date: date));
                  },
                ),
                const SizedBox(height: AppSpacingConstants.xs),
                TextInputWidget(
                  textController: _usernameTextController,
                  labelText: "Username",
                  onChanged:
                      (value) => context.read<SignupBloc>().add(
                        UsernameCheckRequest(_usernameTextController.text),
                      ),
                  isValid:
                      state.validUsername ||
                      _usernameTextController.text.isEmpty,
                  errorText:
                      state.validUsername ? null : "Username already taken",
                ),
                const SizedBox(height: AppSpacingConstants.xs),
                TextInputWidget(
                  textController: _passwordTextController,
                  labelText: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: AppSpacingConstants.xl),
                ConfirmButtonWidget(
                  width: size.width * 0.70,
                  onPressed: () {
                    context.read<SignupBloc>().add(
                      SignupRequest(
                        _firstNameTextController.text,
                        _lastNameTextController.text,
                        _usernameTextController.text,
                        _passwordTextController.text,
                      ),
                    );
                  },
                  label: "Signup",
                ),
              ],
            ),
          );
        }
        return page;
      },
    );
  }
}
