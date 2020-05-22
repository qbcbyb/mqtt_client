/*
 * Package : mqtt_client
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 29/03/2020
 * Copyright :  S.Hamblett
 */

part of mqtt_client;

/// The MQTT client connection base class
abstract class MqttConnectionBase<T extends BaseConnection> {
  /// Default constructor
  MqttConnectionBase(this.clientEventBus);

  /// Initializes a new instance of the MqttConnection class.
  MqttConnectionBase.fromConnect(String server, int port, this.clientEventBus) {
    connect(server, port);
  }

  /// The socket that maintains the connection to the MQTT broker.
  @protected
  T client;

  /// The read wrapper
  @protected
  ReadWrapper readWrapper;

  ///The read buffer
  @protected
  MqttByteBuffer messageStream;

  /// Unsolicited disconnection callback
  DisconnectCallback onDisconnected;

  /// The event bus
  @protected
  events.EventBus clientEventBus;

  /// Connect, must be overridden in connection classes
  Future<void> connect(String server, int port) {
    final completer = Completer<void>();
    return completer.future;
  }

  /// OnError listener callback
  @protected
  void onError(dynamic error) {
    _disconnect();
    if (onDisconnected != null) {
      MqttLogger.log(
          'MqttConnectionBase::_onError - calling disconnected callback');
      onDisconnected();
    }
  }

  /// OnDone listener callback
  @protected
  void onDone() {
    _disconnect();
    if (onDisconnected != null) {
      MqttLogger.log(
          'MqttConnectionBase::_onDone - calling disconnected callback');
      onDisconnected();
    }
  }

  void _disconnect() {
    if (client != null) {
      client.destroy();
      client = null;
    }
  }

  /// User requested or auto disconnect disconnection
  @protected
  void disconnect({bool auto = false}) {
    if (auto) {
      _disconnect();
    } else {
      onDone();
    }
  }

  void send(MqttByteBuffer message);
}

mixin BaseConnection {
  void send(MqttByteBuffer message);
  void destroy();
}
