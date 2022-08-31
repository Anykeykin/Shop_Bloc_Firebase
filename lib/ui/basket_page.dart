import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business/shop_bloc.dart';
import 'package:shop_app/data/repository.dart';
import 'package:shop_app/ui/buy_page.dart';


class BasketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userid = FirebaseAuth.instance.currentUser!.uid;
    final _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список покупок'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BuyPage()));
              },
              icon: Icon(Icons.shopping_basket))
        ],
      ),
      body: BlocConsumer<ShopBloc, ShopState>(
  listener: (context, state) {},
  builder: (context, state) {
    if (state is Loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if(state is ShopPageLoadedState){
      return Stack(
        children: [
          StreamBuilder(
              stream: RSD().rsdBasket(userid),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff205431),
                    ),
                  );
                }
                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                    bool isChecked = false;
                    return ListTile(
                      leading: Checkbox(
                        onChanged: (bool? value) async {
                          isChecked = value!;
                          context.read<ShopBloc>().add(AddBuy(data['name'], userid));
                        },
                        value: isChecked,
                      ),
                      title: Text('${data['name']}'),
                      trailing: IconButton(
                          onPressed: () {
                            context.read<ShopBloc>().add(DeleteBasket(data['name'], userid));
                          },
                          icon: const Icon(Icons.delete)),
                    );
                  }).toList(),
                );
              }),
          Container(
              width: double.infinity,
              height: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: TextField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                  hintText: 'Добавьте товар',
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0))),
                            ),
                          ),
                        ),
                        Material(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xff204531),
                          child: Container(
                            margin: EdgeInsets.all(5),
                            child: IconButton(
                                onPressed: () {
                                  context.read<ShopBloc>().add(SavingBasket( _controller.text,userid));
                                  _controller.clear();
                                },
                                icon: const Icon(Icons.add)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ))
        ],
      );
    }
    return Container();
  },
),
    );
  }
}
