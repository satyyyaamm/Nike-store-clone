import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/constants/contants.dart';
import 'package:nike_store/screens/productpage.dart';
import 'package:nike_store/services/firebaseServices.dart';
import 'package:nike_store/widget/ProductCard.dart';
import 'package:nike_store/widget/custominput.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices firebaseServices = FirebaseServices();

  String _search = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          (_search.isEmpty)
              ? Center(
                  child: Text(
                    'Search Results',
                    style: Constants.regulardarktext,
                  ),
                )
              : FutureBuilder<QuerySnapshot>(
                  future: firebaseServices.productreference
                      .orderBy('search')
                      .startAt([_search]).endAt(['$_search\uf8ff']).get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Scaffold(
                        body: Center(
                          child: Text('error: ${snapshot.error}'),
                        ),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView(
                        padding: EdgeInsets.only(top: 100, bottom: 12),
                        children: snapshot.data.docs.map((document) {
                          return ProductCard(
                            title: document.data()['name'],
                            imageUrl: document.data()['images'][0],
                            price: '\$${document.data()['price']}',
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                    productId: document.id,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      );
                    }
                    return Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: CustomInput(
              onsubmitted: (value) {
                setState(() {
                  _search = value.toLowerCase();
                });
              },
              hinttext: 'Search',
            ),
          ),
        ],
      ),
    );
  }
}
