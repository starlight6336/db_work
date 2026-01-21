package com.example.mybatisplus.model.domain.ev;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
@TableName(value = "user_profile", autoResultMap = true)
public class UserProfile {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;
    private String name;
    private String phone;
    @TableField("id_number")
    private String idNumber;
    private String address;
    @TableField("register_time")
    private LocalDateTime registerTime;
    @TableField(value = "prefer_brands", typeHandler = JacksonTypeHandler.class)
    private List<String> preferBrands;
    @TableField(value = "prefer_battery_types", typeHandler = JacksonTypeHandler.class)
    private List<String> preferBatteryTypes;

    @TableField("create_date")
    private LocalDateTime createDate;

    @TableField("update_date")
    private LocalDateTime updateDate;

    @TableLogic
    @TableField("is_deleted")
    private Boolean deleted;
}
