package data;

import java.io.File;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;


public class GameConfig {
	
	public int port;
	
	public boolean load(String fileName)
	{
		String cfgPath = ClassLoader.getSystemResource("").getFile()+"config/"+fileName;
		File cfgFile = new File(cfgPath);
		if(cfgFile.exists() == false)
		{
			throw new Error("”Œœ∑≈‰÷√¬∑æ∂¥ÌŒÛ£¨«ÎºÏ≤È");
//			return false;
		}
		readConfigFile(cfgFile);
		return true;
	}
	
	
	public void readConfigFile(File cfgFile)
	{
		SAXReader reader = new SAXReader();
		Document doc;
		Element root;
		try {
			doc = reader.read(cfgFile);
			root = doc.getRootElement();
			System.out.println(root.getName());
			port = Integer.parseInt(root.element("info").attribute("port").getValue());
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		
	}
}
