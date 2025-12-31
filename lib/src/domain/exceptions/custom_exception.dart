class RepositoryException implements Exception {
  final String message;
  final dynamic originalError;
  RepositoryException(this.message, [this.originalError]);
  
  @override
  String toString() => 'RepositoryException: $message ($originalError)';
}
