import '../../../Models/CategoryModel.dart';
import '../../../data/api_routes/remote_data_source.dart';

abstract class CategoryRepository {
  Future<CategoryModel?> getCategories(String query);
}

class CategoryRepositoryImpl implements CategoryRepository {
  final RemoteDataSource remoteDataSource;

  CategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<CategoryModel?> getCategories(String query) async {
    return await remoteDataSource.fetchCategories(query);
  }
}
