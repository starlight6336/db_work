package com.example.mybatisplus.model.domain.ev;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
public class ReviewRecord {
    private Long id;
    private Long orderId;
    private Long userId;
    private Long vehicleId;
    private Integer rating;
    private String comment;
    private List<String> photos = new ArrayList<>();
    private LocalDateTime createdAt;
}
