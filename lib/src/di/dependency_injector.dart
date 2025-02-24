import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:provider/provider.dart';

abstract class DependencyInjector {
  // Consturctor
  DependencyInjector() {
    _initRepositorys();
    _intiProviders();
    _initFunctions();
    _initBlocs();
  }

  // initRepositorys
  void initState();

  // _initRepositorys
  void _initRepositorys();

  // _intiProviders
  void _intiProviders();

  // _initFunctions
  void _initFunctions();

  // _initBlocs
  void _initBlocs();

  // getRepositoryProviderList
  List<RepositoryProvider> getRepositoryProviderList();

  // getProviderList
  List<ChangeNotifierProvider> getProviderList();

  // getBlocProviderList
  List<BlocProvider> getBlocProviderList();
}
