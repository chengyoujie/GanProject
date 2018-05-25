package net;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;

import com.exadel.flamingo.flex.messaging.amf.io.AMF3Deserializer;
import com.exadel.flamingo.flex.messaging.amf.io.AMF3Serializer;


public class AMFUtils {

	public static byte[] parser2Byte(int msg, Object obj)
	{
		ByteArrayOutputStream dos = new ByteArrayOutputStream();
		AMF3Serializer amf = new AMF3Serializer(dos);
		byte[] out = null;
		try {
			amf.writeInt(msg);
			amf.writeObject(obj);
			amf.flush();
			out = dos.toByteArray();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				dos.close();
				amf.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return out;
	}
	
	
	public static Object pasrser2Object(byte[] bytes)
	{
		ByteArrayInputStream bis = new ByteArrayInputStream(bytes);
		AMF3Deserializer amf = new AMF3Deserializer(bis);
		Object obj=null;
		try {
			int cmd = amf.readInt();
			obj = amf.readObject();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				bis.close();
				amf.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return obj;
	}
	
}
