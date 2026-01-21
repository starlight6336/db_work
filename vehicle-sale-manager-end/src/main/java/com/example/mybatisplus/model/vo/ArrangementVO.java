package com.example.mybatisplus.model.vo;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalTime;

@Data
public class ArrangementVO {
    private LocalDate arrangementDate;

    private Integer dayOfWeek;

    private LocalTime startTime;

    private LocalTime endTime;

    private Long uid;

    private Long rid;

    private Long fid;

    private Long cid;

    private String teacherName;

    private String roomName;

    private Integer restTimes;
}
