import 'dart:io';

import 'package:dio/dio.dart';
import 'package:love_keeper/features/auth/data/models/request/email_duplication_request.dart';
import 'package:love_keeper/features/auth/data/models/response/send_code_response.dart';
import 'package:love_keeper/features/calendar/data/models/response/calendar_response.dart';
import 'package:love_keeper/features/couples/data/models/request/update_start_date_request.dart';
import 'package:love_keeper/features/couples/data/models/response/couple_info.dart';
import 'package:love_keeper/features/drafts/data/models/request/create_draft_request.dart';
import 'package:love_keeper/features/drafts/data/models/response/draft_response.dart';
import 'package:love_keeper/features/letters/data/models/request/create_letter_request.dart';
import 'package:love_keeper/features/letters/data/models/response/letter_list_response.dart';
import 'package:love_keeper/features/members/data/models/request/send_email_code_request.dart';
import 'package:love_keeper/features/members/data/models/request/update_birthday_request.dart';
import 'package:love_keeper/features/members/data/models/request/update_nickname_request.dart';
import 'package:love_keeper/features/members/data/models/request/update_password_request.dart';
import 'package:love_keeper/features/members/data/models/request/verify_email_code_request.dart';
import 'package:love_keeper/features/members/data/models/response/birthday_response.dart';
import 'package:love_keeper/features/members/data/models/response/nickname_response.dart';
import 'package:love_keeper/features/members/data/models/response/send_email_code_response.dart';
import 'package:love_keeper/features/members/domain/entities/member_info.dart';
import 'package:love_keeper/features/promises/data/models/request/create_promise_request.dart';
import 'package:love_keeper/features/promises/data/models/response/promise_list_response.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/api_response.dart';
import '../../../features/auth/data/models/request/login_request.dart';
import '../../../features/auth/data/models/request/password_reset_request.dart';
import '../../../features/auth/data/models/request/send_code_request.dart';
import '../../../features/auth/data/models/request/verify_code_request.dart';
import '../../../features/auth/data/models/response/auth_response.dart';
import '../../../features/couples/data/models/request/connect_request.dart';
import '../../../features/couples/data/models/response/invite_code_response.dart';
import 'package:love_keeper/features/letters/data/models/response/letter_response.dart';
import '../../../features/fcm/data/models/fcm_models.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://dev.lovekeeper.site')
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  // AUTH
  @POST('/api/auth/email-duplication')
  Future<ApiResponse<String>> emailDuplication(
    @Body() EmailDuplicationRequest request,
  );

  @POST('/api/auth/reissue')
  Future<ApiResponse<String>> reissue(@Header('Cookie') String refreshToken);

  @MultiPart()
  @POST('/api/auth/signup')
  Future<ApiResponse<AuthResponse>> signup({
    @Part(name: 'email') required String email,
    @Part(name: 'nickname') required String nickname,
    @Part(name: 'birthDate') required String birthDate,
    @Part(name: 'provider') required String provider,
    @Part(name: 'privacyPolicyAgreed') required bool privacyPolicyAgreed,
    @Part(name: 'marketingAgreed') bool? marketingAgreed,
    @Part(name: 'termsOfServiceAgreed') required bool termsOfServiceAgreed,
    @Part(name: 'password') String? password,
    @Part(name: 'providerId') String? providerId,
    @Part(name: 'profileImage') File? profileImage,
  });

  @POST('/api/auth/login')
  Future<ApiResponse<AuthResponse>> login(@Body() LoginRequest request);

  @POST('/api/auth/send-code')
  Future<ApiResponse<SendCodeResponse>> sendCode(
    @Body() SendCodeRequest request,
  );

  @POST('/api/auth/verify-code')
  Future<ApiResponse<String>> verifyCode(@Body() VerifyCodeRequest request);

  @POST('/api/auth/logout')
  Future<ApiResponse<String>> logout();

  @POST('/api/auth/password/reset-request')
  Future<ApiResponse<String>> resetPasswordRequest(
    @Body() SendCodeRequest request,
  );

  @POST('/api/auth/password/reset')
  Future<ApiResponse<String>> resetPassword(
    @Body() PasswordResetRequest request,
  );

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
    @Body() UpdateStartDateRequest request,
  );

  @DELETE('/api/couples')
  Future<ApiResponse<String>> deleteCouple();

  // MEMBERS
  @GET('/api/members/me')
  Future<ApiResponse<MemberInfo>> getMemberInfo();

  @PATCH('/api/members/nickname')
  Future<ApiResponse<NicknameResponse>> updateNickname(
    @Body() UpdateNicknameRequest request,
  );

  @PATCH('/api/members/birthday')
  Future<ApiResponse<BirthdayResponse>> updateBirthday(
    @Body() UpdateBirthdayRequest request,
  );

  @PATCH('/api/members/password')
  Future<ApiResponse<String>> updatePassword(
    @Body() UpdatePasswordRequest request,
  );

  @PATCH('/api/members/profileImage')
  @MultiPart()
  Future<ApiResponse<String>> updateProfileImage(
    @Part(name: 'profileImage') File profileImage,
  );

  @POST('/api/members/email/send-code')
  Future<ApiResponse<SendEmailCodeResponse>> sendEmailCode(
    @Body() SendEmailCodeRequest request,
  );

  @PATCH('/api/members/email/verify-code')
  Future<ApiResponse<String>> verifyEmailCode(
    @Body() VerifyEmailCodeRequest request,
  );

  @DELETE('/api/members')
  Future<ApiResponse<String>> deleteMember();

  // DRAFTS -> 수정

  @POST('/api/drafts')
  Future<ApiResponse<String>> createDraft(@Body() CreateDraftRequest request);

  @GET('/api/drafts/{order}/{draftType}')
  Future<ApiResponse<DraftResponse>> getDraft(
    @Path('order') int order,
    @Path('draftType') String draftType,
  );

  @DELETE('/api/drafts/{order}/{draftType}')
  Future<ApiResponse<String>> deleteDraft(
    @Path('order') int order,
    @Path('draftType') String draftType,
  );

  // LETTERS
  @POST('/api/letters')
  Future<ApiResponse<String>> createLetter(@Body() CreateLetterRequest request);

  @GET('/api/letters/{letterId}')
  Future<ApiResponse<LetterResponse>> getLetter(@Path('letterId') int letterId);

  @GET('/api/letters/list')
  Future<ApiResponse<LetterListResponse>> getLetterList(
    @Query('page') int page,
    @Query('size') int size,
  );
  @GET('/api/letters/count')
  Future<ApiResponse<int>> getLetterCount();

  @GET('/api/letters/by-date')
  Future<ApiResponse<LetterListResponse>> getLettersByDate(
    @Query('date') String formattedDate,
    @Query('page') int page,
    @Query('size') int size,
  );

  // PROMISES
  @POST('/api/promises')
  Future<ApiResponse<String>> createPromise(
    @Body() CreatePromiseRequest request,
  );

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
    @Query('day') int? day,
  );

  @GET('/api/calendar')
  Future<ApiResponse<CalendarResponse>> getCalendarWithoutDay(
    @Query('year') int year,
    @Query('month') int month,
  );

  // FCM

  @POST('/api/fcm/token')
  Future<ApiResponse<String>> registerFCMToken(@Body() FCMTokenRequest request);
  //원래 맵 형태로 해야하는데 g 파일 오류가 해결이 안되어서 일단은 리스트로 받고 레퍼지토리 코드에서 처리하게 해둠.
  @GET('/api/fcm/notifications')
  Future<ApiResponse<List<PushNotificationResponse>>> getPushNotifications(
    @Query('page') int page,
    @Query('size') int size,
  );

  @POST('/api/fcm/read/{notificationId}')
  Future<ApiResponse<String>> markNotificationAsRead(
    @Path('notificationId') int notificationId,
  );
}
