import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const secureStorage1 = FlutterSecureStorage(
    aOptions: AndroidOptions(
      preferencesKeyPrefix: 'aPrefix',
      sharedPreferencesName: 'someName',
    ),
  );
  const secureStorage2 = FlutterSecureStorage(
    aOptions: AndroidOptions(
      preferencesKeyPrefix: 'anotherPrefix',
      sharedPreferencesName: 'anotherName',
    ),
  );

  await secureStorage1.write(key: 'testKey', value: 'someValue');

  final value = await secureStorage2.read(key: 'testKey');
  print(
    'The value read from the other secure storage (should be null): $value',
  );
  assert(
      value == null,
      'The value should be null when read from the instance with a different '
      'key prefix.');
  assert(await secureStorage2.containsKey(key: 'testKey') == false,
      'The key should not be found with a different prefix.');

  runApp(const MaterialApp(home: HomePage()));
}

/// Homepage of the example app of flutter_secure_storage
class HomePage extends StatelessWidget {
  /// Creates an instance of `HomePage`.
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: Text('View Console.'),
      ),
    );
  }
}
