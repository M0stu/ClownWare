//Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

//Provider
import '../model/chat_message.dart';
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
  final List<String> _chatTitle = ["", "", "", "", "", "", ""];
  late double _deviceHeight;
  late double _deviceWidth;
  late NavigationService _navigation;
  late AuthenticationProvider _auth;
  late ChatsPageProvider _pageProvider;
  String _senderName = "_";
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
          if (_chats.isNotEmpty) {
            return ListView.builder(
              itemCount: _chats.length,
              itemBuilder: (BuildContext _context, int _index) {
                return _chatTile(_chats[_index], _chats.length);
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

  Widget _chatTile(Chat _chat, int _chatLength) {
    List<ChatUser> _recepients = _chat.recepients();
    bool _isActive = _recepients.any((_d) => _d.wasRecentlyActive());
    String _subtitleText = "";
    if (_chat.messages.isNotEmpty) {
      _subtitleText = _chat.messages.first.type != MessageType.TEXT
          ? "Media Attachment"
          : _chat.messages.first.content;
    }
    _chatTitle.length == _chatLength;
    _chatTitle.add(_chat.title());
    print("Chat Title hereeeeeeeeeeeee      " + _chat.title());
    //_chatTitle.add(_chat.title());

    //print(_chatTitle.isEmpty);
    return CustomListViewTileWithActivity(
      height: _deviceHeight * 0.12,
      title: _chat.title(),
      subtitle: _subtitleText,
      imagePath: _chat.imageURL(),
      isActive: _isActive,
      isActivity: _chat.activity,
      onTap: () {
        setSenderName(_chat.title());
        print("senderName     >>     " + getSenderName());
        _pageProvider.chatTitleChatPage = _chatTitle;
        _navigation.navigateToPage(
          ChatPage(chat: _chat),
        );
      },
    );
  }

  void setSenderName(String newName) {
    _senderName = newName;
  }

  String getSenderName() {
    return _senderName;
  }
}
