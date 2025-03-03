import 'dart:io';

import 'package:dio/dio.dart';
import 'package:love_keeper_fe/features/auth/data/models/request/email_duplication_request.dart';
import 'package:love_keeper_fe/features/auth/data/models/response/send_code_response.dart';
import 'package:love_keeper_fe/features/calendar/data/models/response/calendar_response.dart';
import 'package:love_keeper_fe/features/couples/data/models/request/update_start_date_request.dart';
import 'package:love_keeper_fe/features/couples/data/models/response/couples_response.dart';
import 'package:love_keeper_fe/features/drafts/data/models/request/create_draft_request.dart';
import 'package:love_keeper_fe/features/drafts/data/models/response/draft_response.dart';
import 'package:love_keeper_fe/features/letters/data/models/request/create_letter_request.dart';
import 'package:love_keeper_fe/features/letters/data/models/response/letter_list_response.dart';
import 'package:love_keeper_fe/features/members/data/models/request/send_email_code_request.dart';
import 'package:love_keeper_fe/features/members/data/models/request/update_birthday_request.dart';
import 'package:love_keeper_fe/features/members/data/models/request/update_nickname_request.dart';
import 'package:love_keeper_fe/features/members/data/models/request/update_password_request.dart';
import 'package:love_keeper_fe/features/members/data/models/request/verify_email_code_request.dart';
import 'package:love_keeper_fe/features/members/data/models/response/birthday_response.dart';
import 'package:love_keeper_fe/features/members/data/models/response/nickname_response.dart';
import 'package:love_keeper_fe/features/members/data/models/response/send_email_code_response.dart';
import 'package:love_keeper_fe/features/members/domain/entities/member_info.dart';
import 'package:love_keeper_fe/features/promises/data/models/request/create_promise_request.dart';
import 'package:love_keeper_fe/features/promises/data/models/response/promise_list_response.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/api_response.dart';
import '../../../features/auth/data/models/request/login_request.dart';
import '../../../features/auth/data/models/request/password_reset_request.dart';
import '../../../features/auth/data/models/request/send_code_request.dart';
import '../../../features/auth/data/models/request/verify_code_request.dart';
import '../../../features/auth/data/models/response/auth_response.dart';
import '../../../features/couples/data/models/request/connect_request.dart';
import '../../../features/couples/data/models/response/invite_code_response.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://lovekeeper.site')
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  // AUTH

  @POST('/api/auth/email-duplication')
  Future<ApiResponse<String>> emailDuplication(
      @Body() EmailDuplicationRequest request);

  @POST('/api/auth/reissue')
  Future<ApiResponse<String>> reissue(@Body() String refreshToken);

  @MultiPart()
  @POST('/api/auth/signup')
  Future<ApiResponse<AuthResponse>> signup({
    @Part(name: 'email') required String email,
    @Part(name: 'nickname') required String nickname,
    @Part(name: 'birthDate') required String birthDate,
    @Part(name: 'provider') required String provider,
    @Part(name: 'password') String? password,
    @Part(name: 'providerId') String? providerId,
    @Part(name: 'profileImage') File? profileImage,
  });

  @POST('/api/auth/login')
  Future<ApiResponse<AuthResponse>> login(@Body() LoginRequest request);

  @POST('/api/auth/send-code')
  Future<ApiResponse<SendCodeResponse>> sendCode(
      @Body() SendCodeRequest request);

  @POST('/api/auth/verify-code')
  Future<ApiResponse<String>> verifyCode(@Body() VerifyCodeRequest request);

  @POST('/api/auth/logout')
  Future<ApiResponse<String>> logout();

  @POST('/api/auth/password/reset-request')
  Future<ApiResponse<String>> resetPasswordRequest(
      @Body() SendCodeRequest request);

  @POST('/api/auth/password/reset')
  Future<ApiResponse<String>> resetPassword(
      @Body() PasswordResetRequest request);

  @GET('/api/auth/check-token')
  Future<ApiResponse<String>> checkToken(@Header('Authorization') String token);

  // COUPLES
  @GET('/api/couples/info')
  Future<ApiResponse<CoupleInfo>> getCoupleInfo();

  @POST('/api/couples/generate-code')
  Future<ApiResponse<InviteCodeResponse>> generateCode();

  @POST('/api/couples/connect')
  Future<ApiResponse<String>> connect(@Body() ConnectRequest request);

  @GET('/api/couples/days-since-started')
  Future<ApiResponse<int>> getDaysSinceStarted();

  @GET('/api/couples/start-date')
  Future<ApiResponse<String>> getStartDate();

  @PUT('/api/couples/start-date')
  Future<ApiResponse<String>> updateStartDate(
      @Body() UpdateStartDateRequest request);

  @DELETE('/api/couples')
  Future<ApiResponse<String>> deleteCouple();

  // MEMBERS
  @GET('/api/members/me')
  Future<ApiResponse<MemberInfo>> getMemberInfo();

  @PATCH('/api/members/nickname')
  Future<ApiResponse<NicknameResponse>> updateNickname(
      @Body() UpdateNicknameRequest request);

  @PATCH('/api/members/birthday')
  Future<ApiResponse<BirthdayResponse>> updateBirthday(
      @Body() UpdateBirthdayRequest request);

  @PATCH('/api/members/password')
  Future<ApiResponse<String>> updatePassword(
      @Body() UpdatePasswordRequest request);

  @PATCH('/api/members/profileImage')
  @MultiPart()
  Future<ApiResponse<String>> updateProfileImage(
      @Part(name: 'profileImage') File profileImage);

  @POST('/api/members/email/send-code')
  Future<ApiResponse<SendEmailCodeResponse>> sendEmailCode(
      @Body() SendEmailCodeRequest request);

  @PATCH('/api/members/email/verify-code')
  Future<ApiResponse<String>> verifyEmailCode(
      @Body() VerifyEmailCodeRequest request);

  // DRAFTS

  @POST('/api/drafts')
  Future<ApiResponse<String>> createDraft(@Body() CreateDraftRequest request);

  @GET('/api/drafts/{order}')
  Future<ApiResponse<DraftResponse>> getDraft(@Path('order') int order);

  // 드래프트 삭제
  @DELETE('/api/drafts/{order}')
  Future<void> deleteDraft(@Path('order') int order);

  // LETTERS

  @POST('/api/letters')
  Future<ApiResponse<String>> createLetter(@Body() CreateLetterRequest request);

  @GET('/api/letters/list')
  Future<ApiResponse<LetterListResponse>> getLetterList(
    @Query('page') int page,
    @Query('size') int size,
  );

  @GET('/api/letters/count')
  Future<ApiResponse<int>> getLetterCount();

  @GET('/api/letters/by-date')
  Future<ApiResponse<LetterListResponse>> getLettersByDate(
    @Query('date') String date,
    @Query('page') int page,
    @Query('size') int size,
  );

  // PROMISES

  @POST('/api/promises')
  Future<ApiResponse<String>> createPromise(
      @Body() CreatePromiseRequest request);

  @GET('/api/promises')
  Future<ApiResponse<PromiseListResponse>> getPromises(
    @Query('page') int page,
    @Query('size') int size,
  );

  @DELETE('/api/promises/{promiseId}')
  Future<ApiResponse<String>> deletePromise(@Path('promiseId') int promiseId);

  @GET('/api/promises/count')
  Future<ApiResponse<int>> getPromiseCount();

  @GET('/api/promises/by-date')
  Future<ApiResponse<PromiseListResponse>> getPromisesByDate(
    @Query('date') String date,
    @Query('page') int page,
    @Query('size') int size,
  );

  // CALENDARS

  @GET('/api/calendar')
  Future<ApiResponse<CalendarResponse>> getCalendar(
    @Query('year') int year,
    @Query('month') int month,
  );
}
