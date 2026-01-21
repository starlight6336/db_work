package com.example.mybatisplus.model.vo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

@Data
public class FirstVisiterVO {
    @TableId(value = "id",type = IdType.NONE)
    private Long id;
    private String loginName;
    private String name;
    private String sex;
    //总值班时段数
    private int totaldutynumber;
    //初访人员数
    private int totalvisiternumber;
}
