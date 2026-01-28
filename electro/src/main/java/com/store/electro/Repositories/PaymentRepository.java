package com.store.electro.Repositories;

import com.store.electro.Models.Entity.Payment.Payment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PaymentRepository extends JpaRepository<Payment, Long> {
}
