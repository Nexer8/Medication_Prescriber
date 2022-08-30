String validateName(String value) {
  if (value.isEmpty) {
    return 'Please enter some text.';
  }

  if (value.contains(RegExp(r'^([A-Z a-zżźćńółęąśŻŹĆĄŚĘŁÓŃ])+$'))) {
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

  if (value.contains(RegExp(r'^[1-5]$'))) {
    return null;
  } else {
    return 'Invalid input! The value has to be between 1 and 5.';
  }
}

String validateMedicationName(String value) {
  if (value.isEmpty) {
    return 'Please enter some text.';
  }
  return null;
}

String validateDate(String value) {
  if (value.isEmpty) {
    return 'Please select a date.';
  }

  if (!value.contains(RegExp(r'^\d{4}-\d{2}-\d{2}$'))) {
    return 'Invalid date provided!';
  }

  return null;
}
