import 'package:love_keeper/features/couples/data/models/response/couple_info.dart';

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
