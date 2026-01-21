package com.example.mybatisplus.model.domain.ev;

import com.example.mybatisplus.model.domain.ev.enums.OrderStatus;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class OrderRecord {
    private Long id;
    private String orderNo;
    private Long userId;
    private Long vehicleId;
    private Integer quantity;
    private String store;
    private String contactName;
    private String contactPhone;
    private OrderStatus status = OrderStatus.WAIT_PAY;
    private LocalDateTime createdAt;
    private LocalDateTime paidAt;
    private LocalDateTime pickupAt;
    private BigDecimal pricePerUnit;
    private BigDecimal totalAmount;
    private String promotionTitle;
    private Long promotionId;
    private Long financialPlanId;
    private String remark;
}
