package com.demo.demo.model;


import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class ResponseDto<T> implements Serializable {
    @JsonProperty("message")
    private String message;
    @JsonProperty("data")
    private T payload;
}
