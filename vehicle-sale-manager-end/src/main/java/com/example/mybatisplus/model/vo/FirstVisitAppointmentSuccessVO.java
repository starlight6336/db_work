package com.example.mybatisplus.model.vo;

import lombok.Data;

import java.sql.Time;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Data
public class FirstVisitAppointmentSuccessVO {
    Integer id;
    String loginName;
    Integer fid;
    String name;
    String sex;
    Integer theme;
    Integer selfemergency;
    Integer score;
    String facility;
    String telephone;
    LocalDate firstvisitdate;
    Integer day;
    Time firstvisittime;
    String teacher;
    String room;
    Integer state;
}
