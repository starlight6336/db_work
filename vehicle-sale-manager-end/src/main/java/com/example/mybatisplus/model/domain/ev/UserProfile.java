package com.example.mybatisplus.model.domain.ev;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
public class UserProfile {
    private Long id;
    private String name;
    private String phone;
    private String idNumber;
    private String address;
    private LocalDateTime registerTime;
    private List<String> preferBrands = new ArrayList<>();
    private List<String> preferBatteryTypes = new ArrayList<>();
}
