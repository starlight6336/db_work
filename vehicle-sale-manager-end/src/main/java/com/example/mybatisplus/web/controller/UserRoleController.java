package com.example.mybatisplus.web.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.example.mybatisplus.common.JsonResponse;
import com.example.mybatisplus.service.UserRoleService;
import com.example.mybatisplus.model.domain.UserRole;


/**
 *
 *  前端控制器
 *
 *
 * @author hjk
 * @since 2024-01-04
 * @version v1.0
 */
@Controller
@RequestMapping("/api/userRole")
public class UserRoleController {

    private final Logger logger = LoggerFactory.getLogger( UserRoleController.class );

    @Autowired
    private UserRoleService userRoleService;

    /**
    * 描述：根据Id 查询
    *
    */
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    @ResponseBody
    public JsonResponse getById(@PathVariable("id") Long id)throws Exception {
        UserRole  userRole =  userRoleService.getById(id);
        return JsonResponse.success(userRole);
    }

    /**
    * 描述：根据Id删除
    *
    */
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    @ResponseBody
    public JsonResponse deleteById(@PathVariable("id") Long id) throws Exception {
        userRoleService.removeById(id);
        return JsonResponse.success(null);
    }


    /**
    * 描述：根据Id 更新
    *
    */
    @RequestMapping(value = "", method = RequestMethod.PUT)
    @ResponseBody
    public JsonResponse updateUserRole(UserRole  userRole) throws Exception {
        userRoleService.updateById(userRole);
        return JsonResponse.success(null);
    }


    /**
    * 描述:创建UserRole
    *
    */
    @RequestMapping(value = "", method = RequestMethod.POST)
    @ResponseBody
    public JsonResponse create(UserRole  userRole) throws Exception {
        userRoleService.save(userRole);
        return JsonResponse.success(null);
    }
}

