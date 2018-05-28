package com.tisson.sgmms.meetings.service.impl;

import com.tisson.sgmms.meetings.constants.MeetingsConstants;
import com.tisson.sgmms.meetings.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

/**
 * @author hasee.
 * @time 2018/5/22 10:36.
 * @description
 */
@Service
public class FileServiceImpl implements FileService {

    @Autowired
    private HttpServletRequest request;

    @Override
    public String saveFileToLocal(MultipartFile file, String type, String meetingsId) throws IOException {
        String folder = "normal";
        switch (type) {
            case MeetingsConstants.UPLOAD_TYPE_ATTACH:
                folder = MeetingsConstants.UPLOAD_TYPE_ATTACH;
                break;
            case MeetingsConstants.UPLOAD_TYPE_EDITOR:
                folder = MeetingsConstants.UPLOAD_TYPE_EDITOR;
                break;
            default:
        }
        String path = "upload/" + folder + "/" + meetingsId + "/" + file.getOriginalFilename();
        String fullPath = request.getSession().getServletContext().getRealPath("/") + path;
        this.createDir(fullPath);
        file.transferTo(new File(fullPath));
        return request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getSession().getServletContext().getContextPath() + "/" + path;
    }

    @Override
    public boolean delFileForLocal(String fileName, String type, String meetingsId) throws IOException {
        String folder = "normal";
        switch (type) {
            case MeetingsConstants.UPLOAD_TYPE_ATTACH:
                folder = MeetingsConstants.UPLOAD_TYPE_ATTACH;
                break;
            case MeetingsConstants.UPLOAD_TYPE_EDITOR:
                folder = MeetingsConstants.UPLOAD_TYPE_EDITOR;
                break;
            default:
        }
        String filePath = request.getSession().getServletContext().getRealPath("/") + "upload/" + folder + "/" + meetingsId + "/" + fileName;
        File file = new File(filePath);
        return file.delete();
    }

    private boolean createFile(String destFileName) {
        File file = new File(destFileName);
        if (file.exists()) {
            System.out.println("创建单个文件" + destFileName + "失败，目标文件已存在！");
            return false;
        }
        if (destFileName.endsWith(File.separator)) {
            System.out.println("创建单个文件" + destFileName + "失败，目标文件不能为目录！");
            return false;
        }
        //判断目标文件所在的目录是否存在  
        if (!file.getParentFile().exists()) {
            //如果目标文件所在的目录不存在，则创建父目录  
            System.out.println("目标文件所在目录不存在，准备创建它！");
            if (!file.getParentFile().mkdirs()) {
                System.out.println("创建目标文件所在目录失败！");
                return false;
            }
        }
        //创建目标文件  
        try {
            if (file.createNewFile()) {
                System.out.println("创建单个文件" + destFileName + "成功！");
                return true;
            } else {
                System.out.println("创建单个文件" + destFileName + "失败！");
                return false;
            }
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("创建单个文件" + destFileName + "失败！" + e.getMessage());
            return false;
        }
    }


    private boolean createDir(String destDirName) {
        File dir = new File(destDirName);
        if (dir.exists()) {
            System.out.println("创建目录" + destDirName + "失败，目标目录已经存在");
            return false;
        }
        if (!destDirName.endsWith(File.separator)) {
            destDirName = destDirName + File.separator;
        }
        //创建目录  
        if (dir.mkdirs()) {
            System.out.println("创建目录" + destDirName + "成功！");
            return true;
        } else {
            System.out.println("创建目录" + destDirName + "失败！");
            return false;
        }
    }


    private String createTempFile(String prefix, String suffix, String dirName) {
        File tempFile = null;
        if (dirName == null) {
            try {
                //在默认文件夹下创建临时文件  
                tempFile = File.createTempFile(prefix, suffix);
                //返回临时文件的路径  
                return tempFile.getCanonicalPath();
            } catch (IOException e) {
                e.printStackTrace();
                System.out.println("创建临时文件失败！" + e.getMessage());
                return null;
            }
        } else {
            File dir = new File(dirName);
            //如果临时文件所在目录不存在，首先创建  
            if (!dir.exists()) {
                if (!this.createDir(dirName)) {
                    System.out.println("创建临时文件失败，不能创建临时文件所在的目录！");
                    return null;
                }
            }
            try {
                //在指定目录下创建临时文件  
                tempFile = File.createTempFile(prefix, suffix, dir);
                return tempFile.getCanonicalPath();
            } catch (IOException e) {
                e.printStackTrace();
                System.out.println("创建临时文件失败！" + e.getMessage());
                return null;
            }
        }
    }

    /*private void main(String[] args) {
        //创建目录  
        String dirName = "D:/work/temp/temp0/temp1";
        this.createDir(dirName);
        //创建文件  
        String fileName = dirName + "/temp2/tempFile.txt";
        this.createFile(fileName);
        //创建临时文件  
        String prefix = "temp";
        String suffix = ".txt";
        for (int i = 0; i < 10; i++) {
            System.out.println("创建了临时文件："
                    + this.createTempFile(prefix, suffix, dirName));
        }
        //在默认目录下创建临时文件  
        for (int i = 0; i < 10; i++) {
            System.out.println("在默认目录下创建了临时文件："
                    + this.createTempFile(prefix, suffix, null));
        }
    }*/
}
