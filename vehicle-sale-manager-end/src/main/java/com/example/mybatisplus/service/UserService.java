package com.example.mybatisplus.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.mybatisplus.common.JsonResponse;
import com.example.mybatisplus.model.domain.User;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.mybatisplus.model.vo.CounselorVO;
import com.example.mybatisplus.model.vo.UserVO;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author hjk
 * @since 2023-12-27
 */
public interface UserService extends IService<User> {

    UserVO login(User user);
    UserVO getUserVOById(Long id);

    // 下面这些方法原本用于心理咨询排班 / 初访，现在已废弃，可根据需要补充汽车相关逻辑
}
