import 'dart:io';
import 'package:love_keeper_fe/features/members/data/repositories/members_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/repositories/members_repository.dart';

part 'members_viewmodel.g.dart';

@riverpod
class MembersViewModel extends _$MembersViewModel {
  late final MembersRepository _repository;

  @override
  AsyncValue<dynamic> build() {
    _repository = ref.watch(membersRepositoryProvider);
    return const AsyncValue.data(null);
  }

  Future<String> updateNickname(String nickname) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.updateNickname(nickname);
      state = AsyncValue.data(result);
      return result;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<String> updateBirthday(String birthday) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.updateBirthday(birthday);
      state = AsyncValue.data(result);
      return result;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<String> updatePassword(String currentPassword, String newPassword,
      String newPasswordConfirm) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.updatePassword(
          currentPassword, newPassword, newPasswordConfirm);
      state = AsyncValue.data(result);
      return result;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<String> updateProfileImage(File profileImage) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.updateProfileImage(profileImage);
      state = AsyncValue.data(result);
      return result;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<String> sendEmailCode(String email) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.sendEmailCode(email);
      state = AsyncValue.data(result);
      return result;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<String> verifyEmailCode(String email, String code) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.verifyEmailCode(email, code);
      state = AsyncValue.data(result);
      return result;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}
