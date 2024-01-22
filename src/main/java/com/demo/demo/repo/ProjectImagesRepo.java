package com.demo.demo.repo;

import com.demo.demo.model.District;
import com.demo.demo.model.ProjectImages;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProjectImagesRepo extends JpaRepository<ProjectImages, Long> {
}
