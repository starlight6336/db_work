package com.example.mybatisplus.model.vo;


import com.example.mybatisplus.model.domain.User;
import lombok.Data;

import java.time.LocalDate;
import java.util.List;

@Data
public class ReservationVO {
    private Long id;

    private String loginName;


    private String name;

    private String sex;

    private LocalDate birth;

    private Integer theme;

    private Integer selfEmergency;



    private String expectTime1;

    private String expectTime2;

    private String expectTime3;

    private Long fid;
}
