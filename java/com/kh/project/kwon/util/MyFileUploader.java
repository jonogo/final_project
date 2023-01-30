package com.kh.project.kwon.util;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.util.FileCopyUtils;

public class MyFileUploader {
	public final static String UPLOAD_PATH = "//192.168.0.219/board_2/";
	
	public static String uploadFile(
			String originalFilename,
			byte[] fileData) {
		UUID uuid = UUID.randomUUID();
		String savaFilename = uuid
				+ "_" + originalFilename;
		System.out.println("saveFliename: " + savaFilename);
		File target = new File(UPLOAD_PATH + savaFilename);
		try {
			FileCopyUtils.copy(fileData, target);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return savaFilename;
	}
}
