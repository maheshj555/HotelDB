package com.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.entity.Bill;
@Repository
public interface BillRepository extends JpaRepository<Bill, Long> {

}
