import 'package:product_manager/Controller/res/custom_colors.dart';
import 'package:product_manager/Controller/utils/authentication.dart';
import 'package:product_manager/Controller/utils/firestore.dart';
import 'package:product_manager/Model/models/product.dart';
import 'add_product_screen.dart';
import 'sign_in_screen.dart';
import 'update_product_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewProductScreen extends StatefulWidget {
  final User _user;

  const ViewProductScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  @override
  State<ViewProductScreen> createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {
  List<PlutoColumn> columns = [];
  List<PlutoRow> rows = [];
  late PlutoGridStateManager stateManager;

  bool _isLoaded = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    columns = [
      PlutoColumn(
        title: 'urun adi',
        field: 'name',
        type: PlutoColumnType.text(),
        enableRowChecked: false,
        enableRowDrag: false,
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
      ),
      PlutoColumn(
        title: 'urun aciklamasi',
        field: 'description',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.start,
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
      ),
      PlutoColumn(
        title: 'category',
        field: 'category',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.start,
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
      ),
      PlutoColumn(
        title: 'brand',
        field: 'brand',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.start,
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
      ),
      PlutoColumn(
        title: 'stockquantity',
        field: 'stockquantity',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.start,
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
      ),
      PlutoColumn(
        title: 'price',
        field: 'price',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.start,
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
      ),
      PlutoColumn(
        title: 'date',
        field: 'date',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.start,
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
      ),
      PlutoColumn(
        title: 'guncelle',
        field: 'id_update',
        type: PlutoColumnType.text(),
        enableFilterMenuItem: false,
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        width: 75,
        minWidth: 75,
        renderer: (rendererContext) {
          return IconButton(
            icon: const Icon(
              Icons.edit,
            ),
            onPressed: () {
              var navigator = Navigator.of(context);
              navigator.pushReplacement(
                MaterialPageRoute(
                  builder: (context) => UpdateProductScreen(
                    productId:
                        rendererContext.row.cells.entries.last.value.value,
                    user: widget._user,
                  ),
                ),
              );
            },
            iconSize: 18,
            color: Colors.green,
            padding: const EdgeInsets.all(0),
          );
        },
      ),
      PlutoColumn(
        title: 'silmek ',
        field: 'id_delete',
        type: PlutoColumnType.text(),
        enableFilterMenuItem: false,
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        width: 75,
        minWidth: 75,
        renderer: (rendererContext) {
          return IconButton(
            icon: const Icon(
              Icons.delete,
            ),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title:
                        const Text('product_page.delete_product_dialog_title'),
                    content: const Text('product_page.delete_product_msg'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('geri'),
                        onPressed: () {
                          Navigator.of(context)
                              .pop(); // Dismiss the dialog when the 'Cancel' button is pressed
                        },
                      ),
                      TextButton(
                        child: Text('general.ok'.tr()),
                        onPressed: () async {
                          var navigator = Navigator.of(context);
                          await FireStore.deleteEntry(
                              'product',
                              rendererContext
                                  .row.cells.entries.last.value.value);
                          rendererContext.stateManager
                              .removeRows([rendererContext.row]);
                          navigator.pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            iconSize: 18,
            color: Colors.red,
            padding: const EdgeInsets.all(0),
          );
        },
      ),
    ];
    fetchRows();
  }

  Future<List<Product>> getData(String idUser) async {
    List<Product> result = [];
    try {
      result = await FireStore.getAllEntriesSortedByName('product', idUser);
    } catch (error) {
      // executed for errors of all types other than Exception
      print(error);
      // showErrorAlert(context, error);
    }
    // print(result);
    return result;
  }

  Future<List<PlutoRow>> fetchRows() async {
    final List<PlutoRow> _rows = [];
    _prefs.then((SharedPreferences prefs) async {
      String userId = prefs.getString('uid') ?? '';
      await getData(userId).then((data) {
        for (var item in data) {
          Map<String, PlutoCell> cells = {};
          cells['name'] = PlutoCell(value: item.name);
          cells['description'] = PlutoCell(value: item.description);
          cells['category'] = PlutoCell(value: item.Category);
          cells['brand'] = PlutoCell(value: item.brand);
          cells['stockquantity'] = PlutoCell(value: item.stockquantity);
          cells['price'] = PlutoCell(value: item.price);
          cells['date'] = PlutoCell(value: item.date);
          cells['id_update'] = PlutoCell(value: item.id);
          cells['id_delete'] = PlutoCell(value: item.id);

          _rows.add(PlutoRow(cells: cells));
        }
      });
      setState(() {
        rows = _rows;
        _isLoaded = true;
      });
    });
    return _rows;
  }

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 300,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  children: [
                    Text(
                      widget._user.displayName!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    widget._user.photoURL != null
                        ? ClipOval(
                            child: Material(
                              color: CustomColors.firebaseGrey.withOpacity(0.3),
                              child: Image.network(
                                widget._user.photoURL!,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          )
                        : ClipOval(
                            child: Material(
                              color: CustomColors.firebaseGrey.withOpacity(0.3),
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(
                                  Icons.person,
                                  size: 60,
                                  color: CustomColors.firebaseGrey,
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('oturumu sonlandir'),
              onTap: () async {
                final navigator = Navigator.of(context);
                await Authentication.signOut(context: context);
                navigator.pushReplacement(_routeToSignInScreen());
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('urun listesi'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var navigator = Navigator.of(context);
          navigator.pushReplacement(
            MaterialPageRoute(
              builder: (context) => AddProductScreen(
                user: widget._user,
              ),
            ),
          );
        },
        tooltip: 'add_product',
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: !_isLoaded
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : PlutoGrid(
                columns: columns,
                rows: rows,
                onChanged: (PlutoGridOnChangedEvent event) {
                  print(event);
                },
                onLoaded: (PlutoGridOnLoadedEvent event) {
                  stateManager = event.stateManager;
                  stateManager.setSelectingMode(PlutoGridSelectingMode.cell);
                  stateManager.setShowColumnFilter(true);
                },
                createFooter: (stateManager) {
                  stateManager.setPageSize(20, notify: false); // default 40
                  return PlutoPagination(stateManager);
                },
                rowColorCallback: (rowColorContext) {
                  int rowIndex = rowColorContext.rowIdx;

                  if (rowIndex % 2 == 0) {
                   // Colors.blue.shade100;
                    return Colors.green.shade400;
                  } else {
                    return Colors.blue;
                  }
                },
                configuration: const PlutoGridConfiguration(
                  columnSize: PlutoGridColumnSizeConfig(
                    autoSizeMode: PlutoAutoSizeMode.scale,
                    resizeMode: PlutoResizeMode.normal,
                  ),
                  localeText: PlutoGridLocaleText(
                    filterContains: 'ara',
                  ),
                ),
              ),
      ),
    );
  }
}
