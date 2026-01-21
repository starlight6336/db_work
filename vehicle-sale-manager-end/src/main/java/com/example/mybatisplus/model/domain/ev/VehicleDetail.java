package com.example.mybatisplus.model.domain.ev;

import lombok.Data;

import java.util.List;

@Data
public class VehicleDetail {
    private Vehicle vehicle;
    private List<Promotion> promotions;
    private List<ReviewRecord> reviews;
    private boolean lowStock;
}
