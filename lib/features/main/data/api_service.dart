// lib/data/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:love_keeper_fe/constants/api_constants.dart';

class ApiService {
  // 캘린더 이벤트 데이터를 받아오는 함수
  Future<List<dynamic>> fetchCalendarEvents(
      {required int year, required int month}) async {
    // 모바일에서 localhost 사용 시, 에뮬레이터 주소(예: 10.0.2.2)로 변경할 수 있음
    final url = 'https://lovekeeper.site//api/calendar?year=$year&month=$month';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      // API의 응답 구조에 따라 수정 (예: jsonData['events'] 등)
      return jsonData as List<dynamic>; // 리스트 형태로 반환한다고 가정
    } else {
      throw Exception('캘린더 이벤트 로드 실패: ${response.statusCode}');
    }
  }
}
