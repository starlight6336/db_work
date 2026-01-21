package com.example.mybatisplus.model.domain.ev;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.example.mybatisplus.model.domain.ev.enums.TestDriveStatus;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("test_drive_record")
public class TestDriveRecord {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;
    @TableField("user_id")
    private Long userId;
    @TableField("vehicle_id")
    private Long vehicleId;
    private String store;
    @TableField("schedule_time")
    private LocalDateTime scheduleTime;
    private TestDriveStatus status = TestDriveStatus.PENDING;
    @TableField("admin_note")
    private String adminNote;
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
