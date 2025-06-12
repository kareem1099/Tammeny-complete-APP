import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as b;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tamenny_app/core/services/storage_service.dart';

class SupabaseStorageService implements StorageService {
  static late Supabase _supabase;

  // recommended create it in dashboard
  static createBucket({required String bucketName}) async {
    var buckets = await _supabase.client.storage.listBuckets();
    bool isBucketExists = false;

    for (var bucket in buckets) {
      if (bucket.id == bucketName) {
        isBucketExists = true;
        break;
      }
    }
    if (!isBucketExists) {
      await _supabase.client.storage.createBucket(bucketName);
    }
  }

  static initSupaBase() async {
    _supabase = await Supabase.initialize(
      url: 'https://hxknihxevezcsgfffdmr.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh4a25paHhldmV6Y3NnZmZmZG1yIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0NTM4NjYxNCwiZXhwIjoyMDYwOTYyNjE0fQ.m7gWx00Uq_iskVERekWGXgrHC10MAoWUaEMLfftFl_Y',
    );
  }

  @override
  Future<String> uploadFile({required XFile file, required String path}) async {
    final uploadfile = File(file.path);
    String fileName = b.basename(file.path);
    String extensionName = b.extension(file.path);
    await _supabase.client.storage
        .from('images')
        .upload('$path/$fileName.$extensionName', uploadfile);
    final String imageUrl = _supabase.client.storage
        .from('images')
        .getPublicUrl('$path/$fileName.$extensionName');
    return imageUrl;
  }
}
