import 'package:flutter/material.dart';
import 'package:nike_store/constants/contants.dart';
import 'package:nike_store/services/firebaseServices.dart';
import 'package:nike_store/widget/customactionbar.dart';
import 'package:nike_store/widget/imageswipe.dart';
import 'package:nike_store/widget/productSize.dart';

class ProductPage extends StatefulWidget {
  final String productId;

  const ProductPage({Key key, this.productId}) : super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _selectedProductSize = "0";

  Future<void> _addToCart() async {
    return await _firebaseServices.userreference
        .doc(_firebaseServices.getUserId())
        .collection('cart')
        .doc(widget.productId)
        .set({'size': _selectedProductSize});
  }

  Future<void> _addToSave() async {
    return _firebaseServices.userreference
        .doc(_firebaseServices.getUserId())
        .collection('saved')
        .doc(widget.productId)
        .set({'size': _selectedProductSize});
  }

  final SnackBar _cartSnackBar = SnackBar(
    content: Text('Product added to the cart'),
  );
  final SnackBar _saveSnackBar = SnackBar(
    content: Text('Product added to saved Products'),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          FutureBuilder(
              future: _firebaseServices.productreference
                  .doc(widget.productId)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text('error: ${snapshot.error}'),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  // firebase document data map
                  Map<String, dynamic> documentData = snapshot.data.data();
                  // custom imagelist made from firebase docoument data map
                  List imageList = documentData['images'];
                  List productSize = documentData['size'];

                  // set this as initial size
                  _selectedProductSize = productSize[0];

                  return ListView(
                    padding: EdgeInsets.all(0),
                    children: [
                      ImageSwipe(imageList: imageList),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 24, left: 24, right: 24, bottom: 4),
                        child: Text(
                          '${documentData['name']}' ?? 'Product Name',
                          style: Constants.boldheading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 24,
                        ),
                        child: Text(
                          '\$${documentData['price']}' ?? 'Prize',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 24,
                        ),
                        child: Text(
                          '${documentData['description']}' ?? 'Description',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 24,
                        ),
                        child: Text(
                          'Select Size',
                          style: Constants.regulardarktext,
                        ),
                      ),
                      ProductSize(
                        productSize: productSize,
                        onSelected: (size) {
                          _selectedProductSize = size;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await _addToSave();
                                Scaffold.of(context)
                                    .showSnackBar(_saveSnackBar);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 65,
                                height: 65,
                                decoration: BoxDecoration(
                                  color: Color(0xFFDCDCDC),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Image.asset(
                                  'assets/images/tab_saved.png',
                                  width: 13,
                                  height: 21,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await _addToCart();
                                  Scaffold.of(context)
                                      .showSnackBar(_cartSnackBar);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: 16,
                                  ),
                                  alignment: Alignment.center,
                                  height: 65,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.black),
                                  child: Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
          CustomActionBar(
            hasTitle: false,
            hasBackArrow: true,
            hasBackGround: false,
          )
        ],
      )),
    );
  }
}
