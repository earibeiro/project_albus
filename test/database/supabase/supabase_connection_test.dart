import 'package:flutter_test/flutter_test.dart';
import 'package:albus/app/database/supabase/supabase_connection.dart';
import 'package:supabase/supabase.dart';

void main() {
  late SupabaseClient client;

  test('Test Supabase connection', () async {
    try {
      await SupabaseConnection.testConnection();
    } catch (e) {
      print('Connection test failed: $e');
    }
  });

  setUpAll(() async {
    await SupabaseConnection.open();
    client = SupabaseConnection.client;

    try {
      await client.rpc('set_config', params: {'key': 'row_security', 'value': 'off'}).execute();

      var result = await client.from('teacher').select().execute();
      if (result.data == null || result.data.isEmpty) {

        await client.from('teacher').insert([
          {'name': 'Professor Alpha', 'email': 'professorAlpha@example.com'},
          {'name': 'Professor Beta', 'email': 'professorBeta@example.com'},
          {'name': 'Professor Delta', 'email': 'professorDelta@example.com'},
        ]).execute();
      }
    } catch (e) {
      print('Error during setup: $e');
    } finally {
      await client.rpc('set_config', params: {'key': 'row_security', 'value': 'on'}).execute();
    }
  });

  group('Testes de conexão', () {
    test('teste script create table', () async {
      var list = await client.from('teacher').select().execute();
      expect(list.data, isNotNull);
      expect(list.data.length, 3);
    });

    test('teste de inserção', () async {
      await client.from('teacher').insert({
        'id': 4,
        'name': 'Professor Zeta',
        'email': 'professorZeta@example.com',
      }).execute();

      var list = await client.from('teacher').select().execute();
      expect(list.data, isNotNull);
      expect(list.data.length, 4);
    });

    test('teste de atualização', () async {
      await client.from('teacher').update({
        'name': 'Professor Atualizado',
      }).eq('id', 4).execute();

      var list = await client.from('teacher').select().execute();
      expect(list.data, isNotNull);
      expect(list.data.length, 4);
      expect(list.data.firstWhere((teacher) => teacher['id'] == 4)['name'], 'Professor Atualizado');
    });

    test('teste de exclusão', () async {
      await client.from('teacher').delete().eq('id', 4).execute();

      var list = await client.from('teacher').select().execute();
      expect(list.data, isNotNull);
      expect(list.data.length, 3);
    });
  });
}