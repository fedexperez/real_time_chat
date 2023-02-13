import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:real_time_chat/features/chat/presentation/widgets/custom_list_tile.dart';

class CustomListView extends StatefulWidget {
  const CustomListView({super.key});

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      header: WaterDropHeader(
        complete: Icon(Icons.check),
      ),
      // TODO
      // Este on refresh debe ser un bloc que ejecuta un evento, no debe estar directo en este widget
      // Crear un bloc para esté pull on refresh y otro para el usuario de uno
      onRefresh: _cargarUsuarios,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return CustomListTile();
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: 4,
      ),
    );
  }

  _cargarUsuarios() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
