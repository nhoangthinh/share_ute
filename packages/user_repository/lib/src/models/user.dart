import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.id,
    this.email,
    this.name,
    this.birthday,
    this.phone,
    this.photo,
    this.year,
    this.faculty,
    this.major,
    this.hobbies,
  });

  final String id;

  // The current user's email address
  final String email;

  // The current user's name (display name)
  final String name;

  final String birthday;

  final String phone;

  // Url for the current user's photo
  final String photo;

  final String year;

  final String faculty;

  final String major;

  final List<String> hobbies;

  static const empty = User(
    id: '',
    email: '',
    name: '',
    birthday: '',
    phone: '',
    photo: '',
    year: '',
    faculty: '',
    major: '',
    hobbies: [],
  );

  @override
  List<Object> get props => [
        id,
        email,
        name,
        birthday,
        phone,
        photo,
        year,
        faculty,
        major,
        hobbies,
      ];

  User copyWith({
    String id,
    String email,
    String name,
    String birthday,
    String phone,
    String photo,
    String year,
    String faculty,
    String major,
    List<String> hobbies,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
      year: year ?? this.year,
      faculty: faculty ?? this.faculty,
      major: major ?? this.major,
      hobbies: hobbies ?? this.hobbies,
    );
  }
}
