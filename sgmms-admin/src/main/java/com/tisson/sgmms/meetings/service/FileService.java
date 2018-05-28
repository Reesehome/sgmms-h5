package com.tisson.sgmms.meetings.service;

import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

/**
 * @author hasee.
 * @time 2018/5/22 10:30.
 * @description
 */
public interface FileService {

    /**
     * 保存文件到本地
     *
     * @param file
     * @return
     */
    String saveFileToLocal(MultipartFile file, String type, String meetingsId) throws IOException;

    /**
     * 删除本地文件
     *
     * @param file
     * @param type
     * @param meetingsId
     * @return
     * @throws IOException
     */
    boolean delFileForLocal(String file, String type, String meetingsId) throws IOException;

}
