package com.tisson.sgmms.api.security;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>JSON Web Token</p>
 *
 * @author zhuzhiou
 */
@JsonNaming(PropertyNamingStrategy.LowerCaseWithUnderscoresStrategy.class)
public class AccessToken implements Serializable {

    private Date expiration;

    private String value;

    @JsonCreator
    public AccessToken(
            @JsonProperty("access_tocken") String access_tocken,
            @JsonProperty("expires_in") int expires_in) {
        this.value = access_tocken;
        this.expiration = new Date(System.currentTimeMillis() + (expires_in * 1000));
    }

    @JsonProperty("expires_in")
    public int getExpiresIn() {
        return expiration != null ? Long.valueOf((expiration.getTime() - System.currentTimeMillis()) / 1000L).intValue() : 0;
    }

    @JsonProperty("access_token")
    public String getValue() {
        return value;
    }

    @JsonIgnore
    public Date getExpiration() {
        return expiration;
    }
}
