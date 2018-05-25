package net;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;

import com.sun.xml.internal.messaging.saaj.util.ByteInputStream;

import io.netty.bootstrap.ServerBootstrap;
import io.netty.buffer.ByteBuf;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.nio.NioServerSocketChannel;
import io.netty.channel.ChannelOption;
import io.netty.channel.ChannelFuture;

public class NetServer {
	private int _port;
	private ServerBootstrap server;
//	private WebSockServerHandler handle;
	public void start(int port)
	{
		_port = port;
		EventLoopGroup bossEvent = new NioEventLoopGroup();
		EventLoopGroup workEvent = new NioEventLoopGroup();
		server = new ServerBootstrap();
		server.group(bossEvent, workEvent);
//		handle = new WebSockServerHandler();
		server.childHandler(new WebChannelIntalizer());
		server.channel(NioServerSocketChannel.class);
		server.option(ChannelOption.SO_BACKLOG, 128);
		server.childOption(ChannelOption.SO_KEEPALIVE, true);
		ChannelFuture f;
		try {
			f = server.bind(_port).sync();
			f.channel().closeFuture().sync();
			
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			bossEvent.shutdownGracefully();
			workEvent.shutdownGracefully();
			
		}
		System.out.println("服务器  端口"+port+"开启");
	}
	
	
	
	
}
