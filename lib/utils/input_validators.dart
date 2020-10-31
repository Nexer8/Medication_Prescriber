String validateName(String value) {
  if (value.isEmpty) {
    return 'Please enter some text.';
  }

  if (value.contains(RegExp(r'^([A-Za-z])+$'))) {
    return null;
  } else {
    return 'Invalid input! A name cannot consist of special characters nor digits.';
  }
}

String validatePersonalId(String value) {
  if (value.isEmpty) {
    return 'Please enter numeric value.';
  }

  if (value.length != 11) {
    return "Personal id length must be 11 digits";
  }

  if (value.contains(RegExp(r'^[0-9]+$'))) {
    return null;
  } else
    return 'Invalid input!';
}

String validateDoctorId(String value) {
  if (value.isEmpty) {
    return 'Please enter numeric value.';
  }

  if (value.contains(RegExp(r'^[0-9]+$'))) {
    return null;
  } else
    return 'Invalid input!';
}

String validateDosage(String value) {
  if (value.isEmpty) {
    return 'Please enter numeric value.';
  }

  if (value.contains(RegExp(r'^[1-9]$'))) {
    return null;
  } else {
    return 'Invalid input! The value has to be between 1 and 9.';
  }
}

String validateMedicationName(String value) {
  if (value.isEmpty) {
    return 'Please enter some text.';
  }
  return null;
}
