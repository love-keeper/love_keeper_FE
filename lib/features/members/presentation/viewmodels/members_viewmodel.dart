import 'dart:io';
import 'package:love_keeper_fe/features/members/data/repositories/members_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:love_keeper_fe/features/members/domain/entities/member_info.dart';
import '../../domain/repositories/members_repository.dart';

part 'members_viewmodel.g.dart';

@riverpod
class MembersViewModel extends _$MembersViewModel {
  late final MembersRepository _repository;

  @override
  AsyncValue<MemberInfo?> build() {
    _repository = ref.watch(membersRepositoryProvider);
    Future(() => fetchMemberInfo()); // 지연 호출로 초기 데이터 로드
    return const AsyncValue.data(null);
  }

  Future<void> fetchMemberInfo() async {
    state = const AsyncValue.loading();
    try {
      final memberInfo = await _repository.getMemberInfo();
      state = AsyncValue.data(memberInfo);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<String> updateNickname(String nickname) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.updateNickname(nickname);
      await fetchMemberInfo(); // 정보 갱신
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
      await fetchMemberInfo();
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
      state = AsyncValue.data(state.value);
      return result;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<String> updateProfileImage(File? profileImage) async {
    // File?로 수정
    state = const AsyncValue.loading();
    try {
      final result = await _repository.updateProfileImage(profileImage);
      await fetchMemberInfo(); // 최신 데이터 가져오기
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
      state = AsyncValue.data(state.value);
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
      await fetchMemberInfo();
      return result;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}
