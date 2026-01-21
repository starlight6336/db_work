package com.example.mybatisplus.model.vo;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Date;
@Data
public class ConsulationManageVO {
    private Long id;
    private Long fid;
    private Long cid;
    private String name;
    private String loginName;
    private String sex;
    private Integer danger;
    private Integer problem;
    private Integer disease;
    private String facility;
    private String telephone;
    private LocalDate date;
    private Integer day;
    private LocalTime time;
    private Integer conclusion;
    private Integer state;
    private Integer consulttimes;
}
