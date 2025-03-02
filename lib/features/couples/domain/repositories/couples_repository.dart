import 'package:love_keeper_fe/features/couples/data/models/response/couples_response.dart';

import '../entities/invite_code.dart';

abstract class CouplesRepository {
  Future<CoupleInfo> getCoupleInfo();
  Future<InviteCode> generateCode();
  Future<String> connect(String inviteCode);
  Future<int> getDaysSinceStarted();
  Future<String> getStartDate();
  Future<String> updateStartDate(String newStartDate);
  Future<String> deleteCouple();
}
