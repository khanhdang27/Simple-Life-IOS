import 'package:baseproject/repositories/repositories.dart';
import 'package:dio/dio.dart';

class FeedbackRepository extends Repository {
  Future<bool> add({
    required int productId,
    required double score,
    required String feedback,
  }) async {
    FormData formData = FormData.fromMap({
      'product_id': productId,
      'score': score.toInt(),
      'feedback': feedback,
    });
    Map response = await httpManager.post(
      url: '/feedback/add',
      data: formData,
    );
    if (response['data'] != null) {
      return true;
    }
    return false;
  }
}
