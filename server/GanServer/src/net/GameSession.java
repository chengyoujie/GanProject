package net;

import io.netty.channel.Channel;

public class GameSession {

	private Channel channel;
	public GameSession(Channel channel)
	{
		this.channel = channel;
		
	}
	
	public Channel getChannel()
	{
		return this.channel;
	}
	
	public void close()
	{
		
	}
	
}
