package cn.apple.util;


import org.springframework.util.FileCopyUtils;

import java.io.*;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Stream;

/**
 * Created by THINK on 2016/3/17.
 */
public class CityInfo {
	public static StringBuilder  appender(StringBuilder sb,String key,Map<String,String[]> sorted){
		String[] words = sorted.get(key);
		if(words==null){
			return sb;
		}
		if(sb.length()==0){
			sb.append(words[4])
			.append(",").append(words[5]);
		}
		sb.append(",").append(words[0]);
		sb.append(",").append(words[1]);
		if (!"0".equals(words[2])){
			return appender(sb,words[2],sorted);
		}else {
			return sb;
		}
	}
	public static void main(String[] args) throws Exception {

		String fileName = "d:/cityinfo.txt";
		Map<String,String[]> sorted=new HashMap<>();
		//read file into stream, try-with-resources
		try (Stream<String> stream = Files.lines(Paths.get(fileName), Charset.forName("GBK"))) {

			stream.forEach(x->{
				String[] words = x.split(",");
				sorted.put(words[0].trim(),words);
			});

		} catch (IOException e) {
			e.printStackTrace();
		}
		StringWriter sw=new StringWriter();
		for (String s : sorted.keySet()) {
			if(s.length()>6){
				sw.append(appender(new StringBuilder(),s,sorted)).append("\n");
			}
		}
		FileCopyUtils.copy(sw.toString(),new FileWriter(new File("d:/tablecity.txt")));
	}
}
