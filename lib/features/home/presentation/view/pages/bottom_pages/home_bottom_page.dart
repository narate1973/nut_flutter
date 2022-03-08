import 'package:flutter/material.dart';
import '../tab_bar_pages/conserve_page.dart';
import '../tab_bar_pages/my_work_page.dart';

class HomeBottomPage extends StatefulWidget {
  const HomeBottomPage._({Key? key}) : super(key: key);

  static Widget create() => const HomeBottomPage._();

  @override
  State<HomeBottomPage> createState() => _HomeBottomPageState();
}

class _HomeBottomPageState extends State<HomeBottomPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48,
          child: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: ThemeData.light().primaryColor,
            indicatorPadding: const EdgeInsets.only(top: 20),
            labelStyle: const TextStyle(color: Colors.grey),
            unselectedLabelStyle: const TextStyle(color: Colors.white),
            controller: _tabController,
            tabs: const [
              Tab(text: 'งานของฉัน'),
              Tab(text: 'จองงาน'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              MyWorkPage.create(),
              ConservePage.create(),
            ],
          ),
        ),
      ],
    );
  }
}
