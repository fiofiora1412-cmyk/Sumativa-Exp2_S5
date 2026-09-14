package com.bankbatch.duoc.config;

import com.bankbatch.duoc.model.Interes;
import com.bankbatch.duoc.processor.InteresesProcessor;

import org.springframework.batch.core.job.Job;
import org.springframework.batch.core.job.builder.JobBuilder;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.Step;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.batch.infrastructure.item.ItemReader;
import org.springframework.batch.infrastructure.item.ItemWriter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.task.AsyncTaskExecutor;
import org.springframework.core.task.SimpleAsyncTaskExecutor;
import org.springframework.transaction.PlatformTransactionManager;

@Configuration
public class InteresesBatchConfig {

    @Bean
    public AsyncTaskExecutor interesesTaskExecutor() {

        SimpleAsyncTaskExecutor executor =
                new SimpleAsyncTaskExecutor("intereses-");

        executor.setConcurrencyLimit(4);

        return executor;
    }

    @Bean
    public Step procesarInteresesStep(
            JobRepository jobRepository,
            PlatformTransactionManager transactionManager,
            ItemReader<Interes> interesesReader,
            InteresesProcessor interesesProcessor,
            ItemWriter<Interes> interesesWriter,
            AsyncTaskExecutor interesesTaskExecutor) {

        return new StepBuilder("procesarInteresesStep", jobRepository)
                .<Interes, Interes>chunk(10)
                .transactionManager(transactionManager)
                .reader(interesesReader)
                .processor(interesesProcessor)
                .writer(interesesWriter)
                .taskExecutor(interesesTaskExecutor)
                .build();
    }

    @Bean
    public Job procesarInteresesJob(
            JobRepository jobRepository,
            Step procesarInteresesStep) {

        return new JobBuilder("procesarInteresesJob", jobRepository)
                .start(procesarInteresesStep)
                .build();
    }
}