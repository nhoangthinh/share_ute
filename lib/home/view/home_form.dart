import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/create_folder_and_post/create_folder_and_post.dart';
import 'package:share_ute/document/view/document_page.dart';
import 'package:share_ute/drawer/drawer.dart';
import 'package:share_ute/main_screen/main_screen.dart';
import 'package:share_ute/notification/notification.dart';
import 'package:share_ute/search_screen/search_screen.dart';
import 'package:share_ute/theme.dart';
import 'package:share_ute/upload_post/upload_post.dart';
import 'package:share_ute/upload_screen/upload_screen.dart';
import 'package:share_ute/views/folder_page.dart';
import 'package:share_ute/views/recent_page.dart';
import 'package:share_ute/widgets/folder_create_bottom_sheet.dart';

class HomeForm extends StatefulWidget {
  const HomeForm({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeForm());
  }

  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppTheme.nearlyWhite,
        body: BlocListener<NotificationCubit, NotificationState>(
          listener: (context, state) {
            if (state.status == NotificationStatus.postCreated) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.lightBlue,
                    behavior: SnackBarBehavior.fixed,
                    content: Text(
                      'Tạo bài đăng thành công',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    action: SnackBarAction(
                      label: 'Xem',
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          DocumentPage.route(),
                        );
                      },
                    ),
                  ),
                );
            }
          },
          child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                // SliverAppBar custom SearchBar
                SliverAppBar(
                  iconTheme:
                      new IconThemeData(color: CupertinoColors.systemGrey),
                  toolbarHeight: 80,
                  pinned: innerBoxIsScrolled == true ? false : true,
                  floating: true,
                  backgroundColor: CupertinoColors.white,
                  title: Container(
                    child: Material(
                      elevation: 8,
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      child: Container(
                        height: 45,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: InkWell(
                                child: TextFormField(
                                  enabled: false,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: 'WorkSans'),
                                  decoration: InputDecoration(
                                    hintText: "Tìm kiếm tài liệu của bạn",
                                    border: InputBorder.none,
                                  ),
                                ),
                                onTap: () async {
                                  await showSearch(
                                      context: context, delegate: SearchPage());
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ];
            },
            body: Container(
              child: PageView(
                controller: _pageController,
                children: [
                  ListPost(),
                  RecentPage(),
                  MyFolderPage(),
                ],
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppTheme.notWhite,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: CupertinoColors.activeBlue,
          currentIndex: currentIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'Trang chủ',
              icon: Icon(
                const IconData(63715,
                    fontFamily: CupertinoIcons.iconFont,
                    fontPackage: CupertinoIcons.iconFontPackage),
              ),
            ),
            BottomNavigationBarItem(
              label: 'Gần đây',
              icon: Icon(
                const IconData(0xf4be,
                    fontFamily: CupertinoIcons.iconFont,
                    fontPackage: CupertinoIcons.iconFontPackage),
              ),
            ),
            BottomNavigationBarItem(
              label: 'Thư mục',
              icon: Icon(
                const IconData(0xf434,
                    fontFamily: CupertinoIcons.iconFont,
                    fontPackage: CupertinoIcons.iconFontPackage),
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
            _pageController.jumpToPage(index);
          },
        ),
        drawer: DrawerWidget(),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            elevation: 2.0,
            child: RadiantGradientMask(
              child: Icon(
                const IconData(
                  0xf489,
                  fontFamily: CupertinoIcons.iconFont,
                  fontPackage: CupertinoIcons.iconFontPackage,
                ),
                size: 30.0,
              ),
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => CreateFolderAndPostPage(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment(0.8, 0.0),
        colors: [const Color(0xffee0000), const Color(0xffeeee00)],
        tileMode: TileMode.repeated,
      ).createShader(bounds),
      child: child,
    );
  }
}
