class Account {
  String id;
  String userName;
  String email;
  DateTime? createdTime;
  DateTime? updatedTime;

  Account({
    this.id = '',
    this.userName = '',
    this.email = '',
    this.createdTime,
    this.updatedTime,
  });
}
