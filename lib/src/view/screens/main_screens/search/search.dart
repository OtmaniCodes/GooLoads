import 'package:flutter/material.dart';
import 'package:gooloads/src/utils/constants/constants.dart';
import 'local_widgets/search_app_bar.dart';
import 'local_widgets/search_products_list.dart';



class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // _scrollController.addListener(() {
    //   if (_scrollController.offset >
    //       _scrollController.position.minScrollExtent) {
    //     print("Hello yoyo");
    //   } else {}
    // });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SearchAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [SearchProductsList(), MEDIUM_VSPACING],
            ),
          ),
        ],
      ),
    );
  }
}
