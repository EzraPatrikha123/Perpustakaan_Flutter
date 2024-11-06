class Bukumodel {
  int id;
  String title;
  String penulis;
  String penerbit;
  int stock;
  double? rating;
  String posterPath;
  Bukumodel({
  required this.id, 
  required this.title,
  required this.stock,
  this.rating,
  required this.posterPath,
  required this.penulis,
  required this.penerbit
  });
}