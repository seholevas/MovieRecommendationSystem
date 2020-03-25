import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:recommend/core/network/instance.network.information.dart';
import 'package:recommend/core/util/input.converter.dart';
import 'package:recommend/production/features/ai/data/remote-data-sources/ai.remote.datasource.dart';
import 'package:recommend/production/features/ai/data/repositories-implementation/ai.repository.implementation.dart';
import 'package:recommend/production/features/ai/domain/repositories-abstractions/ai.repository.dart';
import 'package:recommend/production/features/ai/domain/usecases/get.ai.suggestions.dart';
import 'package:recommend/production/features/ai/presentation/knn.ai.bloc/bloc/ai_bloc.dart';
import 'package:recommend/production/features/movie/data/remote-data-sources/movie.remote.datasource.dart';
import 'package:recommend/production/features/movie/data/repositories-implementation/movie.repository.implementation.dart';
import 'package:recommend/production/features/movie/domain/repositories-abstractions/movie.repository.dart';
import 'package:recommend/production/features/movie/domain/usecases/get.movie.information.dart';
import 'package:recommend/production/features/movie/domain/usecases/get.movies.information.dart';
import 'package:recommend/production/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:recommend/production/features/movie/presentation/movies_bloc/bloc/movies_bloc.dart';
import 'package:recommend/production/features/rating/data/datasource/rating.remote.datasource.dart';
import 'package:recommend/production/features/rating/data/repository/rating.repository.implementation.dart';
import 'package:recommend/production/features/rating/domain/repositories-abstractions/rating.repository.dart';
import 'package:recommend/production/features/rating/domain/usecases/get.all.rated.movies.from.user.dart';
import 'package:recommend/production/features/rating/domain/usecases/get.rating.information.dart';
import 'package:recommend/production/features/rating/domain/usecases/submit.rating.dart';
import 'package:recommend/production/features/rating/presentation/blocs/rating.bloc/rating_bloc.dart';
import 'package:recommend/production/features/rating/presentation/blocs/ratings.bloc/users_ratings_bloc.dart';
import 'package:recommend/production/features/user/data/remote-data-sources/user.remote.datasource.dart';
import 'package:recommend/production/features/user/data/repositories-implementation/user.repository.implementation.dart';
import 'package:recommend/production/features/user/domain/repositories-abstractions/user.repository.dart';
import 'package:recommend/production/features/user/domain/usecases/create.account.dart';
import 'package:recommend/production/features/user/domain/usecases/get.user.information.dart';
import 'package:recommend/production/features/user/domain/usecases/sign.in.dart';
import 'package:recommend/production/features/user/presentation/bloc/create.account.bloc/create_account_bloc.dart';
import 'package:recommend/production/features/user/presentation/bloc/login.bloc/bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {


  // ! FEATURE - AI
  sl.registerFactory(
      () => AiBloc(getAISuggestions: sl(), inputConverter: sl()));
  // Repository - AI
  sl.registerLazySingleton<ArtificialIntelligenceKNNRepository>(() =>
      ArtificialIntelligenceKNNRepositoryImplementation(
          remoteDataSource: sl(), networkInformation: sl()));

  // Data sources - AI
  sl.registerLazySingleton<ArtificialIntelligenceKNNRemoteDataSource>(
    () => ArtificialIntelligenceKNNRemoteDataSourceImplementation(client: sl()),
  );

  sl.registerLazySingleton(() => GetAISuggestions(sl()));

  // ! FEATURE - RATING | USECASE - GET ALL RATINGS
  sl.registerFactory(() => UsersRatingsBloc(getAllMoviesUserRated: sl()));

  // Use cases - Rating
  sl.registerLazySingleton(() => GetAllMoviesUserRated(sl()));
  // Repository - Rating
  sl.registerLazySingleton<RatingRepository>(
    () => RatingRepositoryImplementation(
      networkInformation: sl(),
      remoteDataSource: sl(),
    ),
  );

  //! FEATURE - RATING | USECASE - GETTING AND SUBMITTING RATINGS
  //registering BLoC
  sl.registerFactory(() => RatingBloc(
      getRatingInformation: sl(),
      submitRatingInformation: sl(),
      inputConverter: sl()));

  // registering usecases
  sl.registerLazySingleton(() => GetRatingInformation(sl()));
  sl.registerLazySingleton(() => SubmitRatingInformation(sl()));

  // Data sources - Rating
  sl.registerLazySingleton<RatingRemoteDataSource>(
    () => RatingRemoteDataSourceImplementation(client: sl()),
  );

  //! Features - Movie
  // Bloc
  sl.registerFactory(
    () => MovieBloc(
      movieInformation: sl(),
      inputConverter: sl(),
    ),
  );

  // Use cases - Movie
  sl.registerLazySingleton(() => GetMovieInformation(sl()));

  // Repository - Movie
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImplementation(
      networkInformation: sl(),
      remoteDataSource: sl(),
    ),
  );

  // //! MOVIES BLOC PAGE
  sl.registerFactory(
      () => MoviesBloc(getMoviesInformation: sl(), 
      inputConverter: sl()
      ),
      );

//Lazy Singletons.
  sl.registerLazySingleton(() => GetAllMoviesInformation(sl()));


  // Data sources - Movie
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImplementation(client: sl()),
  );

  // ! FEATURE - USER | USECASE - CREATE ACCOUNT
  sl.registerFactory(
      () => CreateAccountBloc(createAccount: sl(), inputConverter: sl()));

  //! FEATURE - USER | USECASE - LOGIN
  sl.registerFactory(() => LoginBloc(signIn: sl()));

//! Features - USER

  // Use cases - User
  sl.registerLazySingleton(() => GetUserInformation(sl()));
  sl.registerLazySingleton(() => SignIn(sl()));
  sl.registerLazySingleton(() => CreateAccount(sl()));

  // Repository - User
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImplementation(
      networkInformation: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data sources - User
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImplementation(client: sl()),
  );

  //! Core - ALL
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInformation>(
      () => NetworkInformationImplementation(sl()));

  //! External - ALL
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
