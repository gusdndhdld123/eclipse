package com.com.com.Config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.com.com.DTO.PageInfo;

@Configuration
public class AppConfig {

    @Bean
    public PageInfo pageInfo() {
        return new PageInfo(0,0,0);  
    }
}
