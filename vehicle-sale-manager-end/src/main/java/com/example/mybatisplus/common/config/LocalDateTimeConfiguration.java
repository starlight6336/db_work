package com.example.mybatisplus.common.config;

import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateDeserializer;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateSerializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.jackson.Jackson2ObjectMapperBuilderCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Configuration
public class LocalDateTimeConfiguration {

    @Value("${spring.jackson.date-format:yyyy-MM-dd HH:mm:ss}")
    private String pattern;

//    @Value("${spring.jackson.date-format:yyyy-MM-dd}")
//    private String pattern2;

    @Bean
    public Jackson2ObjectMapperBuilderCustomizer jackson2ObjectMapperBuilderCustomizer() {
        return builder -> {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern(pattern);

            //返回时间数据序列化
            builder.serializerByType(LocalDateTime.class, new LocalDateTimeSerializer(formatter));
            //接收时间数据反序列化
            builder.deserializerByType(LocalDateTime.class, new LocalDateTimeDeserializer(formatter));

//            formatter = DateTimeFormatter.ofPattern(pattern2);
//
//            // 返回时间数据序列化
//            builder.serializerByType(LocalDate.class, new LocalDateSerializer(formatter));
//            // 接受时间数据反序列化
//            builder.deserializerByType(LocalDate.class, new LocalDateDeserializer(formatter));
//            builder.deserializers(new LocalDateDeserializer(formatter));
//            builder.serializers(new LocalDateSerializer(formatter));
        };
    }

}
