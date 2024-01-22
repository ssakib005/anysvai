package com.demo.demo.repo;

import com.demo.demo.model.District;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DistrictRepo extends JpaRepository<District, Long> {
}
