package com.example.mybatisplus.service.impl;

import com.example.mybatisplus.model.domain.Menu;
import com.example.mybatisplus.mapper.MenuMapper;
import com.example.mybatisplus.service.MenuService;
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
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements MenuService {

}
