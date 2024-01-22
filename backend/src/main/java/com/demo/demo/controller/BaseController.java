package com.demo.demo.controller;

import com.demo.demo.dto.ProgressData;
import com.demo.demo.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@RestController
public class BaseController {

    @Autowired
    private BaseService service;

    @GetMapping(value = "/api/get", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity getAllApplicantsDetails(){
        return service.getAllApplicantList();
    }

    @GetMapping(value = "/api/get-work-steps", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity fetchWorkSteps(){
        return service.fetchWorkSteps();
    }

    @GetMapping(value = "/api/get-billing-status", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity fetchBillingStatus(){
        return service.fetchBillingStatus();
    }

    @PostMapping(value = "/api/update-status", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity updateWorkStatus(@RequestParam(value = "files", required = false) MultipartFile[] files, @ModelAttribute ProgressData data){
       return service.updateProjectStatus(data, files);
    }
}
