import 'package:arp_lib/src/data/models/v1.0.0/interfaces/arp_interface.dart';

abstract class RepositoryInterface<model>{
  Future<String?> create({required String table, required ARPInterface  data});
  Future<bool> update({required String table, required String id, required ARPInterface  data});
  Future<ARPInterface ?> read({required String table, required String id});
  Future<List<ARPInterface >> readList({String columns, required String table, ARPFilterInterface ? filter});
  Future<bool> delete({required String table, required String id});
}