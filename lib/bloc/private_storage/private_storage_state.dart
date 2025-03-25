part of 'private_storage_bloc.dart';

@immutable
sealed class PrivateStorageState {
  final PrivateStorageMediaManager manager;
  final List<File> images;

  const PrivateStorageState(
    {
      required this.manager,
      required this.images
    }
  );
}

final class PrivateStorageInitial extends PrivateStorageState {
  PrivateStorageInitial(
    {
      super.images = const [],
    }
  ) : super(manager: PrivateStorageMediaManager());
}

final class PrivateStorageLoading extends PrivateStorageState {
  const PrivateStorageLoading(
    {
      required super.manager,
      required super.images
    }
  );
}

final class PrivateStorageLoaded extends PrivateStorageState {
  const PrivateStorageLoaded(
    {
      required super.manager,
      required super.images
    }
  );
}
