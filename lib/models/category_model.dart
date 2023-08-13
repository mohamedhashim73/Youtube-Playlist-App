class CategoryModel{
  int? id;
  String? url;
  String? title;

  // Refactoring Json
  CategoryModel.fromJson({required Map<String,dynamic> data}){
    id = data['id'];
    url = data['image'];
    title = data['name'];
  }
}