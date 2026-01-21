package com.example.mybatisplus.model.domain.ev;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class FinancialPlan {
    private Long id;
    private Long vehicleId;
    private String name;
    /**
     * 首付比例 0.2 表示 20%
     */
    private BigDecimal downPaymentRate;
    /**
     * 分期期数（月）
     */
    private Integer months;
    /**
     * 年化利率
     */
    private BigDecimal annualRate;
}
