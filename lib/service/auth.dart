import 'package:oauth2_client/oauth2_helper.dart';
import 'package:oauth2_client/google_oauth2_client.dart';
import 'package:http/http.dart' as http;


GoogleOAuth2Client client = GoogleOAuth2Client(
  customUriScheme: 'my.test.app', //Must correspond to the AndroidManifest's "android:scheme" attribute
  redirectUri: 'my.test.app:/oauth2redirect', //Can be any URI, but the scheme part must correspond to the customUriScheme
);

//Then, instantiate the helper passing the previously instantiated client
OAuth2Helper oauth2Helper = OAuth2Helper(client,
    grantType: OAuth2Helper.authorizationCode,
    clientId: 'your_client_id',
    clientSecret: 'your_client_secret',
    scopes: ['https://www.googleapis.com/auth/drive.readonly']);