package com.demo.demo.repo;

import com.demo.demo.model.District;
import com.demo.demo.model.ProjectProgress;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProjectProgressRepo extends JpaRepository<ProjectProgress, Long> {
}
