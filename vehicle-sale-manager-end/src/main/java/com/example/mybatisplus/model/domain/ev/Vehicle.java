package com.example.mybatisplus.model.domain.ev;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Data
@TableName(value = "vehicle", autoResultMap = true)
public class Vehicle {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    private String name;
    private String brand;

    /**
     * 续航里程，单位 km
     */
    @TableField("range_km")
    private Integer rangeKm;

    /**
     * 电池类型（磷酸铁锂、三元锂等）
     */
    @TableField("battery_type")
    private String batteryType;

    /**
     * 官方指导价
     */
    @TableField("guide_price")
    private BigDecimal guidePrice;

    private Integer stock;

    @TableField("launch_date")
    private LocalDate launchDate;

    /**
     * 快充时间，单位分钟
     */
    @TableField("fast_charge_minutes")
    private Integer fastChargeMinutes;

    /**
     * 智驾等级（L2/L2+/L3 等）
     */
    @TableField("smart_drive_level")
    private String smartDriveLevel;

    private String description;

    /**
     * 其他配置参数（JSON）
     */
    @TableField(value = "configs", typeHandler = JacksonTypeHandler.class)
    private Map<String, String> configs;

    /**
     * 车型图集（JSON数组）
     */
    @TableField(value = "images", typeHandler = JacksonTypeHandler.class)
    private List<String> images;

    @TableField("create_date")
    private LocalDateTime createDate;

    @TableField("update_date")
    private LocalDateTime updateDate;

    @TableLogic
    @TableField("is_deleted")
    private Boolean deleted;
}
