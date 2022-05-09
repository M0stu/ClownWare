//Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

//Provider
import '../model/chat_user.dart';
import '../providers/authentication_provider.dart';
import '../providers/chats_page_provider.dart';

//Services
import '../services/navigation_service.dart';
import '../services/database_service.dart';
//Pages
import '../pages/chat_page.dart';

//Widgets
import '../widgets/top_bar.dart';
import '../widgets/custom_list_view_tiles.dart';

//Models
import '../model/chat.dart';
import '../model/chat_user.dart';

class ChatsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatsPageState();
  }
}

class _ChatsPageState extends State<ChatsPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  late NavigationService _navigation;
  late AuthenticationProvider _auth;
  late ChatsPageProvider _pageProvider;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    _auth = Provider.of<AuthenticationProvider>(context);
    _navigation = GetIt.instance.get<NavigationService>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatsPageProvider>(
          create: (_) => ChatsPageProvider(_auth),
        ),
      ],
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(
      builder: (BuildContext _context) {
        _pageProvider = _context.watch<ChatsPageProvider>();
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.03,
            vertical: _deviceHeight * 0.02,
          ),
          height: _deviceHeight * 0.98,
          width: _deviceWidth * 0.97,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TopBar(
                'Chats',
                primaryAction: IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Color.fromRGBO(0, 82, 218, 1.0),
                  ),
                  onPressed: () {
                    _auth.logout();
                  },
                ),
              ),
              _chatsList(),
            ],
          ),
        );
      },
    );
  }

  Widget _chatsList() {
    List<Chat>? _chats = _pageProvider.chats;
    return Expanded(
      child: (() {
        if (_chats != null) {
          if (_chats.length != 0) {
            return ListView.builder(
              itemCount: _chats.length,
              itemBuilder: (BuildContext _context, int _index) {
                return _chatTile(
                  _chats[_index],
                );
              },
            );
          } else {
            return const Center(
                child: Text(
              "No Chats Found.",
              style: TextStyle(color: Colors.white),
            ));
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      })(),
    );
  }

  Widget _chatTile(Chat _chat) {
    List<ChatUser> _recepients = _chat.recepients();
    bool _isActive = _recepients.any((_d) => _d.wasRecentlyActive());
    return CustomListViewTileWithActivity(
        height: _deviceHeight * 0.10,
        title: "Hextech",
        subtitle: "Hello",
        imagePath:
            "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.dreamstime.com%2Fhappy-smiling-geek-hipster-beard-man-cool-avatar-geek-man-avatar-image104871313&psig=AOvVaw0cyyyEDYDOLipEdmKIGB29&ust=1651758688062000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCPixtMf-xfcCFQAAAAAdAAAAABAJ",
        isActive: false,
        isActivity: false,
        onTap: () {
          _navigation.navigateToPage(
            ChatPage(chat: _chat),
          );
        });
  }
}
