package com.store.electro.Services;

import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.store.electro.Models.Entity.Discount;
import com.store.electro.Repositories.DiscountRepository;

import jakarta.persistence.EntityNotFoundException;

@Service
public class DiscountService {

    private final DiscountRepository discountRepository;

    public DiscountService(DiscountRepository discountRepository) {
        this.discountRepository = discountRepository;
    }

    public List<Discount> getAllDiscounts() {
        return discountRepository.findAll();
    }

    public Discount getDiscountById(Long id) {
        return discountRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Discount not found with id: " + id));
    }

    public Discount getDiscountByCode(String code) {
        return discountRepository.findByCode(code)
                .orElseThrow(() -> new EntityNotFoundException("Discount not found with code: " + code));
    }

    @Transactional
    public Discount createDiscount(Discount discount) {
        if (discount.getEndDate() != null && discount.getStartDate() != null
                && discount.getEndDate().isBefore(discount.getStartDate())) {
            throw new RuntimeException("End date must be after start date");
        }
        if (discountRepository.findByCode(discount.getCode()).isPresent()) {
            throw new RuntimeException("Discount code already exists");
        }
        if (discount.getPercent() == null || discount.getPercent() < 0 || discount.getPercent() > 100) {
            throw new RuntimeException("Discount percent must be between 0 and 100");
        }
        return discountRepository.save(discount);
    }

    @Transactional
    public Discount updateDiscount(Long id, Discount discount) {
        Discount existingDiscount = getDiscountById(id);
        if (discount.getCode() != null && !discount.getCode().equals(existingDiscount.getCode())) {
            if (discountRepository.findByCode(discount.getCode()).isPresent()) {
                throw new RuntimeException("Discount code already exists");
            }
            existingDiscount.setCode(discount.getCode());
        }
        if (discount.getPercent() != null) {
            if (discount.getPercent() < 0 || discount.getPercent() > 100) {
                throw new RuntimeException("Discount percent must be between 0 and 100");
            }
            existingDiscount.setPercent(discount.getPercent());
        }
        if (discount.getStartDate() != null) existingDiscount.setStartDate(discount.getStartDate());
        if (discount.getEndDate() != null) existingDiscount.setEndDate(discount.getEndDate());
        return discountRepository.save(existingDiscount);
    }

    @Transactional
    public void deleteDiscount(Long id) {
        Discount discount = getDiscountById(id);
        discountRepository.delete(discount);
    }
}
