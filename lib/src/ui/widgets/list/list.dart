import 'package:arp_lib/src/data/models/v1.0.0/interfaces/arp_interface.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:built_collection/built_collection.dart';

List<int> rowSelected = [0];

class ListWidget extends StatefulWidget {
  final List<String> columns;
  final Stream<BuiltList<ARPInterface>> list;
  final Function onSelect;
  final Function getCells;
  final bool multiselect;

  const ListWidget({
    super.key,
    required this.columns,
    required this.list,
    required this.onSelect,
    required this.getCells,
    this.multiselect = false,
  });

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BuiltList<ARPInterface>>(
      stream: widget.list,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ARPInterface> list = snapshot.data!.toList();

          if (list.isNotEmpty) return _buid(list);

          return _empty();
        } else {
          return const Text('Starting list...');
        }
      },
    );
  }

  Widget _empty() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: const RiveAnimation.asset(
              'assets/img/empty.riv',
              animations: [
                'ManatimeAnimation empty',
              ],
            ),
          ),
          //const SizedBox(height: 5),
          const Text(
            'No results',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buid(List<ARPInterface> list) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 150.0, right: 0.0),
          child: DataTable(
            sortAscending: true,
            showCheckboxColumn: widget.multiselect,
            columns: List.generate(
              widget.columns.length,
              (index) => DataColumn(
                label: Expanded(
                  child: Text(
                    widget.columns[index],
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ),
            rows: List.generate(
              list.length,
              (index) => DataRow(
                onSelectChanged: (value) {
                  setState(() {
                    rowSelected.sort();

                    if (
                        // Si el elemento no esta en la lista
                        widget.multiselect &&
                            !rowSelected.contains(index) &&
                            // Solo permite elementos consecutivos
                            (rowSelected.isEmpty ||
                                index == (rowSelected.first - 1) ||
                                index == (rowSelected.last + 1))) {
                      rowSelected.add(index);
                    } else if (
                        // Si esta activado el modo seleccion
                        widget.multiselect &&
                            // Siel numero esta en la lista
                            rowSelected.contains(index)) {
                      // Si no es un numero intermedio en la lista
                      if (!(rowSelected.contains(index - 1) &&
                          rowSelected.contains(index + 1))) {
                        rowSelected.remove(index);
                      }
                    } else {
                      rowSelected = [index];
                    }

                    widget.onSelect(model: list[index]);
                  });
                },
                selected: rowSelected.contains(index),
                cells: widget.getCells(list[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
