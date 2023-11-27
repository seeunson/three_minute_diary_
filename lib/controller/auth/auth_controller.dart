import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth 인스턴스
  //final GoogleSignIn _googleSignIn = GoogleSignIn(); // Google Sign-In 인스턴스
  // 현재 로그인한 사용자 정보를 담는 Rx<User?> 객체
  final Rx<User?> user = Rx<User?>(FirebaseAuth.instance.currentUser);
  void signin({
    required String email,
    required String password,
  }) async {
    try {
      // Firebase Auth를 사용한 회원가입 로직
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // 로그인 성공 시 알림
      Get.snackbar('로그인 성공', '로그인에 성공했습니다.');
      Get.toNamed('/index');
    } catch (e) {
      // 로그인 실패 시 알림
      print('로그인 실패: $e');

      Get.snackbar('로그인 실패', '로그인에 실패했습니다: $e');
    }
  }

  // Google 로그인
  //  Google 로그인
  // Future<User?> signInWithGoogle() async {
  //   try {
  //     // Google 로그인 창을 표시
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     if (googleUser == null) return null; // 사용자가 로그인을 취소한 경우, null 반환

  //     // Google 로그인 인증 데이터 획득
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     // Google 로그인 인증 데이터를 사용하여 Firebase 인증 정보 생성
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     // Firebase에 사용자 정보 등록하고, UserCredential 객체 반환
  //     UserCredential userCredential =
  //         await _auth.signInWithCredential(credential);

  //     // 로그인 성공 스낵바 표시
  //     Get.snackbar('로그인 성공', '구글 로그인에 성공했습니다.');
  //     Get.toNamed('/index');
  //     return userCredential.user; // Firebase User 객체 반환
  //   } catch (e) {
  //     // 에러 발생 시 스낵바 표시
  //     Get.snackbar('로그인 실패', '로그인 중 에러가 발생했습니다: $e');
  //     print('로그인 에러: $e');
  //     return null;
  //   }
  // }

  // 로그아웃 메소드
  void signOut() async {
    // await _googleSignIn.signOut(); // Google 로그아웃
    await _auth.signOut(); // Firebase 로그아웃
    Get.snackbar('로그아웃 성공', '로그아웃에 성공했습니다.');
    Get.offAll('/login');
  }

//회원가입
  void signup({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      // Firebase Auth를 사용한 회원가입 로직
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // 사용자 프로필 업데이트 (예: 이름)
      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload(); // 사용자 정보 새로고침
      }

      print(userCredential.user);
      // 회원가입 성공 시 알림
      Get.snackbar('회원가입 성공', '회원가입에 성공했습니다.');
    } catch (e) {
      // 회원가입 실패 시 알림
      print('회원가입 실패: $e');

      Get.snackbar('회원가입 실패', '회원가입에 실패했습니다: $e');
    }
  }
}
