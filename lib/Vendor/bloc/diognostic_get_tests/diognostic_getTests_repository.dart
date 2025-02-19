import 'package:revxpharma/Models/SuccessModel.dart';
import 'package:revxpharma/Vendor/VendorModel/VendorGetTestsModel.dart';
import 'package:revxpharma/data/api_routes/VendorRemoteDataSource.dart';

abstract class DiagnosticGetTestsRepositors {

  Future<VendorGetTestsModel?> VendorgetTest();
  Future<SuccessModel?> VendordelateTest(id);

}
class DiagnosticGetTestsImp extends DiagnosticGetTestsRepositors{

   VendorRemoteDataSource vendorRemoteDataSource;
   DiagnosticGetTestsImp({required this.vendorRemoteDataSource});

   Future<VendorGetTestsModel?> VendorgetTest() async{
     return await vendorRemoteDataSource.DiagnosticgetTests();
   }
   Future<SuccessModel?> VendordelateTest(id) async{
     return await vendorRemoteDataSource.DiagnosticDelateTest(id);
   }

}