import 'package:get/get.dart';
import 'package:messengerapp/routes/names.dart';
import 'package:messengerapp/screens/chatroomscreen/bindings.dart';
import 'package:messengerapp/screens/chatroomscreen/view.dart';
import 'package:messengerapp/screens/homescreen/bindings.dart';
import 'package:messengerapp/screens/homescreen/view.dart';
import 'package:messengerapp/screens/signinscreen/bindings.dart';
import 'package:messengerapp/screens/signinscreen/view.dart';
import 'package:messengerapp/screens/signupscreen/bindings.dart';
import 'package:messengerapp/screens/signupscreen/view.dart';
import 'package:messengerapp/screens/welcomescreen/bindings.dart';
import 'package:messengerapp/screens/welcomescreen/view.dart';

class AppPages {
  static const initial = AppRoutes.initial;
  static const signIn = AppRoutes.signIn;
  static const signUp = AppRoutes.signUp;
  static const chatRoom = AppRoutes.chatroom;
  static const homescreen = AppRoutes.homescreen;
  static const application = AppRoutes.application;

  static final List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () => const WelcomeScreen(),
      binding: WelcomeBindings(),
    ),
    GetPage(
      name: signIn,
      page: () => const SignInScreen(),
      binding: SignInBindings(),
      transition: Transition.fade,
    ),
    GetPage(
      name: homescreen,
      page: () => const HomeScreen(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: signUp,
      page: () => const SignUpScreen(),
      binding: SignUpBindings(),
      transition: Transition.circularReveal,
    ),
    GetPage(
      name: chatRoom,
      page: () => const ChatRoomScreen(),
      binding: ChatRoomBindings(),
    ),
  ];
}
