import 'package:flutter/material.dart';

// internal packages
import 'package:gear_ui/src/features/products/data/product_repository.dart';
import 'package:gear_ui/src/features/products/domain/product.dart';
import 'package:gear_ui/src/layouts/children_page_layout.dart';
import 'package:gear_ui/src/utils/debounce.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // static const _productRepository = ProductRepository();
  final _searchInputController = TextEditingController();
  bool _inputHasContent = false;
  final _SearchResult _searchResult = _SearchResult();
  late final Debounce<String>? _debounce;

  @override
  void initState() {
    _debounce = Debounce<String>(
      onChange: () {
        // _productRepository.findByName(_searchInputController.text).then(
        //   (products) {
        //     setState(() {
        //       _searchResult.products = products;
        //     });
        //   },
        // );
      },
    );

    _searchInputController.addListener(_debounce!);

    super.initState();
  }

  @override
  void dispose() {
    _searchInputController.removeListener(_debounce!);
    _searchInputController.dispose();
    _debounce.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChildrenPageLayout(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 15.0,
              ),
              child: TextField(
                controller: _searchInputController,
                onChanged: (String value) {
                  setState(() {
                    _inputHasContent = value.isNotEmpty;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search",
                  suffixIcon: _inputHasContent
                      ? IconButton(
                          icon: const Icon(
                            Icons.clear_rounded,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_inputHasContent) {
                                _searchInputController.text = "";
                                _inputHasContent = false;
                              }
                            });
                          },
                        )
                      : const Icon(
                          Icons.search,
                        ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  const Text(
                    "Products",
                  ),
                  ..._searchResult.products.map((product) {
                    return ListTile(
                      title: Text(
                        product.name,
                      ),
                    );
                  }),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: const [
                  Text(
                    "Brands",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchResult {
  _SearchResult();

  List<Product> products = <Product>[];
}
