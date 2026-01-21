package com.example.mybatisplus.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.mybatisplus.common.JsonResponse;
import com.example.mybatisplus.mapper.UserMapper;
import com.example.mybatisplus.model.domain.User;
import com.example.mybatisplus.model.vo.UserVO;
import com.example.mybatisplus.service.UserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import net.sf.jsqlparser.statement.select.First;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionUsageException;
import org.springframework.util.CollectionUtils;
import springfox.documentation.spring.web.json.Json;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author hjk
 * @since 2023-12-27
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Autowired
    private UserMapper userMapper;
    @Override
    public UserVO login(User user) {
        QueryWrapper<User> wrapper = new QueryWrapper<>();
        wrapper.eq("loginName",user.getLoginName()).eq("password",user.getPassword());
        User one = userMapper.selectOne(wrapper);
        if (one == null)
            return null;
        UserVO res = userMapper.selectOneUserVO(one);
        return res;
    }

    @Override
    public UserVO getUserVOById(Long id){
        User one = userMapper.selectById(id);
        if (one == null)
            return null;
        UserVO res = userMapper.selectOneUserVO(one);
        return res;
    }

    // 其余心理咨询相关的方法已移除，避免引用已删除的实体

}
