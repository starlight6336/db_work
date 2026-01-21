package com.example.mybatisplus.web.controller;

import com.example.mybatisplus.model.vo.UserVO;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.example.mybatisplus.common.JsonResponse;
import com.example.mybatisplus.service.UserService;
import com.example.mybatisplus.model.domain.User;

import java.sql.SQLOutput;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;


/**
 *
 *  前端控制器
 *
 *
 * @author hjk
 * @since 2023-12-27
 * @version v1.0
 */
@RestController
@RequestMapping("/api/user")
public class UserController {

    private final Logger logger = LoggerFactory.getLogger( UserController.class );

    @Autowired
    private UserService userService;



    //用户登录
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    @ResponseBody
    public JsonResponse login(@RequestBody User user){
        UserVO user1 = userService.login(user);
        if (user1 != null) {
            System.out.println(user1);
            return JsonResponse.success(user1,"登陆成功~");
        }else
            return JsonResponse.failure("此用户不存在或账密错误");
    }

    @RequestMapping(value = "/userInfo", method = RequestMethod.GET)
    @ResponseBody
    public JsonResponse getUserInfoById(@Param("id") Long id){
        UserVO user = userService.getUserVOById(id);
        if(user == null)
            return JsonResponse.failure("用户id不存在");
        return JsonResponse.success(user);
    }
    /**
    * 描述：根据Id 查询
    *
    */
    @RequestMapping(value = "/get", method = RequestMethod.POST)
    @ResponseBody
    public JsonResponse getById(@RequestBody User user){
        User  userg =  userService.getById(user.getId());
        return JsonResponse.success(userg);
    }

    /**
    * 描述：根据Id删除
    *
    */
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    @ResponseBody
    public JsonResponse deleteById(@PathVariable("id") Long id) throws Exception {
        userService.removeById(id);
        return JsonResponse.success(null);
    }


    /**
    * 描述：根据Id 更新
    *
    */
    @RequestMapping(value = "", method = RequestMethod.PUT)
    @ResponseBody
    public JsonResponse updateUser(User  user) throws Exception {
        userService.updateById(user);
        return JsonResponse.success(null);
    }


    /**
    * 描述:创建User
    *
    */
    @RequestMapping(value = "", method = RequestMethod.POST)
    @ResponseBody
    public JsonResponse create(User  user) throws Exception {
        userService.save(user);
        return JsonResponse.success(null);
    }


    // 其余与心理咨询相关的接口已移除，新能源汽车业务不再使用
}

