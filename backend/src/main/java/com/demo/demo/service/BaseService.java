package com.demo.demo.service;

import com.demo.demo.dto.BaseDTO;
import com.demo.demo.dto.DropdownDTO;
import com.demo.demo.dto.ProgressData;
import com.demo.demo.dto.ProjectProgressDTO;
import com.demo.demo.model.BillingStatus;
import com.demo.demo.model.ProjectImages;
import com.demo.demo.model.ProjectProgress;
import com.demo.demo.model.WorkSteps;
import com.demo.demo.repo.MasterTableRepo;
import com.demo.demo.repo.ProjectImagesRepo;
import com.demo.demo.repo.ProjectProgressRepo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
public class BaseService extends CommonComponent {

    @Autowired
    private MasterTableRepo repo;
    @Autowired
    private ProjectProgressRepo progressRepo;
    @Autowired
    private ProjectImagesRepo imagesRepo;

    @Value("${files.documents}")
    private String docFilePath;

    public ResponseEntity getAllApplicantList() {
        var response = repo.findAll().stream().map(x -> {
            var dto = new BaseDTO();
            BeanUtils.copyProperties(x, dto);
            dto.setDivision(x.getDivision().getName());
            dto.setDistrict(x.getDistrict().getName());

            var progress = x.getProjectProgresses().stream().map(y -> {
                var pDto = new ProjectProgressDTO();
                pDto.setId(y.getId());
                pDto.setBillingStatus(y.getBillingStatus().name());
                pDto.setDetails(y.getDetails());
                pDto.setSubmittedDae(y.getSubmittedDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm a")));
                pDto.setWorkStep(y.getWorkSteps().name());
                pDto.setImages(y.getProjectImages().stream().map(ProjectImages::getImagePath).collect(Collectors.toList()));
                return pDto;
            }).collect(Collectors.toList());
            dto.setProjectProgressDTOS(progress);
            return dto;
        }).collect(Collectors.toList());
        return success("Fetch Successfully", response);
    }

    public ResponseEntity fetchWorkSteps() {
        var response = Arrays.stream(WorkSteps.values()).map(x -> {
            var dto = new DropdownDTO();
            dto.setId(x.name());
            dto.setName(x.name());
            return dto;
        }).collect(Collectors.toList());
        return success("Fetch Successfully", response);
    }

    public ResponseEntity fetchBillingStatus() {
        var response = Arrays.stream(BillingStatus.values()).map(x -> {
            var dto = new DropdownDTO();
            dto.setId(x.name());
            dto.setName(x.name());
            return dto;
        }).collect(Collectors.toList());
        return success("Fetch Successfully", response);
    }

    public ResponseEntity updateProjectStatus(ProgressData dto, MultipartFile[] files) {
        ProjectProgress entity = new ProjectProgress();
        entity.setBillingStatus((BillingStatus.valueOf(dto.getBillingStatus())));
        entity.setDetails(dto.getDetails());
        var master = repo.findById(Long.parseLong(String.valueOf(dto.getMstId())));
        master.ifPresent(entity::setMasterTable);
        entity.setWorkSteps((WorkSteps.valueOf(dto.getWorkSteps())));
        entity.setSubmittedDate(LocalDateTime.now());
        entity = progressRepo.saveAndFlush(entity);

        for (var file : files) {
            String tempReportDirectory;
            if (Objects.equals(File.separator, "/")) {
                tempReportDirectory = docFilePath.replace("\\", File.separator);
            } else {
                tempReportDirectory = docFilePath.replace("/", File.separator);
            }
            if (Files.isDirectory(Paths.get(tempReportDirectory))){
                try {
                    Files.createDirectory(Paths.get(tempReportDirectory));
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            String fullReportPath = tempReportDirectory + "\\" + file.getOriginalFilename();
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            ObjectOutputStream oos;
            try {
                oos = new ObjectOutputStream(bos);
                oos.writeObject(file.getBytes());
                oos.flush();
                byte[] data = bos.toByteArray();
                try (FileOutputStream outputStream = new FileOutputStream(fullReportPath)) {
                    outputStream.write(data);
                }
                var img = new ProjectImages();
                img.setImagePath("http://localhost:8080");
                img.setProjectProgress(entity);

                imagesRepo.saveAndFlush(img);


            } catch (IOException e) {
                return success(e.getMessage(), false);
            }
        }
        return success("Successfully Saved", true);
    }
}
