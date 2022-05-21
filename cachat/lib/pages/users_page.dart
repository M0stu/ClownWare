//Packages
import 'package:cachat/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

//Providers
import '../model/chat.dart';
import '../providers/authentication_provider.dart';
import '../providers/chats_page_provider.dart';
import '../providers/users_page_provider.dart';

//Widgets
import '../widgets/top_bar.dart';
import '../widgets/custom_input_fields.dart';
import '../widgets/custom_list_view_tiles.dart';
import '../widgets/rounded_button.dart';

//Models
import '../model/chat_user.dart';

//Services
import '../services/navigation_service.dart';

class UsersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UsersPageState();
  }
}

class _UsersPageState extends State<UsersPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  late AuthenticationProvider _auth;
  late UsersPageProvider _pageProvider;
  late NavigationService _navigation;
  final TextEditingController _searchFieldTextEditingController =
      TextEditingController();
  late ChatsPageProvider _chatsPageProvider;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    _navigation = GetIt.instance.get<NavigationService>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UsersPageProvider>(
          create: (_) => UsersPageProvider(_auth),
        ),
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
        _pageProvider = _context.watch<UsersPageProvider>();
        _chatsPageProvider = _context.watch<ChatsPageProvider>();
        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: _deviceWidth * 0.03, vertical: _deviceHeight * 0.02),
          height: _deviceHeight * 0.98,
          width: _deviceWidth * 0.97,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TopBar(
                'Users',
              ),
              CustomTextField(
                onEditingComplete: (_value) {
                  _pageProvider.getUsers(name: _value);
                  FocusScope.of(context).unfocus();
                },
                hintText: "Search...",
                obscureText: false,
                controller: _searchFieldTextEditingController,
                icon: Icons.search,
              ),
              _usersList(),
              _createChatButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _usersList() {
    List<ChatUser>? _users = _pageProvider.users;
    return Expanded(child: () {
      if (_users != null) {
        if (_users.isNotEmpty) {
          return ListView.builder(
            itemCount: _users.length,
            itemBuilder: (BuildContext _context, int _index) {
              if (_users[_index].name != _auth.user.name) {
                return CustomListViewTile(
                  height: _deviceHeight * 0.10,
                  title: _users[_index].name,
                  subtitle: "Last Active: ${_users[_index].lastTimeActive()}",
                  imagePath: _users[_index].imageURL,
                  isActive: _users[_index].wasRecentlyActive(),
                  isSelected: _pageProvider.selectedUsers.contains(
                    _users[_index],
                  ),
                  //Showing the users in Users Page
                  onTap: () {
                    _pageProvider.updateSelectedUsers(
                      _users[_index],
                    );
                  },
                );
              } else {
                return const Text(
                  "",
                );
              }
            },
          );
        } else {
          return const Center(
            child: Text(
              "No Users Found.",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        }
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      }
    }());
  }

  Widget _createChatButton() {
    List<Chat>? _chats = _chatsPageProvider.chats;
    return Visibility(
      visible: _pageProvider.selectedUsers.isNotEmpty,
      child: RoundedButton(
        name: _pageProvider.selectedUsers.length == 1
            ? "Chat With ${_pageProvider.selectedUsers.first.name}"
            : "Create Group Chat",
        height: _deviceHeight * 0.08,
        width: _deviceWidth * 0.80,
        onPressed: () {
          if (_chats!.isNotEmpty) {
            for (int i = 0; i < _chats.length; i++) {
              if (!_chats[i].group) {
                print("Hereeeeeeee     user page >> " +
                    _chats[i].members.last.name +
                    "  " +
                    _pageProvider.selectedUsers.first.name);
                print("not group   >>>>  " + _chats[i].uid);
                if (_chats[i].members.last.uid ==
                        _pageProvider.selectedUsers.first.uid ||
                    _chats[i].members.first.uid ==
                        _pageProvider.selectedUsers.first.uid) {
                  _navigation.navigateToPage(ChatPage(chat: _chats[i]));
                  break;
                }
              }
            }
          }
          //_pageProvider.createChat();
        },
      ),
    );
  }
}
