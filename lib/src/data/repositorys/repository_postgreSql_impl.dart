part of 'repository_interface.dart';

class RepositoryPostgreSQLImpl implements RepositoryInterface {
  Connection? _connection;

  RepositoryPostgreSQLImpl() {
    connect();
  }

  Future<bool> connect({String database = 'SEGO_drylogDB'}) async {
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
            database: database,
            username: 'dryloguser',
            password: 'Drylock18!',
          ),
          // The postgres server hosted locally doesn't have SSL by default. If you're
          // accessing a postgres server over the Internet, the server should support
          // SSL and you should swap out the mode with `SslMode.verifyFull`.
          settings: const ConnectionSettings(sslMode: SslMode.disable),
        );

        print('Connection established!');

        return true;
      }
    } catch (e) {
      print('Connection failed: $e');
    }

    _connection?.close();
    _connection = null;
    return false;
  }

  @override
  Future<bool> create(
      {required String table, required ARPInterface data}) async {
    try {
      await connect();

      await _connection?.execute("INSERT INTO $table ${data.toSql()}");

      await _connection?.close();
      return true;
    } catch (e) {
      print('Create failed: $e');
    }

    await _connection?.close();
    return false;
  }

  @override
  Future<bool> delete({required String table, required String id}) async {
    try {
      await connect();

      await _connection?.execute("DELETE FROM $table WHERE stop_id = '$id';");

      await _connection?.close();

      return true;
    } catch (e) {
      print('Delete failed: $e');
    }

    await _connection?.close();
    return false;
  }

  @override
  Future<ARPInterface?> read({required String id}) async {
    try {
      await connect();

      // final result = await _connection?.query("SELECT * FROM table_name WHERE id = @id", substitutionValues: {
      //   'id': id,
      // });
      // if (result != null && result.isNotEmpty) {
      //   return visionFromSql(result.first); // Adjust conversion as necessary
      // } else {

      await _connection?.close();

      return null;
      // }
    } catch (e) {
      print('Read failed: $e');
    }

    await _connection?.close();
    return null;
  }

  @override
  Future<List<ARPInterface>> readList({
    String columns = '*',
    required String table,
    ARPFilterInterface? filter,
  }) async {
    List<ARPInterface> list = [];

    try {
      await connect();

      // simple query
      final result0 = await _connection?.execute(
          "SELECT $columns FROM $table ${filter != null ? filter.toSql() : ''} LIMIT 500");

      for (var element in result0!) {
        ARPInterface? model;

        if (table == tableStops) {
          model = stopFromSql(element);
        } else if (table == tableVision) {
          model = visionFromSql(element);
        }

        if (model != null) {
          list.add(model);
        }
      }

      await _connection?.close();
      return list;
    } catch (e) {
      print('ReadList failed: $e');
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

      print("UPDATE $table ${data.setSql()}");
      await _connection?.execute("UPDATE $table ${data.setSql()}");

      await _connection?.close();
      return true;
    } catch (e) {
      print('Update failed: $e');
    }

    await _connection?.close();
    return false;
  }

  Future<Result?> setCommand({
    String? database,
    required String command,
  }) async {
    try {
      database != null ? await connect(database: database) : await connect();

      final result = await _connection?.execute(command);

      await _connection?.close();
      return result;
    } catch (e) {
      print('ReadList failed: $e');
    }

    await _connection?.close();
    return null;
  }
}
