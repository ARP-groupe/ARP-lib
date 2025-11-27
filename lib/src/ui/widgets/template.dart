import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rive/rive.dart' as rive;

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
    modalController.sink.add(const SizedBox());

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
          Expanded(
            child: Stack(
              children: [
                widget.child,

                // Modal
                StreamBuilder(
                  stream: modalController,
                  builder: (context, snapshot) =>
                      snapshot.data ?? const SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

  Widget errorTemplate(BuildContext context, Stream<Map<double, String>> feedback) {
    return StreamBuilder(
      stream: feedback,
      builder: (context, snapshot) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          width: 493,
          child: Column(
            children: [
              const SizedBox(height: 200),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: const rive.RiveAnimation.asset(
                  'assets/img/error.riv',
                  animations: [
                    'Timeline 1',
                  ],
                ),
              ),
              const Text(
                'Something went wrong!',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                snapshot.hasData ? snapshot.data![0] ?? '' : '',
              ),
            ],
          ),
        );
      },
    );
  }


  Widget loadingTemplate(BuildContext context, title) {
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          backgroundColor: Colors.transparent,
          leading: const SizedBox(),
          largeTitle: Text(
            title, //'${AppLocalizations.of(context)!.stop}s',
            style: TextStyle(
              color: Theme.of(context).textTheme.titleLarge!.color,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: Column(children: [])),
        const SliverFillRemaining(
          child: Column(
            children: [
              LinearProgressIndicator(),
              SizedBox(height: 450),
              Text('Loading...'),
            ],
          ),
        ),
      ],
    );
  }
