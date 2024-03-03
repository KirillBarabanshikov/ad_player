import 'package:dio/dio.dart';

import 'models/advertisement_model.dart';

class AdPlayerRepository {
  const AdPlayerRepository(this.dio);

  final Dio dio;

  Future<AdvertisementModel> getAdvertisementByDrugstoreId(
    int id,
    String apiKey,
  ) async {
    try {
      final response = await dio.get('rest/advertisement/bydrugstoreid/$id',
          options: Options(
            headers: {
              'X-Authorization-token': apiKey,
            },
          ));
      return AdvertisementModel.fromJson(response.data[0]);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
