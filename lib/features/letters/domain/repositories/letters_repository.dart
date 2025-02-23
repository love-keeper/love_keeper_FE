import '../entities/letter_list.dart';

abstract class LettersRepository {
  Future<String> createLetter(String content);
  Future<LetterList> getLetterList(int page, int size);
  Future<int> getLetterCount();
  Future<LetterList> getLettersByDate(String date, int page, int size);
}
