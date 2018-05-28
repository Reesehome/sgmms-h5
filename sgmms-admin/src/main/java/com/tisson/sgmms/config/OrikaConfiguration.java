package com.tisson.sgmms.config;

import ma.glasnost.orika.MapperFactory;
import ma.glasnost.orika.impl.DefaultMapperFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OrikaConfiguration {

    @Bean
    public MapperFactory mapperFactory() {
        DefaultMapperFactory.Builder builder = new DefaultMapperFactory.Builder();
        builder.mapNulls(false).useAutoMapping(true);
        return builder.build();
    }
}
