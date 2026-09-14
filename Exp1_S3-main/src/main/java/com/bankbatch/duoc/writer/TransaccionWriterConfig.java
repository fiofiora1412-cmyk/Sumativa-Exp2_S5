package com.bankbatch.duoc.writer;

import com.bankbatch.duoc.model.TransaccionProcesada;

import javax.sql.DataSource;

import org.springframework.batch.infrastructure.item.database.JdbcBatchItemWriter;
import org.springframework.batch.infrastructure.item.database.builder.JdbcBatchItemWriterBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class TransaccionWriterConfig {

    @Bean
    public JdbcBatchItemWriter<TransaccionProcesada> transaccionWriter(
            DataSource dataSource) {

        return new JdbcBatchItemWriterBuilder<TransaccionProcesada>()
                .dataSource(dataSource)
                .sql("""
                    INSERT INTO transacciones_procesadas
                    (
                        transaccion_id,
                        fecha,
                        monto,
                        tipo,
                        es_anomalia,
                        motivo_anomalia
                    )
                    VALUES
                    (
                        :transaccionId,
                        :fecha,
                        :monto,
                        :tipo,
                        :esAnomalia,
                        :motivoAnomalia
                    )
                    """)
                .beanMapped()
                .build();
    }
}