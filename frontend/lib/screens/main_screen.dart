import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'find_room_screen.dart';
import 'create_room_screen.dart';
import 'option_screen.dart';
import 'room_screen.dart';
import '../models/room.dart';

/// MainScreen: 로그인 전/후 버튼을 분기하여 보여주는 메인 화면입니다.
class MainScreen extends StatefulWidget {
  static const String routeName = '/main';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TRPG 메인 화면'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:
                _isLoggedIn ? _buildLoggedInButtons() : _buildLoggedOutButton(),
          ),
        ),
      ),
    );
  }

  /// 로그인 전: 로그인 버튼만 노출
  List<Widget> _buildLoggedOutButton() {
    return [
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            final result = await Navigator.pushNamed(
              context,
              LoginScreen.routeName,
            );
            if (result == true) {
              setState(() {
                _isLoggedIn = true;
              });
            }
          },
          child: Text('로그인', style: TextStyle(fontSize: 18)),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    ];
  }

  /// 로그인 후: 방 만들기 / 방 찾기 / 설정 / 나가기 버튼 노출
  List<Widget> _buildLoggedInButtons() {
    return [
      // 1) 방 만들기
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, CreateRoomScreen.routeName);
          },
          icon: Icon(Icons.add),
          label: Text('방 만들기', style: TextStyle(fontSize: 18)),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
      SizedBox(height: 16),

      // 2) 방 찾기
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, FindRoomScreen.routeName);
          },
          icon: Icon(Icons.search),
          label: Text('방 찾기', style: TextStyle(fontSize: 18)),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
      SizedBox(height: 16),

      // 3) 옵션
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, OptionsScreen.routeName);
          },
          icon: Icon(Icons.settings),
          label: Text('설정', style: TextStyle(fontSize: 18)),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
      SizedBox(height: 16),

      // 3-1) 더미 방 테스트
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => RoomScreen(
                      room: Room(
                        id: 1,
                        name: '더미 방',
                        capacity: 4,
                        isPublic: true,
                      ),
                    ),
              ),
            );
          },
          icon: Icon(Icons.bug_report),
          label: Text('더미 방 테스트', style: TextStyle(fontSize: 18)),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
      SizedBox(height: 16),

      // 4) 나가기
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _isLoggedIn = false;
            });
          },
          icon: Icon(Icons.exit_to_app),
          label: Text('나가기', style: TextStyle(fontSize: 18)),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    ];
  }
}
