package net;

import io.netty.channel.Channel;

import java.net.InetSocketAddress;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

public class GameSessionManager {
	private ConcurrentMap<Channel, GameSession> sessionMap = new ConcurrentHashMap<>();
	
	
	public void addSession(Channel channel)
	{
		if(sessionMap.containsKey(channel))
		{
			System.out.println("当前Session已经存在");
			sessionMap.get(channel).close();
			sessionMap.remove(channel);
		}
//		String ip = ((InetSocketAddress)channel.remoteAddress()).getAddress().getHostAddress();
		GameSession session = new GameSession(channel);
		sessionMap.put(channel, session);
	}
	
	
	public void removeSession(Channel channel)
	{
		if(sessionMap.containsKey(channel))
		{
			sessionMap.get(channel).close();
			sessionMap.remove(channel);
		}
	}
	
	public GameSession getSession(Channel channel)
	{
		if(sessionMap.containsKey(channel))
		{
			return sessionMap.get(channel);
		}
		return null;
	}
	
	public int onlineNum()
	{
		return sessionMap.size();
	}
	
}
