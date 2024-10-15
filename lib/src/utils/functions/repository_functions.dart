import 'package:arp_lib/src/data/models/v1.0.0/interfaces/arp_interface.dart';
import 'package:postgres/postgres.dart';

late RepositoryFunctionsInterface repositoryFunctions;

abstract class RepositoryFunctionsInterface {
  //
  ARPInterface ? fromSql(String table, ResultRow element);
}
