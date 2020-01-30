import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gbridgeapp/models/device.dart';
import 'package:gbridgeapp/models/device_list_model.dart';
import 'package:provider/provider.dart';

import 'base_loading_screen.dart';
import 'device_icon.dart';
import 'device_status_screen.dart';

class DeviceListScreen extends StatefulWidget {
  @override
  _DeviceListScreen createState() => _DeviceListScreen();
}

class _DeviceListScreen extends BaseLoadingScreen<DeviceListScreen, DeviceListModel> {
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  @override
  String getTitle(DeviceListModel model) {
    return 'Devices';
  }

  @override
  void load() {
    Provider.of<DeviceListModel>(this.context, listen: false).fetchDevices();
  }

  @override
  Widget render(DeviceListModel model) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: model.data?.length ?? 0,
      itemBuilder: (BuildContext _context, int i) {
        return _buildRow(model.data[i]);
      },
    );
  }

  Widget _buildRow(Device device) {
    return Card(
        child: InkWell(
      onTap: () => this.onTap(device),
      child: ListTile(
        leading: DeviceIcon(device.type),
        title: Text(device.name, style: _biggerFont),
        subtitle: device.type != null ? Text(describeEnum(device.type)) : null,
      ),
    ));
  }

  onTap(Device device) {
    return Navigator.push(
        context, new MaterialPageRoute(builder: (ctx) => DeviceStatusScreen(device)));
  }

}