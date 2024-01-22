package com.demo.demo.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "PROJECT_IMAGES")
public class ProjectImages {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    private String imagePath;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "project_progress_id")
    private ProjectProgress projectProgress;

}
