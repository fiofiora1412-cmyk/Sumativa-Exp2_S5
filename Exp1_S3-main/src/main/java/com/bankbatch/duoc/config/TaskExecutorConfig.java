package com.bankbatch.duoc.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

@Configuration
public class TaskExecutorConfig {

    @Bean
    public ThreadPoolTaskExecutor taskExecutor() {

        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();

        executor.setCorePoolSize(1);
        executor.setMaxPoolSize(1);
        executor.setQueueCapacity(10);
        executor.setThreadNamePrefix("batch-thread-");

        executor.initialize();

        return executor;
    }
}