import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../api/index.dart';
import '../../models/response/user/user_model.dart';
import '../../widgets/common/pull_refresh_listview.dart';

class DummyPage extends StatefulWidget {
  DummyPage({Key? key}) : super(key: key);
  @override
  _DummyPageState createState() => _DummyPageState();
}

class _DummyPageState extends State<DummyPage> {
  FutureManager<UserResponse> userController = FutureManager();
  int currentPage = 1;

  Future fetchData([bool reload = false]) async {
    if (reload) {
      currentPage = 1;
    }
    userController.asyncOperation(
      () => userRepository.fetchUserList(
        count: 10,
        page: currentPage,
      ),
      onSuccess: (response) {
        if (userController.hasData) {
          response.users = [...userController.data!.users, ...response.users];
        }
        currentPage += 1;
        return response;
      },
      reloading: reload,
    );
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fetch all users with pagination")),
      body: FutureManagerBuilder<UserResponse>(
        futureManager: userController,
        ready: (context, UserResponse response) {
          return PullRefreshListViewBuilder.paginated(
            onRefresh: () => fetchData(true),
            itemCount: response.users.length,
            hasMoreData: response.hasMoreData,
            itemBuilder: (context, index) {
              final user = response.users[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                onTap: () {},
                title: Text("${user.firstName} ${user.lastName}"),
                subtitle: Text(user.email!),
              );
            },
            onGetMoreData: fetchData,
          );
        },
      ),
    );
  }
}
