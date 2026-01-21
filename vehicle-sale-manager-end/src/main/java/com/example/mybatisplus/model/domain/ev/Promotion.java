package com.example.mybatisplus.model.domain.ev;

import com.example.mybatisplus.model.domain.ev.enums.PromotionStatus;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class Promotion {
    private Long id;
    private Long vehicleId;
    private String title;
    /**
     * 活动类型（折扣、赠品、补贴等）
     */
    private String type;
    private String description;
    /**
     * 折扣比例，0.9 表示 9 折
     */
    private BigDecimal discountRate;
    private String gift;
    private BigDecimal subsidy;
    private LocalDate startDate;
    private LocalDate endDate;
    private PromotionStatus status = PromotionStatus.ONLINE;
}
