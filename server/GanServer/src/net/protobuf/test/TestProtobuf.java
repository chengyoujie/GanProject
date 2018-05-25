package net.protobuf.test;

import com.google.protobuf.InvalidProtocolBufferException;

import net.protobuf.test.Testgps.gps_data;

public class TestProtobuf {
	public static void main(String[] args) {
		Testgps.gps_data.Builder builder = Testgps.gps_data.newBuilder();
		builder.setAltitude(1222);
		builder.setDataTime("2018-05-23 11:45:00");
		builder.setDirection(100L);
		builder.setLat(12.11);
		builder.setLon(121.11);
		builder.setId(1);
		
		Testgps.gps_data gpsdata = builder.build();
		System.out.println(gpsdata.toString());
		
		byte[] bs = gpsdata.toByteArray();
		for(byte b : bs)
			System.out.print(b);
		Testgps.gps_data gps = null;
		try{
			gps = Testgps.gps_data.parseFrom(bs);
		}catch(InvalidProtocolBufferException e){
			e.printStackTrace();
		}
		System.out.println("----------∑¥–Ú¡–ªØ---------");
		System.out.println(gps.toString());
	}
}
