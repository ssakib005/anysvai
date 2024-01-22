package com.demo.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProgressData {
    private int mstId;
    private String workSteps;
    private String details;
    private String billingStatus;
}
