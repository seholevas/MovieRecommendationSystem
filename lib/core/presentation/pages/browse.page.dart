import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommend/core/presentation/screens/blank.screen.dart';
import 'package:recommend/core/presentation/screens/browse.loaded.screen.dart';
import 'package:recommend/core/presentation/screens/loading.screen.dart';
import 'package:recommend/injection.container.dart';
import 'package:recommend/production/features/rating/presentation/blocs/ratings.bloc/users_ratings_bloc.dart';

class BrowsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  BlocProvider<UsersRatingsBloc> _buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UsersRatingsBloc>(),
      child: BlocBuilder<UsersRatingsBloc, UsersRatingsState>(
          builder: (context, state) => _stateChanger(context, state)),
    );
  }

  Widget _stateChanger(BuildContext context, UsersRatingsState state) {
    if (state is Initial) {
      BlocProvider.of<UsersRatingsBloc>(context).add(GetUsersRatingsEvent());
      return BlankScreen();
    }
    if (state is Loading) {
      return LoadingScreen();
    }
    if (state is Error) {
      return Container(child: Text("ERROR!"));
      // return ErrorScreen();
    }

    if (state is Loaded) {
      return BrowseLoadedScreen(ratings: state.ratings);
    }
  }
}
