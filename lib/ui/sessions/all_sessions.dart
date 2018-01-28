import 'package:droidkaigi2018/models/room.dart';
import 'package:droidkaigi2018/repository/repository_factory.dart';
import 'package:droidkaigi2018/ui/sessions/sessions_page.dart';
import 'package:flutter/material.dart';

class AllSessionsPage extends StatefulWidget {
  @override
  State createState() => new AllSessionsPageState();
}

class AllSessionsPageState extends State<AllSessionsPage>
    with TickerProviderStateMixin {
  TabController _controller;
  List<Room> _rooms = [];

  @override
  void initState() {
    super.initState();

    new RepositoryFactory()
        .getRoomRepository()
        .findAll()
        .then((r) => setRooms(r.values.toList()));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void setRooms(List<Room> rooms) {
    setState(() => _rooms = rooms);
  }

  @override
  Widget build(BuildContext context) {
    _controller = new TabController(vsync: this, length: _rooms.length);

    if (_rooms.isEmpty) {
      return new Center(
        child: const CircularProgressIndicator(),
      );
    }

    return new Scaffold(
      appBar: new PreferredSize(
        preferredSize: new Size.fromHeight(kTextTabBarHeight),
        child: new Material(
          color: Theme.of(context).primaryColor,
          elevation: 4.0,
          child: new TabBar(
            controller: _controller,
            isScrollable: true,
            tabs: _rooms.map((Room room) => new Tab(text: room.name)).toList(),
          ),
        ),
      ),
      body: new TabBarView(
        controller: _controller,
        children: _rooms.map((Room room) {
          return new RoomSessionsPage(room.id);
        }).toList(),
      ),
    );
  }
}
