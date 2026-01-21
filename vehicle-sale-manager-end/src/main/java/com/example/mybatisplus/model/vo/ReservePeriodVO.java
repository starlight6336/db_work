package com.example.mybatisplus.model.vo;

import lombok.Data;


import java.time.LocalTime;
// 包含一条时段信息
@Data
public class ReservePeriodVO {

    private LocalTime startTime;
    private LocalTime endTime;
    private Boolean state;
    private Integer matched;
    private Integer waiting;
}
