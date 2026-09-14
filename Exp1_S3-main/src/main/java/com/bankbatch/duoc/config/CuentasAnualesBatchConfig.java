package com.bankbatch.duoc.config;

import com.bankbatch.duoc.model.CuentaAnual;
import com.bankbatch.duoc.processor.CuentasAnualesProcessor;

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
public class CuentasAnualesBatchConfig {

    @Bean
    public AsyncTaskExecutor cuentasAnualesTaskExecutor() {

        SimpleAsyncTaskExecutor executor =
                new SimpleAsyncTaskExecutor("cuentas-anuales-");

        executor.setConcurrencyLimit(4);

        return executor;
    }

    @Bean
    public Step procesarCuentasAnualesStep(
            JobRepository jobRepository,
            PlatformTransactionManager transactionManager,
            ItemReader<CuentaAnual> cuentasAnualesReader,
            CuentasAnualesProcessor cuentasAnualesProcessor,
            ItemWriter<CuentaAnual> cuentasAnualesWriter,
            AsyncTaskExecutor cuentasAnualesTaskExecutor) {

        return new StepBuilder("procesarCuentasAnualesStep", jobRepository)
                .<CuentaAnual, CuentaAnual>chunk(10)
                .transactionManager(transactionManager)
                .reader(cuentasAnualesReader)
                .processor(cuentasAnualesProcessor)
                .writer(cuentasAnualesWriter)
                .taskExecutor(cuentasAnualesTaskExecutor)
                .build();
    }

    @Bean
    public Job procesarCuentasAnualesJob(
            JobRepository jobRepository,
            Step procesarCuentasAnualesStep) {

        return new JobBuilder("procesarCuentasAnualesJob", jobRepository)
                .start(procesarCuentasAnualesStep)
                .build();
    }
}