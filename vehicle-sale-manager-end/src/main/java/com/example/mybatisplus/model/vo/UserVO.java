package com.example.mybatisplus.model.vo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.example.mybatisplus.model.domain.Role;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class UserVO {
    private static final long serialVersionUID = 1L;

    @TableId(value = "id",type = IdType.NONE)
    private Long id;

    @TableField("loginName")
    private String loginName;

    private String password;

    private String name;

    private String sex;

    private LocalDate birth;

    private LocalDateTime createDate;

    private LocalDateTime updateDate;

    @TableLogic
    @TableField("is_deleted")
    private Boolean deleted;

    @TableField(exist = false)
    private Role role;

}
