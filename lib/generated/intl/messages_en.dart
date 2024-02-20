// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "changeNumber": MessageLookupByLibrary.simpleMessage("Change Number ?"),
        "code": MessageLookupByLibrary.simpleMessage("Code"),
        "dontAcc":
            MessageLookupByLibrary.simpleMessage("You Don`t have an account ?"),
        "email": MessageLookupByLibrary.simpleMessage("Enter Your Email"),
        "enterCode":
            MessageLookupByLibrary.simpleMessage("Enter the code received"),
        "error": MessageLookupByLibrary.simpleMessage("error"),
        "errorModalTitle": MessageLookupByLibrary.simpleMessage(
            "There was an error in sending the code. Return to the previous page for re-sending the code."),
        "google": MessageLookupByLibrary.simpleMessage("Google"),
        "labelEmail": MessageLookupByLibrary.simpleMessage("Email"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "loginWith": MessageLookupByLibrary.simpleMessage("Or Login with"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "sendCode": MessageLookupByLibrary.simpleMessage("Send code"),
        "signUp": MessageLookupByLibrary.simpleMessage("SignUp"),
        "successfulAuth":
            MessageLookupByLibrary.simpleMessage("Successful Authorization"),
        "validEmail":
            MessageLookupByLibrary.simpleMessage("Please enter valid email !"),
        "walcomeBack": MessageLookupByLibrary.simpleMessage("Welcome back ,")
      };
}
