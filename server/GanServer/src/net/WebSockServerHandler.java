package net;

import java.io.ByteArrayInputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import net.protobuf.msg.PB_MSG;

import com.sun.xml.internal.messaging.saaj.util.ByteInputStream;
import com.sun.xml.internal.messaging.saaj.util.ByteOutputStream;

import server.GameServer;
import io.netty.buffer.ByteBuf;
import io.netty.channel.Channel;
import io.netty.channel.ChannelHandler;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.SimpleChannelInboundHandler;
import io.netty.handler.codec.http.websocketx.*;

public class WebSockServerHandler extends SimpleChannelInboundHandler<WebSocketFrame> {

	@Override
	protected void channelRead0(ChannelHandlerContext ctx, WebSocketFrame frame)
			throws Exception {
		// TODO Auto-generated method stub
		Channel ch = ctx.channel();
		if(frame instanceof TextWebSocketFrame)
		{
			TextWebSocketFrame txtframe = (TextWebSocketFrame)frame;
			String text = txtframe.text();
			System.out.println("获得数据："+text);
			ch.writeAndFlush(new TextWebSocketFrame(text));
		}else if(frame instanceof BinaryWebSocketFrame)
		{
			BinaryWebSocketFrame byteframe = (BinaryWebSocketFrame)frame;
			recv(byteframe.content(), ch);
		}else
		{
			String mess = "不支持的类型"+frame.getClass();
			throw new UnsupportedOperationException(mess);
		}
	}
	
	
	
	public void send(int cmd,byte[] bytes, GameSession s)
	{
		BinaryWebSocketFrame bws = new BinaryWebSocketFrame();
		bws.content().writeInt(cmd);
		bws.content().writeBytes(bytes);
		s.getChannel().writeAndFlush(bws);
	}
	
	@Override
	public void channelActive(ChannelHandlerContext ctx)
	{
		System.out.println("客户端连接成功");
		GameServer.session.addSession(ctx.channel());
	}
	
	@Override
	public void channelInactive(ChannelHandlerContext ctx) throws Exception
	{
		super.channelInactive(ctx);
		System.out.println("客户端断开连接");
		GameServer.session.removeSession(ctx.channel());
	}
	
	
	public void recv(ByteBuf buf, Channel channel)
	{
		
//		DataInputStream in = new DataInputStream(new ByteInputStream(bytes, bytes.length));
		PB_MSG.Move move = null;
		try {
			
			int cmd = buf.readInt();
//			byte[] bys = new byte[in.available()];
//			in.read(bys); 
			byte[] bytes = new byte[buf.readableBytes()];
			buf.readBytes(bytes);
			move = PB_MSG.Move.parseFrom(bytes);
			System.out.println("move x:"+move.getX()+" y:"+move.getY());
			
			GameSession s = GameServer.session.getSession(channel);
			if(s != null)
			{
				PB_MSG.Move.Builder builder = PB_MSG.Move.newBuilder();
				builder.setX(move.getX());
				builder.setY(move.getY());
				byte[] bs = builder.build().toByteArray();
				
				send(cmd, bs, s);
				
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
//			try {
//				in.close();
//			} catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
		}
		
	}
	
	


}
