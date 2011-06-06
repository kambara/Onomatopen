package onomatopen
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.utils.setTimeout;
	
	public class JulianSocket extends Socket
	{
		private var host:String;
		private var port:uint;
		private var challengeCount:uint = 10;
		
		public function JulianSocket(host:String = "localhost", port:uint = 10500)
		{
			super();
			this.host = host;
			this.port = port;
			configure();
			reconnect();
		}
		
		private function reconnect():void {
			if (challengeCount <= 0) {
				dispatchEvent(new Event("stop_challenge"));
				return;
			}
			challengeCount--;
			dispatchEvent(new Event("connecting"));
			connect(host, port);
		}
		
		private function configure():void {
			addEventListener(Event.CONNECT, function(event:Event):void {
				trace(event.type);
				challengeCount = 10;
			});
			addEventListener(Event.CLOSE, function(event:Event):void {
				trace(event.type);
				waitAndTryConnecting();
			});
			addEventListener(IOErrorEvent.IO_ERROR, function(event:Event):void {
				trace(event.type);
				waitAndTryConnecting();
			});
			addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
		}
		
		private function waitAndTryConnecting():void {
			setTimeout(reconnect, 3000);
		}
		
		private function onSocketData(event:ProgressEvent):void {
			var data:String = Socket(event.target).readUTFBytes(event.bytesLoaded);
			//trace(data);
			
			var lines:Array = data.split("\n");
			for each (var line:String in lines) {
				// <WHYPO WORD="moko" > などにマッチ. WORD="<s>" や "<sp>" にはマッチしない.
				var m:Array = line.match(/<WHYPO WORD="([^<>\"]+)".*>/);
				if (m && m.length >= 2 && m[1].length > 0) {
					var word:String = m[1];
					//trace(word);
					dispatchEvent(new JulianSocketEvent(JulianSocketEvent.WORD, word));
				}
			}
		}
	}
}