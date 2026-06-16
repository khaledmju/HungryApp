import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/home/data/home_repo.dart';
import 'package:hungry/features/home/data/product_model.dart';
import 'package:hungry/features/home/widgets/card_item.dart';
import 'package:hungry/features/home/widgets/food_category.dart';
import 'package:hungry/features/home/widgets/search_field.dart';
import 'package:hungry/features/home/widgets/user_header.dart';
import 'package:hungry/features/product/views/product_details_view.dart';
import 'package:hungry/shared/custom_snackBar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List category = ["All", "Combos", "Sliders", "Classic"];
  int selectedIndex = 0;

  HomeRepo homeRepo = HomeRepo();

  List<ProductModel> productList = [];

  bool isLoading = true;

  Future<void> getProducts() async {
    try {
      final products = await homeRepo.getProduct();

      setState(() {
        productList = products;
        isLoading = false;
      });
    } catch (e) {
      String msg = "Error in Home View";
      print(e);
      if (e is ApiError) {
        msg = e.message;
      }
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(msg));
    }
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Skeletonizer(
        enabled: isLoading,
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              const SliverAppBar(
                backgroundColor: Colors.white,
                pinned: true,
                elevation: 0,
                scrolledUnderElevation: 0,
                // height of app bar
                toolbarHeight: 160,
                automaticallyImplyLeading: false,
                flexibleSpace: Padding(
                  padding: EdgeInsets.only(top: 45, right: 20, left: 20),
                  child: Column(
                    children: [UserHeader(), Gap(20), SearchField()],
                  ),
                ),
              ),

              /// category
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // Gap(70),
                      // UserHeader(),
                      // Gap(20),
                      // SearchField(),
                      const Gap(20),
                      FoodCategory(
                        category: category,
                        selectedIndex: selectedIndex,
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
              ),

              /// grid view
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    childCount: isLoading ? 6 : productList.length,
                    (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ProductDetailsView(),
                          ),
                        );
                      },
                      child: CardItem(
                        productModel: isLoading
                            ? ProductModel.dummy()
                            : productList[index],
                      ),
                    ),
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.5,
                    crossAxisSpacing: 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
