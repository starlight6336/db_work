package com.example.mybatisplus.model.domain.ev;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("browse_history")
public class BrowseHistory {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @TableField("user_id")
    private Long userId;

    @TableField("vehicle_id")
    private Long vehicleId;

    @TableField("browse_time")
    private LocalDateTime browseTime;

    @TableField("create_date")
    private LocalDateTime createDate;

    @TableField("update_date")
    private LocalDateTime updateDate;

    @TableLogic
    @TableField("is_deleted")
    private Boolean deleted;
}

