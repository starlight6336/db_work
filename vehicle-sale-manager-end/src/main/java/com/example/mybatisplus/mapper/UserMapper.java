package com.example.mybatisplus.mapper;

import com.example.mybatisplus.model.domain.User;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.mybatisplus.model.vo.CounselorVO;
import com.example.mybatisplus.model.vo.FreeTeacherVO;
import com.example.mybatisplus.model.vo.UserVO;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author hjk
 * @since 2023-12-27
 */

@Repository
public interface UserMapper extends BaseMapper<User> {

    List<UserVO> selectAllUserVO();

    List<UserVO> selectByParm(@Param("user") UserVO user);

    List<UserVO> selectTeacherListByParm(@Param("parm") String parm);

    // 根据用户查询相关角色信息
    UserVO selectOneUserVO(@Param("user") User one);

}
