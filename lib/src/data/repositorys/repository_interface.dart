import 'package:arp_lib/src/data/models/v1.0.0/interfaces/arp_interface.dart';
import 'package:postgres/postgres.dart';

abstract class RepositoryInterface<model> {
  Future<String?> create({
    required String table,
    required ARPInterface data,
  });

  Future<bool> update({
    required String table,
    required String id,
    required ARPInterface data,
  });

  Future<ARPInterface?> read({
    required String table,
    required String idTag,
    required String id,
    String? filter, 
  });

  Future<List<ARPInterface>> readList({
    String columns,
    required String table,
    ARPFilterInterface? filter,
    int limit,
    String? query, 
  });

  Future<bool> delete({
    required String table,
    required String id,
  });

  Future<Result?> setCommand({
    String? database,
    required String query,
  });

  void subscribe({
    required String table, 
    required BehaviorSubject controller,
    ARPFilterInterface? filter,
    Function? onChange, 
  });
}
