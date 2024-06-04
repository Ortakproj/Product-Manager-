import 'package:product_manager/Controller/utils/firestore.dart';
import 'package:product_manager/Model/models/product.dart';

//import '../models/product.dart';
import 'view_product_screen.dart';
//import '../utils/firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProductScreen extends StatefulWidget {
  final String productId;
  final User _user;

  const UpdateProductScreen(
      {Key? key, required User user, required this.productId})
      : _user = user,
        super(key: key);

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime dateTime = DateTime(2023, 01, 19);
  final TextEditingController _stockquantityController =
      TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final FocusNode _dateOfBirthFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> userId;
  late String currentUserId = '';
  bool _isLoaded = false;

  final _nameKey = GlobalKey();
  final _descriptionKey = GlobalKey();
  final _stockquantityKey = GlobalKey();
  final _priceKey = GlobalKey();
  final _dateKey = GlobalKey();
  final _categoryKey = GlobalKey();
  final _brandKey = GlobalKey();
  final String requireFieldValidateMsg =
      "product_page.require_field_validate_msg".tr();
  String formTitle = "product_page.form_title".tr();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _stockquantityController.dispose();
    _brandController.dispose();
    _dateController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    _dateOfBirthFocusNode.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId = _prefs.then((SharedPreferences prefs) {
      currentUserId = prefs.getString('uid') ?? '';
      return prefs.getString('uid') ?? '';
    });
    getProductInfo();
  }

  Future getProductInfo() async {
    Product? product =
        await FireStore.getEntryById('product', widget.productId);
    if (product != null) {
      _nameController.text = product.name ?? '';
      _descriptionController.text = product.description ?? '';
      _stockquantityController.text = product.stockquantity ?? '';
      _brandController.text = product.brand ?? '';
      _dateController.text = product.date ?? '';
      _priceController.text = product.price ?? '';
      _categoryController.text = product.Category ?? '';
    }
    setState(() {
      _isLoaded = true;
    });
  }

  Future saveProduct() async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      } else {
        Product product = Product(
            widget.productId,
            _nameController.text,
            _descriptionController.text,
            _categoryController.text,
            _brandController.text,
            _stockquantityController.text,
            _priceController.text,
            _dateController.text,
            currentUserId);
        FireStore.updateEntryWithId(
                'product', widget.productId, product.toMap())
            .then((value) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ViewProductScreen(user: widget._user),
            ),
          );
        });
        // showSuccessAlert(context);
      }
    } catch (error) {
      // executed for errors of all types other than Exception
      print(error);
      // showErrorAlert(context, error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: !_isLoaded
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: _formKey,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.all(15.0),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/indir.jpg"),
                        fit: BoxFit.cover,
                        opacity: 0.4,
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            key: _nameKey,
                            controller: _nameController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return requireFieldValidateMsg;
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: "name",
                              prefixIcon: Icon(Icons
                                  .person), // Add person icon for first name
                            ),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            key: _descriptionKey,
                            controller: _descriptionController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return requireFieldValidateMsg;
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: "description",
                              prefixIcon: Icon(Icons
                                  .person), // Add person icon for last name
                            ),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            key: _categoryKey,
                            controller: _categoryController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return requireFieldValidateMsg;
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "category".tr(),
                              prefixIcon: const Icon(Icons
                                  .person), // Add person icon for last name
                            ),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            key: _brandKey,
                            controller: _brandController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return requireFieldValidateMsg;
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: "brand",
                              prefixIcon: Icon(Icons
                                  .person), // Add person icon for last name
                            ),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            key: _stockquantityKey,
                            controller: _stockquantityController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return requireFieldValidateMsg;
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: "stockquantity",
                              prefixIcon: Icon(Icons
                                  .person), // Add person icon for last name
                            ),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            key: _priceKey,
                            controller: _priceController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return requireFieldValidateMsg;
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: "price",
                              prefixIcon: Icon(Icons
                                  .person), // Add person icon for last name
                            ),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            key: _dateKey,
                            controller: _dateController,
                            focusNode: _dateOfBirthFocusNode,
                            validator: (String? value) {
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "date",
                              prefixIcon: const Icon(Icons.calendar_today),
                              // Add calendar icon for date of birth
                              hintText:
                                  '${dateTime.day}/${dateTime.month}/${dateTime.year}',
                              // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))
                            ),
                            onTap: () async {
                              DateTime? newDate = await showDatePicker(
                                  context: context,
                                  initialDate: dateTime,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now());
                              if (newDate == null) return;
                              setState(() {
                                dateTime = newDate;
                                _dateController.text =
                                    '${dateTime.day}/${dateTime.month}/${dateTime.year}'; // Tarih değerini kaydet
                              });
                            },
                            onEditingComplete: () {
                              _dateOfBirthFocusNode
                                  .unfocus(); // Form alanından çıkıldığında (tarih seçiminden sonra), odak durumunu kaldırır.
                            },
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Expanded(child: Container()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FloatingActionButton(
                                tooltip: 'save',
                                onPressed: () async {
                                  await saveProduct();
                                },
                                child: const Icon(Icons.save),
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  var navigator = Navigator.of(context);
                                  navigator.pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ViewProductScreen(user: widget._user),
                                    ),
                                  );
                                },
                                tooltip: 'back',
                                child: const Icon(Icons.arrow_back_outlined),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // ],
                ),
        ),
      ),
    );
  }
}
/*
import '../models/product.dart';
import '../screens/view_product_screen.dart';
import '../utils/firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProductScreen extends StatefulWidget {
  final String productId;
  final User _user;

  const UpdateProductScreen(
      {Key? key, required User user, required this.productId})
      : _user = user,
        super(key: key);

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime dateTime = DateTime(2023, 01, 19);
  final TextEditingController _stockquantityController =
      TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final FocusNode _dateOfBirthFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> userId;
  late String currentUserId = '';
  bool _isLoaded = false;

  final String requireFieldValidateMsg =
      "require_field_valid";
  String formTitle = "form_title";

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _stockquantityController.dispose();
    _brandController.dispose();
    _dateController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    _dateOfBirthFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    userId = _prefs.then((SharedPreferences prefs) {
      currentUserId = prefs.getString('uid') ?? '';
      return prefs.getString('uid') ?? '';
    });
    getProductInfo();
  }

  Future<void> getProductInfo() async {
    try {
      Product? product =
          await FireStore.getEntryById('product', widget.productId);
      if (product != null) {
        _nameController.text = product.name ?? '';
        _descriptionController.text = product.description ?? '';
        _stockquantityController.text = product.stockquantity ?? '';
        _brandController.text = product.brand ?? '';
        _dateController.text = product.date ?? '';
        _priceController.text = product.price ?? '';
        _categoryController.text = product.Category ?? '';
      }
      setState(() {
        _isLoaded = true;
      });
    } catch (e) {
      print('Error fetching product info: $e');
    }
  }

  Future<void> saveProduct() async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      } else {
        Product product = Product(
          widget.productId,
          _nameController.text,
          _descriptionController.text,
          _categoryController.text,
          _brandController.text,
          _stockquantityController.text,
          _priceController.text,
          _dateController.text,
          currentUserId,
        );
        await FireStore.updateEntryWithId(
            'product', widget.productId, product.toMap());
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ViewProductScreen(user: widget._user),
          ),
        );
      }
    } catch (error) {
      print('Error saving product: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: !_isLoaded
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: _formKey,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.all(15.0),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/background.jpg"),
                        fit: BoxFit.cover,
                        opacity: 0.4,
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            key: GlobalKey(),
                            controller: _nameController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return requireFieldValidateMsg;
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: "product_page.name",
                              prefixIcon: Icon(Icons.person),
                            ),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 25),
                          TextFormField(
                            key: GlobalKey(),
                            controller: _descriptionController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return requireFieldValidateMsg;
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: "product_page.description",
                              prefixIcon: Icon(Icons.person),
                            ),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 25),
                          TextFormField(
                            key: GlobalKey(),
                            controller: _categoryController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return requireFieldValidateMsg;
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "product_page.category".tr(),
                              prefixIcon: const Icon(Icons.person),
                            ),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 25),
                          TextFormField(
                            key: GlobalKey(),
                            controller: _brandController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return requireFieldValidateMsg;
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: "product_page.brand",
                              prefixIcon: Icon(Icons.person),
                            ),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 25),
                          TextFormField(
                            key: GlobalKey(),
                            controller: _stockquantityController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return requireFieldValidateMsg;
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: "product_page.stockquantity",
                              prefixIcon: Icon(Icons.person),
                            ),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 25),
                          TextFormField(
                            key: GlobalKey(),
                            controller: _priceController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return requireFieldValidateMsg;
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: "product_page.price",
                              prefixIcon: Icon(Icons.person),
                            ),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 25),
                          TextFormField(
                            key: GlobalKey(),
                            controller: _dateController,
                            focusNode: _dateOfBirthFocusNode,
                            validator: (String? value) {
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "product_page.date",
                              prefixIcon: const Icon(Icons.calendar_today),
                              hintText:
                                  '${dateTime.day}/${dateTime.month}/${dateTime.year}',
                            ),
                            onTap: () async {
                              DateTime? newDate = await showDatePicker(
                                  context: context,
                                  initialDate: dateTime,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now());
                              if (newDate == null) return;
                              setState(() {
                                dateTime = newDate;
                                _dateController.text =
                                    '${dateTime.day}/${dateTime.month}/${dateTime.year}';
                              });
                            },
                            onEditingComplete: () {
                              _dateOfBirthFocusNode.unfocus();
                            },
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 25),
                          Expanded(child: Container()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FloatingActionButton(
                                tooltip: 'save',
                                onPressed: () async {
                                  await saveProduct();
                                },
                                child: const Icon(Icons.save),
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  var navigator = Navigator.of(context);
                                  navigator.pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ViewProductScreen(user: widget._user),
                                    ),
                                  );
                                },
                                tooltip: 'back',
                                child: const Icon(Icons.arrow_back_outlined),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
*/