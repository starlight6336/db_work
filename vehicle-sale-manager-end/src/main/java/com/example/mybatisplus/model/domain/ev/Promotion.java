package com.example.mybatisplus.model.domain.ev;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.example.mybatisplus.model.domain.ev.enums.PromotionStatus;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("promotion")
public class Promotion {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;
    @TableField("vehicle_id")
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
    @TableField("discount_rate")
    private BigDecimal discountRate;
    private String gift;
    private BigDecimal subsidy;
    @TableField("start_date")
    private LocalDate startDate;
    @TableField("end_date")
    private LocalDate endDate;
    private PromotionStatus status = PromotionStatus.ONLINE;

    @TableField("create_date")
    private LocalDateTime createDate;

    @TableField("update_date")
    private LocalDateTime updateDate;

    @TableLogic
    @TableField("is_deleted")
    private Boolean deleted;
}
