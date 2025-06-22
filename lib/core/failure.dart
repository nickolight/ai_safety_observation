sealed class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

class StorageFailure extends Failure {
  StorageFailure(super.msg);
}

class ServerFailure extends Failure {
  ServerFailure(super.msg);
}
