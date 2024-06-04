
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:product_manager/main.dart';

void main() {
 // setUpAll(() async {
  //  await initializeMockFirebase();
 // });

  testWidgets('Google ile Giriş butonuna tıklama', (WidgetTester tester) async {
  print('Test başlıyor');

  await tester.pumpWidget(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'AR')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar', 'AR'),
      startLocale: const Locale('ar', 'AR'),
      useOnlyLangCode: true,
      saveLocale: true,
      child: const MyApp(),
    ),
  );

  print('Widget yüklendi');

  await tester.pumpAndSettle();

  print('hosgeldiniz metni kontrol ediliyor');
  expect(find.text('hosgeldiniz'), findsOneWidget);
  
  print('google ile giris metni kontrol ediliyor');
  expect(find.text('google ile giris'), findsOneWidget);

  //print('google ile giris butonuna tıklanıyor');
  //await tester.tap(find.text('google ile giris'));
  //await tester.pumpAndSettle();

  print('Test tamamlandı');
  });
}

/*import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_manager/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuthPlatform {}

void main() {

setUpAll(() async {
    FirebaseApp app = await Firebase.initializeApp();
    FirebaseAuthPlatform.instance = MockFirebaseAuth();
  });

  testWidgets('Google ile Giriş butonuna tıklama', (WidgetTester tester) async {
    // EasyLocalization paketini başlatın
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('ar', 'AR')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar', 'AR'),
        startLocale: const Locale('ar', 'AR'),
        useOnlyLangCode: true,
        saveLocale: true,
        child: const MyApp(),
      ),
    );

    // Dil dosyalarının yüklenmesi için ek bir pump yapın
    await tester.pumpAndSettle();

    // Giriş sayfasında "google ile giris" butonunu bulun
    final Finder loginButton = find.text('google ile giris');

    // Butonun ekranda olduğundan emin olun
    expect(loginButton, findsOneWidget);

    // Butona tıklayın
    await tester.tap(loginButton);

    // Yeniden build yapın
    await tester.pump();

    // Butona tıklandığını doğrulamak için daha fazla kontrol ekleyebilirsiniz
  });
}
*/
/*import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_manager/main.dart';
import 'package:easy_localization/easy_localization.dart';

void main() {
  testWidgets('Google ile Giriş butonuna tıklama', (WidgetTester tester) async {
    // EasyLocalization paketini başlatın
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('ar', 'AR')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar', 'AR'),
        startLocale: const Locale('ar', 'AR'),
        useOnlyLangCode: true,
        saveLocale: true,
        child: const MyApp(),
      ),
    );

    // Dil dosyalarının yüklenmesi için ek bir pump yapın
    await tester.pumpAndSettle();

    // Giriş sayfasında "google ile giris" butonunu bulun
    final Finder loginButton = find.text('google ile giris');

    // Butonun ekranda olduğundan emin olun
    expect(loginButton, findsOneWidget);

    // Butona tıklayın
    await tester.tap(loginButton);

    // Yeniden build yapın
    await tester.pump();

    // Butona tıklandığını doğrulamak için daha fazla kontrol ekleyebilirsiniz
  });
}

*/
/*import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:product_manager/controller/res/custom_colors.dart';
import 'package:product_manager/main.dart';
import 'package:product_manager/view/screens/sign_in_screen.dart';
import 'package:product_manager/view/widgets/google_sign_in_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'shared_preferences_mock.dart'; // Import the mock class

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences sharedPreferences;
  testWidgets('SignInScreen displays welcome message and GoogleSignInButton',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en', 'US')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp(),
      ),
    );

    await tester.pumpAndSettle();

    // Check for welcome message and GoogleSignInButton
    expect(find.text('hosgeldiniz'), findsOneWidget);
    expect(find.byType(GoogleSignInButton), findsOneWidget);

    // Check Scaffold background color
    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor, CustomColors.firebaseNavy);

    // Tap the GoogleSignInButton
    await tester.tap(find.byType(GoogleSignInButton));
    await tester.pumpAndSettle();

    // Here you would normally simulate the sign-in process
    // Since we cannot perform actual sign-in, we check the expected behavior after tapping the button
    // For instance, check if navigation occurred, or if a loading indicator is shown
  });

  // Add more tests here
}
*/

/*import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:product_manager/controller/res/custom_colors.dart';
import 'package:product_manager/main.dart';
import 'package:product_manager/View/screens/sign_in_screen.dart';
import 'package:product_manager/view/widgets/google_sign_in_button.dart';
import 'shared_preferences_mock.dart'; // Import the mock class
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';


@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences sharedPreferences;

  setUpAll(() async {
    sharedPreferences = MockSharedPreferences();

    // Mocking SharedPreferences methods
    when(sharedPreferences.getString("hosgeldiniz")).thenReturn(null);
    when(sharedPreferences.setString(AutofillHints.email,abdulrahmansadoo@gmail.com)).thenAnswer((_) async => true);
    SharedPreferences.setMockInitialValues({});
    
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('SignInScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en', 'US')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp(),
      ),
    );

    await tester.pumpAndSettle();

    // Check for welcome message and GoogleSignInButton
    expect(find.text('hosgeldiniz'), findsOneWidget);
    expect(find.byType(GoogleSignInButton), findsOneWidget);

    // Check Scaffold background color
    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor, CustomColors.firebaseNavy);
  });

  // Add more tests here
}
*/