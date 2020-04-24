import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:recommend/core/util/input.converter.dart';
import 'package:recommend/features/ai/ai.remote.datasource.dart';
import 'package:recommend/features/ai/ai.repository.dart';
import 'package:recommend/features/ai/ai.repository.implementation.dart';
import 'package:recommend/features/ai/get.ai.suggestions.dart';
import 'package:recommend/features/movie/get.movie.information.dart';
import 'package:recommend/features/movie/get.movies.information.dart';
import 'package:recommend/features/movie/movie.remote.datasource.dart';
import 'package:recommend/features/movie/movie.repository.dart';
import 'package:recommend/features/movie/movie.repository.implementation.dart';
import 'package:recommend/features/rating/get.all.rated.movies.from.user.dart';
import 'package:recommend/features/rating/get.rating.information.dart';
import 'package:recommend/features/rating/rating.remote.datasource.dart';
import 'package:recommend/features/rating/rating.repository.dart';
import 'package:recommend/features/rating/rating.repository.implementation.dart';
import 'package:recommend/features/rating/submit.rating.dart';
import 'package:recommend/features/user/create.account.dart';
import 'package:recommend/features/user/get.user.information.dart';
import 'package:recommend/features/user/sign.in.dart';
import 'package:recommend/features/user/user.remote.datasource.dart';
import 'package:recommend/features/user/user.repository.dart';
import 'package:recommend/features/user/user.repository.implementation.dart';


final sl = GetIt.instance;

Future<void> init() async {


  // ! FEATURE - AI
  // sl.registerFactory(
  //     () => AiBloc(getAISuggestions: sl(), inputConverter: sl()));
  // // Repository - AI
  // sl.registerLazySingleton<KNNRepository>(() =>
  //     KNNRepositoryImplementation(
  //         remoteDataSource: sl()));

  // Data sources - AI
  sl.registerLazySingleton<KNNRemoteDataSource>(
    () => KNNRemoteDataSourceImplementation(client: sl()),
  );

  sl.registerLazySingleton(() => GetAISuggestions(sl()));

  // // ! FEATURE - RATING | USECASE - GET ALL RATINGS
  // sl.registerFactory(() => UsersRatingsBloc(getAllMoviesUserRated: sl()));

  // // Use cases - Rating
  // sl.registerLazySingleton(() => GetAllMoviesUserRated(sl()));
  // // Repository - Rating
  // sl.registerLazySingleton<RatingRepository>(
  //   () => RatingRepositoryImplementation(
  //     remoteDataSource: sl(),
  //   ),
  // );

  //! FEATURE - RATING | USECASE - GETTING AND SUBMITTING RATINGS
  // //registering BLoC
  // sl.registerFactory(() => RatingBloc(
  //     getRatingInformation: sl(),
  //     submitRatingInformation: sl(),
  //     inputConverter: sl()));

  // registering usecases
  sl.registerLazySingleton(() => GetRatingInformation(sl()));
  sl.registerLazySingleton(() => SubmitRatingInformation(sl()));

  // Data sources - Rating
  sl.registerLazySingleton<RatingRemoteDataSource>(
    () => RatingRemoteDataSourceImplementation(client: sl()),
  );

  //! Features - Movie
  // // Bloc
  // sl.registerFactory(
  //   () => MovieBloc(
  //     movieInformation: sl(),
  //     inputConverter: sl(),
  //   ),
  // );

  // Use cases - Movie
  sl.registerLazySingleton(() => GetMovieInformation(sl()));

  // Repository - Movie
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImplementation(
      remoteDataSource: sl(),
    ),
  );

//   // //! MOVIES BLOC PAGE
//   sl.registerFactory(
//       () => MoviesBloc(getMoviesInformation: sl(), 
//       inputConverter: sl()
//       ),
//       );

// //Lazy Singletons.
//   sl.registerLazySingleton(() => GetAllMoviesInformation(sl()));


//   // Data sources - Movie
//   sl.registerLazySingleton<MovieRemoteDataSource>(
//     () => MovieRemoteDataSourceImplementation(client: sl()),
//   );

//   // ! FEATURE - USER | USECASE - CREATE ACCOUNT
//   sl.registerFactory(
//       () => CreateAccountBloc(createAccount: sl(), inputConverter: sl()));

  //! FEATURE - USER | USECASE - LOGIN
  // sl.registerFactory(() => LoginBloc(signIn: sl()));

//! Features - USER

  // Use cases - User
  sl.registerLazySingleton(() => GetUserInformation(sl()));
  sl.registerLazySingleton(() => SignIn(sl()));
  sl.registerLazySingleton(() => CreateAccount(sl()));

  // Repository - User
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImplementation(
      remoteDataSource: sl(),
    ),
  );

  // Data sources - User
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImplementation(client: sl()),
  );

  //! Core - ALL
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton(() => http.Client());
}
