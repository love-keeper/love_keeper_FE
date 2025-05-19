import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:love_keeper/features/members/domain/entities/member_info.dart';
// repository provider import 추가
import 'package:love_keeper/features/members/data/repositories/members_repository_impl.dart';

part 'members_viewmodel.g.dart';

@riverpod
class MembersViewModel extends _$MembersViewModel {
  @override
  AsyncValue<MemberInfo?> build() {
    // 초기 데이터 로드를 위해 지연 호출
    Future(() => fetchMemberInfo());
    return const AsyncValue.data(null);
  }

  Future<void> fetchMemberInfo() async {
    state = const AsyncValue.loading();
    try {
      // 정삭적으로 repository provider 를 참조
      final repo = ref.watch(membersRepositoryProvider);
      final memberInfo = await repo.getMemberInfo();
      state = AsyncValue.data(memberInfo);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<String> updateNickname(String nickname) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.watch(membersRepositoryProvider);
      final result = await repo.updateNickname(nickname);
      await fetchMemberInfo();
      return result;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<String> updateBirthday(String birthday) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.watch(membersRepositoryProvider);
      final result = await repo.updateBirthday(birthday);
      await fetchMemberInfo();
      return result;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<String> updatePassword(
    String currentPassword,
    String newPassword,
    String newPasswordConfirm,
  ) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.watch(membersRepositoryProvider);
      final result = await repo.updatePassword(
        currentPassword,
        newPassword,
        newPasswordConfirm,
      );
      // 상태에는 기존 데이터를 유지
      state = AsyncValue.data(state.value);
      return result;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<String> updateProfileImage(File? profileImage) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.watch(membersRepositoryProvider);
      final result =
          profileImage == null
              ? await repo.updateProfileImage(null)
              : await repo.updateProfileImage(profileImage);
      await fetchMemberInfo();
      return result;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<String> sendEmailCode(String email) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.watch(membersRepositoryProvider);
      final result = await repo.sendEmailCode(email);
      // 상태 유지
      state = AsyncValue.data(state.value);
      return result;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<String> verifyEmailCode(String email, String code) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.watch(membersRepositoryProvider);
      final result = await repo.verifyEmailCode(email, code);
      await fetchMemberInfo();
      return result;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}
