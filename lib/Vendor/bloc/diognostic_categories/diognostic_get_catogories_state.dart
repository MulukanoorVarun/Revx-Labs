import 'package:revxpharma/Models/DiognosticGetCategoriesModel.dart';

abstract class DiognosticCategoryState{

}
class DiognosticCategoryIntially extends DiognosticCategoryState{
  
}
class DiognosticCategoryLoading extends DiognosticCategoryState{
}
class DiognosticCategoryLoaded extends DiognosticCategoryState{
  DiognosticGetCategoriesModel diognosticGetCategoriesModell;
  DiognosticCategoryLoaded(this.diognosticGetCategoriesModell);



}
class DiognosticCategoryError extends DiognosticCategoryState{
  final String message;
  DiognosticCategoryError(this.message);

}