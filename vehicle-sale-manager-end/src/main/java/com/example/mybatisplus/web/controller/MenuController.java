package com.example.mybatisplus.web.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.example.mybatisplus.common.JsonResponse;
import com.example.mybatisplus.service.MenuService;
import com.example.mybatisplus.model.domain.Menu;


/**
 *
 *  前端控制器
 *
 *
 * @author hjk
 * @since 2023-12-27
 * @version v1.0
 */
@Controller
@RequestMapping("/api/menu")
public class MenuController {

    private final Logger logger = LoggerFactory.getLogger( MenuController.class );

    @Autowired
    private MenuService menuService;

    /**
    * 描述：根据Id 查询
    *
    */
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    @ResponseBody
    public JsonResponse getById(@PathVariable("id") Long id)throws Exception {
        Menu  menu =  menuService.getById(id);
        return JsonResponse.success(menu);
    }

    /**
    * 描述：根据Id删除
    *
    */
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    @ResponseBody
    public JsonResponse deleteById(@PathVariable("id") Long id) throws Exception {
        menuService.removeById(id);
        return JsonResponse.success(null);
    }


    /**
    * 描述：根据Id 更新
    *
    */
    @RequestMapping(value = "", method = RequestMethod.PUT)
    @ResponseBody
    public JsonResponse updateMenu(Menu  menu) throws Exception {
        menuService.updateById(menu);
        return JsonResponse.success(null);
    }


    /**
    * 描述:创建Menu
    *
    */
    @RequestMapping(value = "", method = RequestMethod.POST)
    @ResponseBody
    public JsonResponse create(Menu  menu) throws Exception {
        menuService.save(menu);
        return JsonResponse.success(null);
    }
}

