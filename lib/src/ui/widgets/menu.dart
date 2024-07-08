import 'package:drylog/src/domain/services/drylock_tools.dart';
import 'package:drylog/src/utils/data/sections.dart';
import 'package:flutter/material.dart';

int itemSelected = 0;

class MenuWidget extends StatefulWidget {
  const MenuWidget({
    super.key,
  });

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  late Color selectColor;

  void _onChageScreen(int index, Widget child) {
    setState(() {
      itemSelected = index;
    });

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (BuildContext context, _, __) {
          return child;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    selectColor = Theme.of(context).primaryColor.withOpacity(0.25);

    return _build();
  }

  Widget _build() {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Container(
        height: double.infinity,
        width: 300,
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _head(),
              const SizedBox(height: 75),
              _section(),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _head() {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset(
              'assets/img/icon_Drylock.png',
              height: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Segovia',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DrylockTools.getUserName().toUpperCase(),
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _section() {
    return Column(
      children: List.generate(
        sections.length,
        (index) => ExpansionTile(
          initiallyExpanded: true,
          title: Text(sections.keys.toList()[index]),
          children: List.generate(
            sections[sections.keys.toList()[index]]!.length,
            (index1) {
              return Visibility(
                visible:
                    sections[sections.keys.toList()[index]]![index1].visible,
                child: ListTile(
                  onTap: () => _onChageScreen(index + index1,
                      sections[sections.keys.toList()[index]]![index1].child),
                  tileColor: itemSelected == index + index1
                      ? selectColor
                      : Colors.transparent,
                  leading: Icon(
                      sections[sections.keys.toList()[index]]![index1].icon),
                  title: Text(
                      sections[sections.keys.toList()[index]]![index1].name),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
