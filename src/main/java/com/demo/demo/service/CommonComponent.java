package com.demo.demo.service;

import com.demo.demo.model.ResponseDto;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

@Component
public class CommonComponent {

    public ResponseEntity<ResponseDto> success(String msg, Object obj) {
        return new ResponseEntity<>(
                new ResponseDto<>(
                        msg,
                        obj
                ),
                HttpStatus.OK
        );
    }

    public ResponseEntity<ResponseDto> error(String msg, Object obj) {
        return new ResponseEntity<>(
                new ResponseDto<>(
                        msg,
                        obj
                ),
                HttpStatus.INTERNAL_SERVER_ERROR
        );
    }
}
