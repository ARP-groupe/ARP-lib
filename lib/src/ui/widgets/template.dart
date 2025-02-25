import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:provider/single_child_widget.dart';

final modalController = BehaviorSubject<Widget>()..sink.add(const SizedBox());
class TemplateWidget extends StatefulWidget {
  final Widget child;
  final Widget menu;
  final List<SingleChildWidget>? providers;

  const TemplateWidget({
    super.key,
    this.providers,
    required this.child,
    required this.menu,
  });

  @override
  State<TemplateWidget> createState() => _TemplateWidgetState();
}

class _TemplateWidgetState extends State<TemplateWidget> {
  @override
  void initState() {
    // Controllers
     modalController.sink.add(form);

    // Blocs

    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    if (widget.providers != null) {
      return MultiBlocProvider(
        providers: widget.providers ?? [], 
        child: _body(),
      );
    }

    return _body();
  }

  Widget _body() {
    return Scaffold(
      body: Row(
        children: [
          widget.menu,
          Stack(
            children: [
              Expanded(child: widget.child),

              // Modal
              StreamBuilder(
                stream: modalController,
                builder: (context, snapshot) => snapshot.data ?? const SizedBox(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
