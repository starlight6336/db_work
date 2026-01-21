package com.example.mybatisplus.model.domain.ev;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Data
public class Vehicle {
    private Long id;
    private String name;
    private String brand;
    /**
     * 续航里程，单位 km
     */
    private Integer rangeKm;
    /**
     * 电池类型（磷酸铁锂、三元锂等）
     */
    private String batteryType;
    /**
     * 官方指导价
     */
    private BigDecimal guidePrice;
    private Integer stock;
    private LocalDate launchDate;
    /**
     * 快充时间，单位分钟
     */
    private Integer fastChargeMinutes;
    /**
     * 智驾等级（L2/L2+/L3 等）
     */
    private String smartDriveLevel;
    private String description;
    /**
     * 其他配置参数，便于对比/展示
     */
    private Map<String, String> configs = new HashMap<>();
    /**
     * 车型图集
     */
    private List<String> images = new ArrayList<>();
    /**
     * 已关联的促销活动 ID 列表
     */
    private List<Long> promotionIds = new ArrayList<>();
}
