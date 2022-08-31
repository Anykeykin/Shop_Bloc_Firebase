import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:shop_app/data/repository.dart';


part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(ShopPageLoadedState()) {
    on<AddBuy>(_onAddBuy);
    on<DeleteBuy>(_onDeleteBuy);
    on<SavingBasket>(_onSavingBasket);
    on<DeleteBasket>(_onDeleteBasket);
  }
}

void _onAddBuy(AddBuy event,Emitter<ShopState> emit) async {
  emit(Loading());
  try{
    await ReadSaveDeleteBasket().deleteShop(event.id, event.name);
    await ReadSaveDeleteBuy().saveShop(event.id, event.name);
    emit(ShopPageLoadedState());
  } catch (e) {}
}

void _onDeleteBuy(DeleteBuy event,Emitter<ShopState> emit) async{
  emit(Loading());
  try{
    ReadSaveDeleteBuy().deleteShop(event.id, event.name);
    emit(ShopPageLoadedState());
  } catch (e) {}
}

void _onSavingBasket(SavingBasket event,Emitter<ShopState> emit) {
  emit(Loading());
  try{
    ReadSaveDeleteBasket().saveShop(event.id, event.name);
    emit(ShopPageLoadedState());
  } catch (e) {}
}


void _onDeleteBasket(DeleteBasket event,Emitter<ShopState> emit) {
  emit(Loading());
  try{
    ReadSaveDeleteBasket().deleteShop(event.id, event.name);
    emit(ShopPageLoadedState());
  } catch (e) {}
}

class RSD{
  rsdBasket(userid){
    return ReadSaveDeleteBasket().readShop(userid);
  }
  rsdBuy(userid){
    return ReadSaveDeleteBuy().readShop(userid);
  }
}