package com.bankbatch.duoc.config;

import com.bankbatch.duoc.model.Interes;

import org.springframework.batch.infrastructure.item.ItemReader;
import org.springframework.batch.infrastructure.item.file.FlatFileItemReader;
import org.springframework.batch.infrastructure.item.file.mapping.BeanWrapperFieldSetMapper;
import org.springframework.batch.infrastructure.item.file.mapping.DefaultLineMapper;
import org.springframework.batch.infrastructure.item.file.transform.DelimitedLineTokenizer;
import org.springframework.batch.infrastructure.item.support.SynchronizedItemStreamReader;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

@Configuration
public class InteresesReaderConfig {

    @Bean
    public ItemReader<Interes> interesesReader() {

        DelimitedLineTokenizer tokenizer = new DelimitedLineTokenizer();

        tokenizer.setDelimiter(",");
        tokenizer.setNames(
                "cuentaId",
                "nombre",
                "saldo",
                "edad",
                "tipo"
        );

        BeanWrapperFieldSetMapper<Interes> fieldSetMapper =
                new BeanWrapperFieldSetMapper<>();

        fieldSetMapper.setTargetType(Interes.class);

        DefaultLineMapper<Interes> lineMapper = new DefaultLineMapper<>();

        lineMapper.setLineTokenizer(tokenizer);
        lineMapper.setFieldSetMapper(fieldSetMapper);

        FlatFileItemReader<Interes> reader =
                new FlatFileItemReader<>(
                        new ClassPathResource("intereses.csv"),
                        lineMapper
                );

        reader.setLinesToSkip(1);

        SynchronizedItemStreamReader<Interes> synchronizedReader =
                new SynchronizedItemStreamReader<>(reader);

        return synchronizedReader;
    }
}