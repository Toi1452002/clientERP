class UserViewModel{
  final int id;
  final String username;
  final String? fullName;
  final String? phone;
  final String? email;
  final String? address;

  const UserViewModel({
    required this.id,
    required this.username,
    this.fullName,
    this.phone,
    this.email,
    this.address,
  });

  factory UserViewModel.fromMap(Map<String, dynamic> map) {
    return UserViewModel(
      id: map['id'],
      username: map['username'],
      fullName: map['fullName'],
      phone: map['phone'],
      email: map['email'],
      address: map['address'],
    );
  }

}