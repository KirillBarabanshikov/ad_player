import 'package:dio/dio.dart';

import '../models/models.dart';

class AdPlayerRepository {
  const AdPlayerRepository(this.dio);

  final Dio dio;

  Future<AdvertisementModel> getAdvertisementByDrugstoreId(
    SettingsModel settings,
  ) async {
    try {
      final response = await dio.get(
        'rest/advertisement/bydrugstoreid/${settings.shopId}',
        options: Options(
          headers: {
            'X-Authorization-token': settings.apiKey,
          },
        ),
      );

      return AdvertisementModel.fromJson(response.data[0]);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
