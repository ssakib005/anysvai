package com.demo.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProjectProgressDTO {
    private Long id;
    private String details;
    private String submittedDae;
    private String workStep;
    private String billingStatus;
    private List<String> images;
}
