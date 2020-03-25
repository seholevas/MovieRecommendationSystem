// import 'package:data_connection_checker/data_connection_checker.dart';

import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInformation{
  Future<bool> get isConnected;
}

class NetworkInformationImplementation implements NetworkInformation
{
  final DataConnectionChecker connectionChecker;
  NetworkInformationImplementation(this.connectionChecker);

  @override
  // TODO: implement isConnected
  Future<bool> get isConnected => connectionChecker.hasConnection;
  
}