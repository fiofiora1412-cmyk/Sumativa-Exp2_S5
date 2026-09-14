package com.bankbatch.duoc.config;

import com.bankbatch.duoc.model.Transaccion;
import com.bankbatch.duoc.model.TransaccionProcesada;
import com.bankbatch.duoc.processor.TransaccionProcessor;

import org.springframework.batch.core.job.Job;
import org.springframework.batch.core.job.builder.JobBuilder;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.Step;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.batch.infrastructure.item.ItemReader;
import org.springframework.batch.infrastructure.item.ItemWriter;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class TransaccionesBatchConfig {

    @Bean
    public Step procesarTransaccionesStep(
            JobRepository jobRepository,
            PlatformTransactionManager transactionManager,
            ItemReader<Transaccion> transaccionReader,
            TransaccionProcessor transaccionProcessor,
            ItemWriter<TransaccionProcesada> transaccionWriter,
            ThreadPoolTaskExecutor taskExecutor) {

        return new StepBuilder("procesarTransaccionesStep", jobRepository)
            .<Transaccion, TransaccionProcesada>chunk(10)
            .transactionManager(transactionManager)
            .reader(transaccionReader)
            .processor(transaccionProcessor)
            .writer(transaccionWriter)
            .faultTolerant()
            .skipPolicy(new PoliticaToleranciaFallos())
            .taskExecutor(taskExecutor)
            .build();
        }

    @Bean
    public Job procesarTransaccionesJob(
            JobRepository jobRepository,
            Step procesarTransaccionesStep) {

        return new JobBuilder("procesarTransaccionesJob", jobRepository)
                .start(procesarTransaccionesStep)
                .build();
    }
}