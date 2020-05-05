import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/utils/utils.dart' as utils;

class MapasPage extends StatelessWidget {
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    scansBloc.obtenerScans();
    return StreamBuilder(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final scans = snapshot.data;
        if (scans.length == 0) {
          return Center(
            child: Text('No hay información'),
          );
        }
        return ListView.builder(
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) => scansBloc.borrarScans(scans[i].id),
            background: Container(
              color: Colors.red,
            ),
            child: ListTile(
              onTap: () => utils.abrirScan(scans[i], context),
              leading: Icon(
                Icons.map,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(scans[i].valor),
              subtitle: Text('ID: ${scans[i].tipo}'),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
            ),
          ),
          itemCount: scans.length,
        );
      },
    );
  }
}
