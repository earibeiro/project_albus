import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConnection {
  static late SupabaseClient _client;
  static bool _isConnectionCreated = false;

  static Future<SupabaseClient> open() async {
    if (!_isConnectionCreated) {
      _client = SupabaseClient(
        'https://wnkawcbqwerdbnztmbqq.supabase.co',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indua2F3Y2Jxd2VyZGJuenRtYnFxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjc2NTEyOTcsImV4cCI6MjA0MzIyNzI5N30.bUDD-ImOLNvQCkBL7Zc3v3LRGossiSh4e5mDdoqsl48',
      );
      _isConnectionCreated = true;
    }
    return _client;
  }

  static Future<void> insertData(String table, Map<String, dynamic> data) async {
    final client = await open();
    final response = await client.from(table).insert(data).execute();
    if (response.error != null) {
      throw Exception('Failed to insert data: ${response.error!.message}');
    }
  }

  static Future<List<dynamic>> getData(String table) async {
    final client = await open();
    final response = await client.from(table).select().execute();
    if (response.error != null) {
      throw Exception('Failed to retrieve data: ${response.error!.message}');
    }
    return response.data;
  }
}
