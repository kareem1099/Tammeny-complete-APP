abstract class DatabaseService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  });

  Future<void> updateData({
    required String path,
    required String documentId,
    required Map<String, dynamic> data,
  });

  Future<dynamic> getData({
    required String path,
    String? documentId,
    Map<String, dynamic>? query,
  });

  Stream<dynamic> streamData({
    required String path,
    Map<String, dynamic>? query,
  });

  Future<bool> checkIfDataExists({
    required String path,
    required String documentId,
  });
  Future<void> updateUserAvatar(
      {required String userId, required String imageUrl});
}
