package com.bankbatch.duoc.reader;

import com.bankbatch.duoc.model.Transaccion;

import org.springframework.batch.infrastructure.item.ItemReader;
import org.springframework.batch.infrastructure.item.file.builder.FlatFileItemReaderBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

@Configuration
public class TransaccionReaderConfig {

    @Bean
    public ItemReader<Transaccion> transaccionReader() {

        return new FlatFileItemReaderBuilder<Transaccion>()
                .name("transaccionReader")
                .resource(new ClassPathResource("transacciones.csv"))
                .linesToSkip(1)
                .delimited()
                .names("id", "fecha", "monto", "tipo")
                .targetType(Transaccion.class)
                .build();
    }
}