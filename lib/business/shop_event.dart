part of 'shop_bloc.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

class ShopPageInitialized extends ShopEvent{}

class DeleteBasket extends ShopEvent{
  final String name;
  final String id;

  DeleteBasket(this.name,this.id);
}

class SavingBasket extends ShopEvent{
  final String name;
  final String id;

  SavingBasket(this.name,this.id);
}


class AddBuy extends ShopEvent{
  final String name;
  final String id;

  AddBuy(this.name,this.id);
}

class DeleteBuy extends ShopEvent{
  final String name;
  final String id;

  DeleteBuy(this.name,this.id);
}
