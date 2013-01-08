/**
 * Copyright (c) 2007 Gabriel Handford
 * See LICENSE.txt for full license information.
 */
package org.httpclient.io {
  import flash.utils.ByteArray;

  public class HttpRequestBuffer {

    private var _body:*;

    private var _bytesSent:uint = 0;

    private var _buff:ByteArray;

    private static const BLOCK_SIZE:uint = 16 * 1024;

    /**
     * Create request buffer.
     */
    public function HttpRequestBuffer(body:*) {
      _body = body;
      _buff = new ByteArray();
    }

    public function get bytesSent():uint { return _bytesSent; }

    public function get hasData():Boolean {
      if (!_body) return false;
      return _bytesSent < _body.length;
    }

    /**
     * Get data for request body.
     * @return Bytes, or null if end was reached.
     */
    public function read():ByteArray {
      if (_body.bytesAvailable > 0) {
        var length:uint = _body.bytesAvailable < BLOCK_SIZE ? _body.bytesAvailable : BLOCK_SIZE;
        _buff.length = length;
        _body.readBytes(_buff, 0, length);
        _buff.position = 0;
        _bytesSent += length;
      } else
        _buff.length = 0;

      return _buff;
    }


  }
}
