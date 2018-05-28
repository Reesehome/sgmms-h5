package com.tisson.sgmms.meetings.constants;

/**
 * @author hasee.
 * @time 2018/5/11 10:43.
 * @description
 */
public class MeetingsConstants {

    /*会议记录是否已禁用*/
    public static final String MEETINGS_ENABLED_Y = "Y";
    public static final String MEETINGS_ENABLED_N = "N";

    /*会议状态*/
    public static final String MEETINGS_STATUS_UNSTART = "UNSTART";
    public static final String MEETINGS_STATUS_STARTED = "STARTED";
    public static final String MEETINGS_STATUS_ENDED = "ENDED";

    /*上传文件类型*/
    public static final String UPLOAD_TYPE_EDITOR = "editor";
    public static final String UPLOAD_TYPE_ATTACH = "attach";
    public static final Long UPLOAD_FILE_SIZE_ATTACH = 31457280L;
    public static final Long UPLOAD_FILE_SIZE_EDITOR = 5242880L;
}
