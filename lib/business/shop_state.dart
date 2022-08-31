part of 'shop_bloc.dart';

@immutable
abstract class ShopState extends Equatable {}

class Loading extends ShopState {
  @override
  List<Object?> get props => [];
}

class ShopPageLoadedState extends ShopState{
  @override
  List<Object?> get props => [];
}

// class ItemAddingCartState extends ShopState{
//   @override
//   List<Object?> get props => [];
// }
//
// class ItemDeletingCartState extends ShopState{
//   @override
//   List<Object?> get props => [];
// }

