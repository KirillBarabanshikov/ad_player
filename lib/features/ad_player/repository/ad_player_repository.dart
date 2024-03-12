import 'package:dio/dio.dart';

import '../models/models.dart';

class AdPlayerRepository {
  const AdPlayerRepository(this.dio);

  final Dio dio;

  Future<List<AdvertisementModel>> getAdvertisementByDrugstoreId(
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

      final advertisements = (response.data as List)
          .map((e) => AdvertisementModel.fromJson(e))
          .toList();

      advertisements.sort((a, b) => a.dateBegin.compareTo(b.dateBegin));

      return advertisements;
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
