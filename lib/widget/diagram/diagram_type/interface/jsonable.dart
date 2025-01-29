abstract interface class Jsonable {
  Map<String, dynamic> toJson();
  factory Jsonable.fromJson(Map<String, dynamic> map) {
    throw UnimplementedError();
  }
}
