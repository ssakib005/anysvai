package com.demo.demo.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "PROJECT_PROGRESS")
public class ProjectProgress {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    private String details;

    private LocalDateTime submittedDate;

    @Enumerated(EnumType.STRING)
    private WorkSteps workSteps;

    @Enumerated(EnumType.STRING)
    private BillingStatus billingStatus;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "master_table_id")
    private MasterTable masterTable;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "projectProgress", cascade = CascadeType.ALL)
    private List<ProjectImages> projectImages = new ArrayList<>();

}
