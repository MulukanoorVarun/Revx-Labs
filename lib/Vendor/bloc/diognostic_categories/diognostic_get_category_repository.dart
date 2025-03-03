import 'package:revxpharma/Models/DiognosticGetCategoriesModel.dart';
import 'package:revxpharma/data/api_routes/VendorRemoteDataSource.dart';

abstract class DiognosticGetCategoryRepository{
  Future<DiognosticGetCategoriesModel?> GetDiognosticCategorys();

}
class DiognosticGetCategoryImpl extends DiognosticGetCategoryRepository{
   final VendorRemoteDataSource vendorRemoteDataSource;

   DiognosticGetCategoryImpl({required this.vendorRemoteDataSource});

   Future<DiognosticGetCategoriesModel?> GetDiognosticCategorys() async{
    return await  vendorRemoteDataSource.DiognosticGetCategorys();
   }

}