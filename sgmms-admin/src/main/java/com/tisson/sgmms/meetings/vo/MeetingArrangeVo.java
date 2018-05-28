package com.tisson.sgmms.meetings.vo;

import com.tisson.sgmms.meetings.entity.MmsConferenceDetailEntity;
import org.springframework.beans.BeanUtils;

import java.io.Serializable;

/**
 * @author hasee.
 * @time 2018/5/16 16:53.
 * @description
 */
public class MeetingArrangeVo implements Serializable {

    private String conferenceId;
    private String agendum;
    private String attention;

    public String getConferenceId() {
        return conferenceId;
    }

    public void setConferenceId(String conferenceId) {
        this.conferenceId = conferenceId;
    }

    public String getAgendum() {
        return agendum;
    }

    public void setAgendum(String agendum) {
        this.agendum = agendum;
    }

    public String getAttention() {
        return attention;
    }

    public void setAttention(String attention) {
        this.attention = attention;
    }

    /**
     * 转换实体为vo对象
     *
     * @param entity
     */
    public MeetingArrangeVo buildVo(MmsConferenceDetailEntity entity) {
        BeanUtils.copyProperties(entity, this);
        return this;
    }


    @Override
    public String toString() {
        return "MeetingArrangeVo{" +
                "conferenceId='" + conferenceId + '\'' +
                ", agendum='" + agendum + '\'' +
                ", attention='" + attention + '\'' +
                '}';
    }
}
