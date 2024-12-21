package com.boot.common.core.exception;

import lombok.Getter;

/**
 * 自定义异常
 *
 * @author boot
 */
public class CustomException extends RuntimeException {
    private static final long serialVersionUID = 1L;
    @Getter
    private Integer code;
    @Getter
    private String message;

    public CustomException(String message) {
        this.message = message;
    }

    public CustomException(String message, Integer code) {
        this.message = message;
        this.code = code;
    }

    public CustomException(String message, Throwable e) {
        super(message, e);
        this.message = message;
    }
}
