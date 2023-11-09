import '../../common/either.dart';
import '../../common/error.dart';
import '../../models/dtos/city.dart';

abstract class ExampleRepository {
  Future<Either<DataSourceError, List<City>>> getCities();
}
