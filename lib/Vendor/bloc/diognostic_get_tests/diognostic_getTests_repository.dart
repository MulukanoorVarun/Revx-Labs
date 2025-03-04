import 'package:revxpharma/Models/SuccessModel.dart';
import 'package:revxpharma/Vendor/VendorModel/VendorGetTestsModel.dart';
import 'package:revxpharma/data/api_routes/VendorRemoteDataSource.dart';

abstract class DiagnosticTestsRepository {

  Future<VendorGetTestsModel?> VendorgetTest();
  Future<SuccessModel?> VendordelateTest(id);

}
class DiagnosticTestsImp extends DiagnosticTestsRepository{

   VendorRemoteDataSource vendorRemoteDataSource;
   DiagnosticTestsImp({required this.vendorRemoteDataSource});

   Future<VendorGetTestsModel?> VendorgetTest() async{
     return await vendorRemoteDataSource.DiagnosticgetTests();
   }
   Future<SuccessModel?> VendordelateTest(id) async{
     return await vendorRemoteDataSource.DiagnosticDelateTest(id);
   }

}