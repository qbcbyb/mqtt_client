/*
 * Package : mqtt_client
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/06/2017
 * Copyright :  S.Hamblett
 */

part of mqtt_browser_client;

///  This class provides specific connection functionality
///  for browser based connection handler implementations.
abstract class MqttBrowserConnectionHandler<T extends MqttConnectionBase<R>,
    R extends BaseConnection> extends MqttConnectionHandlerBase<T, R> {
  /// Initializes a new instance of the [MqttBrowserConnectionHandler] class.
  MqttBrowserConnectionHandler();
}
