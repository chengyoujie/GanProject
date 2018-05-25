package net;

import io.netty.channel.ChannelHandler;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelPipeline;
import io.netty.channel.socket.SocketChannel;
import io.netty.handler.codec.http.HttpObjectAggregator;
import io.netty.handler.codec.http.HttpServerCodec;
import io.netty.handler.codec.http.websocketx.WebSocketFrame;
import io.netty.handler.codec.http.websocketx.WebSocketServerProtocolHandler;

public class WebChannelIntalizer extends ChannelInitializer<SocketChannel>{

	public WebChannelIntalizer()
	{
	}
	
	@Override
	protected void initChannel(SocketChannel arg0) throws Exception {
		// TODO Auto-generated method stub
		ChannelPipeline channel = arg0.pipeline();
		channel.addLast(new HttpServerCodec());
		channel.addLast(new HttpObjectAggregator(64*1024));
		channel.addLast(new WebSocketServerProtocolHandler("/ws", null));
		channel.addLast(new WebSockServerHandler());
		
	}
}
