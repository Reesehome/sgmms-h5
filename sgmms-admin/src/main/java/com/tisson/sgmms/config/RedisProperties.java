package com.tisson.sgmms.config;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

import static org.apache.commons.lang3.StringUtils.isNotBlank;

@Component
@PropertySource("classpath:/redis.properties")
public class RedisProperties implements InitializingBean {

    private int database = 0;

    private String host = "localhost";

    private String password;

    private int port = 6379;

    private int timeout;

    public int getDatabase() {
        return database;
    }

    public void setDatabase(int database) {
        this.database = database;
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getPort() {
        return port;
    }

    public void setPort(int port) {
        this.port = port;
    }

    public int getTimeout() {
        return timeout;
    }

    public void setTimeout(int timeout) {
        this.timeout = timeout;
    }

    @Autowired
    private Environment environment;

    @Override
    public void afterPropertiesSet() throws Exception {
        Integer database = environment.getProperty("redis.database", Integer.class);
        if (database != null && database.intValue() > 0) {
            this.setDatabase(database);
        }
        String host = environment.getProperty("redis.host", String.class);
        if (isNotBlank(host)) {
            this.setHost(host);
        }
        Integer port = environment.getProperty("redis.port", Integer.class);
        if (port != null && port.intValue() > 0) {
            this.setPort(port);
        }
        String password = environment.getProperty("redis.password", String.class);
        if (isNotBlank(password)) {
            this.setPassword(password);
        }
        Integer timeout = environment.getProperty("redis.timeout", Integer.class);
        if (timeout != null && timeout.intValue() > 0) {
            this.setTimeout(timeout);
        }
    }
}
