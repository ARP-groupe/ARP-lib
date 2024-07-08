import 'package:arp_lib/src/ui/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:provider/single_child_widget.dart';

class TemplateWidget extends StatefulWidget {
  final Widget child;
  final List<SingleChildWidget>? providers;

  const TemplateWidget({
    super.key,
    this.providers,
    required this.child,
  });

  @override
  State<TemplateWidget> createState() => _TemplateWidgetState();
}

class _TemplateWidgetState extends State<TemplateWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.providers != null) {
      return MultiBlocProvider(
          providers: widget.providers ?? [], child: _body());
    }

    return _body();
  }

  Widget _body() {
    return Scaffold(
      body: Row(
        children: [
          const MenuWidget(),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}
