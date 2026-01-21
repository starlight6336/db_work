package com.example.mybatisplus.model.vo;

import lombok.Data;
import org.apache.ibatis.annotations.Param;

@Data
public class ConsulationVO {
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
    private String teacher;
    private String room;
    private Integer state;
    private Integer consulttimes;
}
