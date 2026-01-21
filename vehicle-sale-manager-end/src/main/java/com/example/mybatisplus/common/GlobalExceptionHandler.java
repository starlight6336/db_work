package com.example.mybatisplus.common;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    public JsonResponse handleException(Exception e) {
        return JsonResponse.failure(e.getMessage());
    }
}
