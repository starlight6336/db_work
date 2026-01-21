package com.example.mybatisplus.service.impl;

import com.example.mybatisplus.model.domain.Role;
import com.example.mybatisplus.mapper.RoleMapper;
import com.example.mybatisplus.service.RoleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author hjk
 * @since 2023-12-27
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {

}
