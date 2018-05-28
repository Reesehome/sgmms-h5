package com.tisson.sgmms.meetings.vo;

import java.io.Serializable;

/**
 * @author hasee.
 * @time 2018/5/11 11:20.
 * @description
 */
public class CommonVO implements Serializable {

    /**
     * 数据
     */
    private Object data;

    /**
     * 结果
     */
    private boolean result;

    /**
     * 提示文本
     */
    private String msg;

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public boolean isResult() {
        return result;
    }

    public void setResult(boolean result) {
        this.result = result;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    @Override
    public String toString() {
        return "CommonVO{" +
                "data=" + data +
                ", result=" + result +
                ", msg='" + msg + '\'' +
                '}';
    }
}
