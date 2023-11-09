import '../../../../common/either.dart';
import '../../../../common/error.dart';
import '../../../../domain/repositories/example_repository.dart';
import '../../../../models/dtos/city.dart';
import 'example_data_source.dart';

class ExampleRepositoryImpl implements ExampleRepository {
  final ExampleDataSource exampleDataSource;

  const ExampleRepositoryImpl(this.exampleDataSource);

  @override
  Future<Either<DataSourceError, List<City>>> getCities() =>
      exampleDataSource.getCities();
}
