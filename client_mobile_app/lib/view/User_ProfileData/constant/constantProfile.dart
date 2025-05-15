
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

String? selectedGender;

DateTime? selectedDateBirth;
String? fullName;

XFile? imageProvider;

String TypeErrorName = '';


//   TextFormFlied

final formKey = GlobalKey<FormState>();

// Text editing controllers for capturing user input
final fullNameController = TextEditingController();
final dateOfBirthController = TextEditingController();
final genderController = TextEditingController();

bool isDarkModeEnabled(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.dark;
}
