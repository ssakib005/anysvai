package com.demo.demo.repo;

import com.demo.demo.model.Division;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DivisionRepo extends JpaRepository<Division, Long> {
}
