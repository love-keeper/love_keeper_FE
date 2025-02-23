import '../entities/promise_list.dart';

abstract class PromisesRepository {
  Future<String> createPromise(String content);
  Future<PromiseList> getPromises(int page, int size);
  Future<String> deletePromise(int promiseId);
  Future<int> getPromiseCount();
  Future<PromiseList> getPromisesByDate(String date, int page, int size);
}
