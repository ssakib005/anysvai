package com.demo.demo.repo;

import com.demo.demo.model.MasterTable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MasterTableRepo extends JpaRepository<MasterTable, Long> {
}
