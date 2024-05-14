import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../provider/produk_state.dart';
import '../provider/produk_detail.dart';
class DetailProdukPage extends StatefulWidget {
  const DetailProdukPage({super.key, required this.id});
  final String id; // Add a constructor parameter for the ID

  @override
  _DetailProdukPageState createState() => _DetailProdukPageState();
}

class _DetailProdukPageState extends State<DetailProdukPage> {

  @override
  void initState() {
    super.initState();
    Provider.of<ProdukDetail>(context, listen: false).fetchData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
      (
        backgroundColor: const Color.fromARGB(255, 36, 36, 36),
        title: const Text
        (
          'Detail Produk', 
          style: TextStyle
          (
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton
        ( // Tambahkan leading untuk menampilkan ikon kembali
          icon: const Icon(Icons.arrow_back_ios_new_rounded), // Gunakan ikon kembali
          color: Colors.white,
          onPressed: () 
          {
            Navigator.of(context).pop(); // Panggil metode pop untuk kembali ke halaman sebelumnya
          },
        ),
      ),
      body: SingleChildScrollView
      (
        child: Consumer<ProdukDetail>
        (
          builder: (context, produkDetail, child) {
            final hargaFormatted = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp').format(produkDetail.produk.price);
            return Column
            (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: 
              [
                Image.asset
                (
                  'images/${produkDetail.produk.image}',
                  fit: BoxFit.contain,
                ),
                Padding
                (
                  padding: const EdgeInsets.all(12.0),
                  child: Column
                  (
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: 
                    [
                      Container
                      (
                        height: 35,
                        decoration: const BoxDecoration
                        (
                          color: Colors.black,
                        ),
                        child: const Padding
                        (
                          padding: EdgeInsets.all(5.0),
                          child: Row
                          (
                            children: 
                            [
                              Icon
                              (
                                Icons.verified_user,
                                color: Colors.white,
                              ),
                              SizedBox(width: 3),
                              Text
                              (
                                "Secured Transaction",
                                style: TextStyle
                                (
                                  color: Colors.white,
                                ),
                              ),
                              Spacer(),
                              Icon
                              (
                                Icons.chevron_right,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Text
                      (
                        hargaFormatted,
                        style: const TextStyle
                        (
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Text
                      (
                        produkDetail.produk.name,
                      ),
                      const SizedBox(height: 5,),
                      Text
                      (
                        produkDetail.produk.location,
                        style: const TextStyle
                        (
                          color: Colors.grey
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Builder
                      (
                        builder: (context) 
                        {
                          var colorCondition;
                          if (produkDetail.produk.condition == "Brand New In Box" || produkDetail.produk.condition == "Brand New Open Box" ) 
                          {
                            colorCondition = Colors.indigoAccent;
                          } 
                          else if(produkDetail.produk.condition == "Very Good Condition" || produkDetail.produk.condition == "Good Condition")
                          {
                            colorCondition = Colors.green[300];
                          }
                          else
                          {
                            colorCondition = Colors.orange[400];
                          }
                          return Container
                          (
                            decoration: BoxDecoration
                            (
                              color: Colors.transparent,
                              border: Border.all(color: colorCondition, width: 1.5)
                            ),
                            child: Padding
                            (
                              padding: const EdgeInsets.all(2.0),
                              child: Row
                              (
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: 
                                [
                                  Icon(Icons.check_circle, color: colorCondition,),
                                  const SizedBox(width: 3,),
                                  Expanded
                                  (
                                    child: Text
                                    (
                                      produkDetail.produk.condition,
                                      style: TextStyle
                                      (
                                        color: colorCondition,
                                        fontSize: 12
                                      ),
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
                          );
                        }
                      ),
                      const SizedBox(height: 10,),
                      Row
                      (
                        children: 
                        [
                          const Text
                          (
                            "Tanggal Publish",
                          ),
                          const SizedBox(width: 30),
                          Text
                          (
                            produkDetail.produk.publish_date,
                            style: const TextStyle
                            (
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container // garis abu
                      (
                        decoration: const BoxDecoration
                        (
                          border: Border
                          (
                            bottom: BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Row
                      (
                        children: 
                        [
                          const Text
                          (
                            "Category",
                          ),
                          const SizedBox(width: 75),
                          Text
                          (
                            produkDetail.produk.category,
                            style: const TextStyle
                            (
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container // garis abu
                      (
                        decoration: const BoxDecoration
                        (
                          border: Border
                          (
                            bottom: BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}