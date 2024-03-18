# basic response call
final dio = Dio();

void getHttp() async {
  final response = await dio.get('https://dart.dev');
  print(response);
}

# Making instances of Dio

final dio = Dio(
  BaseOptions(  
    baseUrl: 'https://api.example.com',
    connectTimeout: 5000,
    receiveTimeout: 5000,
    headers: {
      'Accept': 'application/json',
    },
  ),
);

# *BaseOptions calls allows us to set default options for our requests, including base Url, connection timeout and headers.
# *baseUrl option specifies the base URL for all requests made with Dio instance.
# * "connectTimeout" and "recieveTimeout" specify the maximum amount of time to wait for conncection adn data to be received.
# Headers option


#  get, post, put, patch, or delete methods