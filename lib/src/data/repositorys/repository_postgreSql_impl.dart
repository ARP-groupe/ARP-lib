



import 'dart:developer';

import 'package:arp_lib/src/app.dart';
import 'package:arp_lib/src/data/models/v1.0.0/interfaces/arp_interface.dart';
import 'package:arp_lib/src/data/repositorys/repository_interface.dart';
import 'package:arp_lib/src/utils/functions/repository_functions.dart';
import 'package:postgres/postgres.dart';

class RepositoryPostgreSQLImpl implements RepositoryInterface {
  Connection? _connection;

  RepositoryPostgreSQLImpl() {
    connect();
  }

  Future<bool> connect({String? database}) async {
    try {
      await _connection?.close();
      _connection = null;

      while (_connection == null || !_connection!.isOpen) {
        _connection ??= await Connection.open(
          Endpoint(
            // SEGOSQL02
            // host: '10.9.3.63',
            // database: 'testdb',
            // username: 'arturo',
            // password: 'Drylock18!',

            // SEGOSQL03
            host: '10.9.3.67',
            database: database ?? 'SEGO_DryLog',
            username: 'dryloguser',
            password: 'Drylock18!',
          ),
          // The postgres server hosted locally doesn't have SSL by default. If you're
          // accessing a postgres server over the Internet, the server should support
          // SSL and you should swap out the mode with `SslMode.verifyFull`.
          settings: const ConnectionSettings(sslMode: SslMode.disable),
        );

        logger.info('Connection established!');

        return true;
      }
    } catch (e) {
      logger.severe('Connection failed: $e');
    }

    _connection?.close();
    _connection = null;
    return false;
  }

  @override
  Future<String?> create({
    required String table,
    required ARPInterface data,
  }) async {
    try {
      await connect();

      String query = "INSERT INTO $table ${data.toSql()}";
      log(query);

      Result? result = await _connection?.execute(query);

      String? id = (result![0][0] != null ? result[0][0].toString() : null);

      await _connection?.close();

      return id;
    } catch (e) {
      logger.severe('Create failed: $e');
    }

    await _connection?.close();
    return null;
  }

  @override
  Future<bool> delete({
    required String table,
    required String id,
    required String tagId,
  }) async {
    try {
      await connect();

      String query = "DELETE FROM $table WHERE $tagId = '$id';";

      log(query);
      await _connection?.execute(query);

      await _connection?.close();

      return true;
    } catch (e) {
      logger.severe('Delete failed: $e');
    }

    await _connection?.close();
    return false;
  }

  @override
  Future<ARPInterface?> read({
    required String table,
    required String idTag,
    required String id,
    String? filter,
  }) async {
    try {
      await connect();

      String query = filter != null
          ? 'SELECT * FROM $table WHERE $filter LIMIT 1'
          : "SELECT * FROM $table WHERE $idTag = '$id' LIMIT 1";

      log(query);
      final result = await _connection?.execute(query);

      if (result != null && result.isNotEmpty) {
        ARPInterface? model = repositoryFunctions.fromSql(table, result.first);

        await _connection?.close();
        return model;
      }
    } catch (e) {
      logger.severe('Read failed: $e');
    }

    await _connection?.close();
    return null;
  }

  @override
  Future<List<ARPInterface>> readList({
    String columns = '*',
    required String table,
    ARPFilterInterface? filter,
    int limit = 1000,
    String? query,
  }) async {
    List<ARPInterface> list = [];

    try {
      await connect();

      String finalQuery = query ??
          "SELECT $columns FROM $table ${filter != null ? filter.toSql() : ''} LIMIT $limit";

      // simple query
      log(finalQuery);
      final result0 = await _connection?.execute(finalQuery);

      for (ResultRow element in result0!) {
        ARPInterface? model = repositoryFunctions.fromSql(table, element);

        if (model != null) {
          list.add(model);
        }
      }

      await _connection?.close();
      return list;
    } catch (e) {
      logger.severe('ReadList failed: $e');
    }

    await _connection?.close();
    return list;
  }

  @override
  Future<bool> update({
    required String table,
    required String id,
    required ARPInterface data,
  }) async {
    try {
      await connect();

      String query = "UPDATE $table ${data.setSql()}";
      log(query);

      await _connection?.execute(query);

      await _connection?.close();
      return true;
    } catch (e) {
      logger.severe('Update failed: $e');
    }

    await _connection?.close();
    return false;
  }

  @override
  void subscribe({
    required String table,
    required controller,
    ARPFilterInterface? filter,
    Function? onChange,
  }) {
    // Not implemented
  }

  @override
  Future<Result?> setCommand({
    String? database,
    required String query,
  }) async {
    try {
      await connect(database: database);

      logger.info(query);
      final result = await _connection?.execute(query);

      await _connection?.close();
      return result;
    } catch (e) {
      logger.severe('ReadList failed: $e');
    }

    await _connection?.close();
    return null;
  }
}
