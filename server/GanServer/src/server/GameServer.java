package server;
import net.GameSessionManager;
import net.NetServer;
import data.GameConfig;


public class GameServer {
	
	public static GameConfig config;
	public static NetServer server;
	public static GameSessionManager session=new GameSessionManager();
	
	public static void main(String[] args) {
		System.out.println("------Game Server 开始启动 -------");
		config = new GameConfig();
		config.load("game-config.xml");
		
		server = new NetServer(); 
		server.start(config.port);
		
		System.out.println("------Game Server 启动完成 -------");
	}
}
