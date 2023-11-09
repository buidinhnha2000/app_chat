import '../../../common/base_state.dart';
import '../../../common/error.dart';
import '../../../models/dtos/city.dart';

/// States should extend [BaseState]
abstract class HomeState extends BaseState {}

class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

class CitiesLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class LoadCitiesSuccess extends HomeState {
  LoadCitiesSuccess(this.cities);

  final List<City> cities;

  @override
  List<Object?> get props => [cities];
}

class LoadCitiesError extends HomeState {
  LoadCitiesError(this.error);

  final DataSourceError error;

  @override
  List<Object?> get props => [error];
}
