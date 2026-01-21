package com.example.mybatisplus.model.domain.ev;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.example.mybatisplus.model.domain.ev.enums.OrderStatus;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("order_record")
public class OrderRecord {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;
    @TableField("order_no")
    private String orderNo;
    @TableField("user_id")
    private Long userId;
    @TableField("vehicle_id")
    private Long vehicleId;
    private Integer quantity;
    private String store;
    @TableField("contact_name")
    private String contactName;
    @TableField("contact_phone")
    private String contactPhone;
    private OrderStatus status = OrderStatus.WAIT_PAY;
    @TableField("created_at")
    private LocalDateTime createdAt;
    @TableField("paid_at")
    private LocalDateTime paidAt;
    @TableField("pickup_at")
    private LocalDateTime pickupAt;
    @TableField("price_per_unit")
    private BigDecimal pricePerUnit;
    @TableField("total_amount")
    private BigDecimal totalAmount;
    @TableField("promotion_title")
    private String promotionTitle;
    @TableField("promotion_id")
    private Long promotionId;
    @TableField("financial_plan_id")
    private Long financialPlanId;
    private String remark;

    @TableField("create_date")
    private LocalDateTime createDate;

    @TableField("update_date")
    private LocalDateTime updateDate;

    @TableLogic
    @TableField("is_deleted")
    private Boolean deleted;
}
