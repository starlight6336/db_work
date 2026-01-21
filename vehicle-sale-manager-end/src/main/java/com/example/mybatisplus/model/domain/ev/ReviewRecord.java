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
@TableName(value = "review_record", autoResultMap = true)
public class ReviewRecord {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;
    @TableField("order_id")
    private Long orderId;
    @TableField("user_id")
    private Long userId;
    @TableField("vehicle_id")
    private Long vehicleId;
    private Integer rating;
    private String comment;
    @TableField(value = "photos", typeHandler = JacksonTypeHandler.class)
    private List<String> photos;
    @TableField("created_at")
    private LocalDateTime createdAt;

    @TableField("create_date")
    private LocalDateTime createDate;

    @TableField("update_date")
    private LocalDateTime updateDate;

    @TableLogic
    @TableField("is_deleted")
    private Boolean deleted;
}
