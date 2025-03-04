import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mile_locally/constant/app_constant.dart';
import 'package:mile_locally/firebase/firebase_auth.dart';
import 'package:mile_locally/google/google_service.dart';
import 'package:mile_locally/model/current_user.dart';
import 'package:mile_locally/model/gridData.dart';
import 'package:mile_locally/model/product.dart';
import 'package:mile_locally/screen/login_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseService _service = FirebaseService();
  User? _user;
  CurrentUserData? currentUserData;
  String? gName, email, imageUrl;
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  final TextEditingController _searchController = TextEditingController();
  final GoogleService _googleService = GoogleService();

  List<HomeGridData> gridList = [
    HomeGridData(title: 'Car', imagePath: 'assets/images/car.png', color: Colors.blue),
    HomeGridData(title: 'Electronics', imagePath: 'assets/images/electronics.png', color: Colors.brown),
    HomeGridData(title: 'Household', imagePath: 'assets/images/home.png', color: Colors.green.shade900),
    HomeGridData(title: 'Clothing', imagePath: 'assets/images/cloth.png', color: Colors.blue.shade900),
    HomeGridData(title: 'Shoes', imagePath: 'assets/images/shoes.png', color: Colors.purple),
    HomeGridData(title: 'Furniture', imagePath: 'assets/images/furniture.png', color: Colors.red.shade900),
    HomeGridData(title: 'Jewelry', imagePath: 'assets/images/jewelry.png', color: Colors.deepPurple),
    HomeGridData(title: 'Cell Phones', imagePath: 'assets/images/phone.png', color: Colors.blueGrey.shade800),
  ];

  @override
  void initState() {
    super.initState();
    _user = _service.currentUser;
    if (_user != null) {
      gName = _user!.displayName;
      email = _user!.email;
      imageUrl = _user!.photoURL;
      _loadProduct();
    }
  }

  Future<void> _loadProduct() async {
    try {
      List<Product> products = await _service.loadProduct(email: email!);
      setState(() {
        _products = products;
        _filteredProducts = products;
      });
    } catch (e) {
      // Handle the error appropriately
      print('Error loading products: $e');
    }
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _products.where((product) {
        return product.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                automaticallyImplyLeading: false,
                expandedHeight: 65,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => _scaffoldKey.currentState?.openDrawer(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 5,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: Offset(2, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) => _onSearchChanged(),
                          style: const TextStyle(color: Colors.black, fontSize: 16),
                          decoration: const InputDecoration(
                            labelText: 'Search',
                            labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                            prefixIcon: Icon(Icons.location_on_rounded, size: 18),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context,
                                AppConstant.catagoryViseProduct,
                                arguments: gridList[index]
                            );
                          },
                          child: Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              color: gridList[index].color,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  gridList[index].imagePath,
                                  color: Colors.grey.shade200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Expanded(
                          child: Center(
                            child: Text(
                              gridList[index].title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  childCount: gridList.length,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Divider(thickness: 2, color: Colors.black38),
                ),
              ),
              SliverStaggeredGrid.countBuilder(
                crossAxisCount: 3,
                itemCount: _filteredProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  Product product = _filteredProducts[index];

                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context,
                            AppConstant.buyView,
                            arguments: product
                        );
                        print(product.name);
                      },
                      child: Container(
                        child: CachedNetworkImage(
                          imageUrl: product.imageUrl,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: FutureBuilder(
          future: _googleService.getUserInfo(),
          builder: (context, AsyncSnapshot<GoogleSignInAccount?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              var account = snapshot.data;
              return ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey.shade300,
                          foregroundImage: NetworkImage(account!.photoUrl!),
                        ),
                        SizedBox(height: 16),
                        Text(account.displayName!,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 22)),
                        Text(account.email!,
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.brown.shade200,
                    ),
                  ),
                  ListTile(
                    title: Text('Sell Product'),
                    onTap: () {
                      Navigator.pushNamed(context, AppConstant.productListView);
                    },
                  ),
                  ListTile(
                    title: Text('Sold Product'),
                    onTap: () {
                      Navigator.pushNamed(context, AppConstant.soldProductListView);
                    },
                  ),
                  ListTile(
                    title: Text('Logout', style: TextStyle(color: Colors.black)),
                    onTap: () {
                      showAlertDialog(context);
                    },
                  ),
                ],
              );
            } else {
              return Center(child: Text('Error loading user data'));
            }
          },
        ),
      ),
    );
  }

  Future<void> showAlertDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert'),
        content: Text('Are you sure you want to Logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              _googleService.logout().then((value) {
                if (value) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginView(),
                    ),
                        (route) => false,
                  );
                }
              });
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
}
