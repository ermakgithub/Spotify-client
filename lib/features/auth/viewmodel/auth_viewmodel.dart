import 'package:client/features/auth/model/user_model.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository = AuthRemoteRepository();

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    return null;
  }

  Future<void> loginUser({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final res = await _authRemoteRepository.login(
      email: email,
      password: password,
    );

    final val = switch (res) {
      fp.Left(value: final l) => state = AsyncValue.error(
        l.message,
        StackTrace.current,
      ),
      fp.Right(value: final r) => state = AsyncValue.data(r),
    };
    print(val);
  }
}
