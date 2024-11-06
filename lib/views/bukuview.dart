import 'package:flutter/material.dart';
import 'package:perpustakaan/controller/bukucontrol.dart';
import 'package:perpustakaan/models/bukumodel.dart';
import 'package:perpustakaan/widgets/modal.dart';

class Bukuview extends StatefulWidget {
  const Bukuview({super.key});

  @override
  State<Bukuview> createState() => _BukuviewState();
}

class _BukuviewState extends State<Bukuview> {
  Bukucontrol buku = Bukucontrol();
  final FormKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController penulis = TextEditingController();
  TextEditingController penerbit = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController gambar = TextEditingController();
  TextEditingController voteaverage = TextEditingController();
  List buttonChoice = ['Update','Hapus'];
  List? DataBuku;
  int? Bukuid;
  getBuku(){
    setState(() {
       DataBuku = buku.buku;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   getBuku();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
        title: Center(child: Text('Perpustakaan')),
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                Bukuid = null;
              });
              title.text = '';
              penulis.text = '';
              penerbit.text = '';
              stock.text = '';
              voteaverage.text = "";
              gambar.text = "";
              ModalWidget().showFullModal(context, addItem(null));
            }, 
            icon: Icon(Icons.add))
        ],
      ),

      body: ListView.builder(
        itemCount: DataBuku!.length,
        itemBuilder: (_,index) {
          return Card(
            child: ListTile(
              leading: Image(image: AssetImage(DataBuku![index].posterPath)),
              title: Row(
                children: [
                  Text(DataBuku![index].title),
                  SizedBox(width: 20,),
                  Text(DataBuku![index].penulis)
                ],
              ),
              trailing: PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return buttonChoice.map((kon){
                    return PopupMenuItem(
                      value: kon,
                      child: Text(kon),
                      onTap: (){
                        if(kon == 'Update'){
                          setState(() {
                            Bukuid = DataBuku![index].id; 
                          });

                          title.text = DataBuku![index].title;  
                          penulis.text = DataBuku![index].penulis;
                          penerbit.text = DataBuku![index].penerbit;
                          stock.text = DataBuku![index].stock.toString();
                          gambar.text = DataBuku![index].posterPath;
                          voteaverage.text = DataBuku![index].rating.toString();
                          ModalWidget().showFullModal(context, addItem(index));
                        } else if (kon == "Hapus"){
                          DataBuku!.removeWhere(
                            (item) => item.id == DataBuku![index].id);
                            getBuku();
                        }
                      },
                      );
                  }).toList();
                }
                ),
            ),
          );
        }
        ),
    );
  }

  Widget addItem(int? index){
    return Container(
      child: Form(
        key: FormKey,
        child: Column(
          children: [
            TextFormField(
              controller: title,
              decoration: InputDecoration(label: Text('Book Title')),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Harus Diisi!';
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              controller: penulis,
              decoration: InputDecoration(label: Text('Nama penulis')),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Harus Diisi!';
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              controller: penerbit,
              decoration: InputDecoration(label: Text('Nama penerbit')),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Harus Diisi!';
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              controller: stock,
              decoration: InputDecoration(label: Text('Stock tersedia')),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Harus Diisi!';
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              controller: voteaverage,
              decoration: InputDecoration(label: Text('Rating')),
              validator: (value) {
                if (value!.isEmpty) {
                  return null;
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              controller: gambar,
              decoration: InputDecoration(label: Text('Cover buku')),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Harus Diisi!';
                } else {
                  return null;
                }
              },
            ),
            ElevatedButton(
              onPressed: (){
                if (FormKey.currentState!.validate()) {
                  if (index != null) {  
                    DataBuku![index].id = Bukuid;
                    DataBuku![index].title = title.text;
                    DataBuku![index].penulis = penulis.text;
                    DataBuku![index].penerbit = penerbit.text;
                    DataBuku![index].stock = double.parse(stock.text);
                    DataBuku![index].voteaverage = double.parse(voteaverage.text);
                    getBuku();
                    Navigator.pop(context);
                  } else{
                    int _id_buku = DataBuku!.length + 1;
                    DataBuku!.add(Bukumodel(
                      id: _id_buku, 
                      title: title.text, 
                      stock: int.parse(stock.text), 
                      posterPath: gambar.text, 
                      penulis: penulis.text, 
                      penerbit: penerbit.text,
                      rating: double.parse(voteaverage.text)
                      ));
                      getBuku();
                      Navigator.pop(context);
                  }
                }
              }, 
              child: Text("Simpan"))
          ],
        )),
    );
  }
}
