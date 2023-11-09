import '../../../../common/either.dart';
import '../../../../common/error.dart';
import '../../../../models/dtos/city.dart';
import '../../data_sources/example/example_data_source.dart';
import '../api.dart';
import '../api_path.dart';

class ExampleAuthApi extends Api implements ExampleDataSource {
  ExampleAuthApi(super.dio);

  @override
  Future<Either<DataSourceError, List<City>>> getCities() => withTimeoutRequest(
        () async {
          final data = await dio.get(ApiPath.cities);
          return (data.data as List<dynamic>)
              .map((e) => City.fromJson(e))
              .toList();
        },
      );
}
