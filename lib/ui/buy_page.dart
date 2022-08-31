import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business/shop_bloc.dart';

class BuyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Купленные товары'),
        centerTitle: true,
      ),
      body: BlocConsumer<ShopBloc, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is Loading) {
            return const Center(
                child: CircularProgressIndicator(
              color: Color(0xff205431),
            ));
          }
          if (state is ShopPageLoadedState) {
            return Stack(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: RSD().rsdBuy(userid),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff205431),
                        ),
                      );
                    }
                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return ListTile(
                          title: Text('${data['name']}'),
                          trailing: IconButton(
                              onPressed: () {
                                context.read<ShopBloc>().add(DeleteBuy(data['name'],userid));
                              },
                              icon: const Icon(Icons.delete)),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
