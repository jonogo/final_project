package com.kh.project.kim.util;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.util.FileCopyUtils;

public class MyFileUploader {
	public static final String UPLOAD_PATH = "//192.168.0.219/board_2/";
	
	public static String uploadFile(String originalFilename,
			byte[] fileData) {
		UUID uuid = UUID.randomUUID();
		String saveFilename = UPLOAD_PATH
				+ uuid + "_" + originalFilename;
		System.out.println("saveFilename:" + saveFilename);
		File target = new File(saveFilename);
		try {
			FileCopyUtils.copy(fileData, target);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return saveFilename;
	}
}
