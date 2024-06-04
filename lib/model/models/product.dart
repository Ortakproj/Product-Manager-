//import 'package:flutter/foundation.dart';

class Product {
  String? _id;
  String? _name;
  String? _description;
  String? _category;
  String? _brand;
  String? _stockquantity;
  String? _price;
  String? _date;
  String? _id_user_created;

  Product(this._id, this._name, this._description, this._category, this._brand,
      this._stockquantity, this._price, this._date, this._id_user_created);
  Product.empty(
      this._id,
      this._name,
      this._description,
      this._category,
      this._brand,
      this._stockquantity,
      this._price,
      this._date,
      this._id_user_created);

  // Getters
  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get idUserCreated => _id_user_created;
  String? get price => _price;
  String? get Category => _category;
  String? get brand => _brand;
  String? get stockquantity => _stockquantity;
  String? get date => _date;

  // Setters

  set id(id) {
    _id = id;
  }

  set name(value) {
    _name = value;
  }

  set description(value) {
    _description = value;
  }

  set idUserCreated(value) {
    _id_user_created = value;
  }

  set Category(value) {
    _category = value;
  }

  set price(value) {
    _price = value;
  }

  set date(value) {
    _date = value;
  }

  set stockquantity(value) {
    _stockquantity = value;
  }

  // Convert a Product object into a Map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['description'] = _description;
    map['category'] = _category;
    map['brand'] = _brand;
    map['stockquantity'] = _stockquantity;
    map['price'] = _price;
    map['date'] = _date;
    map['id_user_created'] = _id_user_created;
    return map;
  }

  // Extract a Product object from a Map object
  Product.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _name = map['name'];
    _description = map['description'];
    _category = map['category'];
    _brand = map['brand'];
    _stockquantity = map['stockquantity'];
    _price = map['price'];
    _date = map['date'];
    _id_user_created = map['id_user_created'];
  }
}
