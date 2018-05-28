package com.tisson.sgmms.config;

import com.tisson.sgmms.thirdparty.daemon.SendMessageThreadManager;
import org.apache.http.conn.HttpClientConnectionManager;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class HttpClientConfiguration {

    @Bean(destroyMethod = "close")
    public CloseableHttpClient httpClient() {
        return HttpClients.createMinimal(connectionManager());
    }

    @Bean
    public HttpClientConnectionManager connectionManager() {
        //PoolingHttpClientConnectionManager
        PoolingHttpClientConnectionManager connectionManager = new PoolingHttpClientConnectionManager();
        connectionManager.setDefaultMaxPerRoute(100);
        connectionManager.setMaxTotal(100);
        return connectionManager;
    }
}
