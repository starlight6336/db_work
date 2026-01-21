package com.example.mybatisplus.model.vo;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Date;

@Data
public class FirstVisitVO {
    private Integer id;
    private String loginName;
    private String name;
    private String sex;
    private Integer fid;
    private Integer theme;
    private Integer selfemergency;
    private Integer score;
    private Integer problem;
    private Integer disease;
    private String facility;
    private String telephone;
    private LocalDate date;
    private Integer day;
    private LocalTime time;
    private String teacher;
    private String room;
    private Integer state;
    private Integer conclusion;
}
