package com.example.mybatisplus.model.vo;

import lombok.Data;

import java.time.LocalDate;
import java.util.List;

// 一天包含一天的所有时段信息
@Data
public class ReserveDayVO {
    private LocalDate reserveDate;
    private Integer dayOfWeek;
    private Integer state;
    private List<ReservePeriodVO> periods;
}
