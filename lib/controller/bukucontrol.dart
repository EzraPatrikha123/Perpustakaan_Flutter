import 'package:perpustakaan/models/bukumodel.dart';

class Bukucontrol {
  final List<Bukumodel> buku = [
    Bukumodel(
      id: 1, 
      title: 'What.', 
      penulis: 'Ezra',
      penerbit: "b",
      stock: 30, 
      posterPath: 'image/Girl.jpg',),
      Bukumodel(
      id: 2, 
      title: 'What?!', 
      penulis: 'Bimo',
      penerbit: 'aaa',
      stock: 54, 
      posterPath: 'image/Girl.jpg'),
  ];
}