package com.example.mybatisplus.model.domain.ev;

import com.example.mybatisplus.model.domain.ev.enums.TestDriveStatus;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class TestDriveRecord {
    private Long id;
    private Long userId;
    private Long vehicleId;
    private String store;
    private LocalDateTime scheduleTime;
    private TestDriveStatus status = TestDriveStatus.PENDING;
    private String adminNote;
    private LocalDateTime createdAt;
}
