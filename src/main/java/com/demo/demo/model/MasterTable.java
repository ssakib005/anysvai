package com.demo.demo.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "MASTER_TABLE")
@Inheritance(strategy = InheritanceType.JOINED)
public class MasterTable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String applicantName;

    private String nidNo;

    private String mobileNo;

    private String freedomFighterName;

    private String fatherName;

    private String village;

    private String upazila;

    @ManyToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "district_id", nullable = false)
    private District district;

    @ManyToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "division_id", nullable = false)
    private Division division;

    private String indianList;

    private String redLightRelease;

    private String govtCivilGadgetNo;

    private String misNo;

    private String landDetails;

    private String landLocation;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "masterTable", cascade = CascadeType.ALL)
    private List<ProjectProgress> projectProgresses = new ArrayList<>();

}
