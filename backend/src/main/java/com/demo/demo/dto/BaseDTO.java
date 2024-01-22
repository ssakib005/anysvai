package com.demo.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BaseDTO {
    private Long id;
    private String applicantName;
    private String nidNo;
    private String mobileNo;
    private String freedomFighterName;
    private String fatherName;
    private String village;
    private String upazila;
    private String district;
    private String division;
    private String indianList;
    private String redLightRelease;
    private String govtCivilGadgetNo;
    private String misNo;
    private String landDetails;
    private String landLocation;
    private List<ProjectProgressDTO> projectProgressDTOS;
}
