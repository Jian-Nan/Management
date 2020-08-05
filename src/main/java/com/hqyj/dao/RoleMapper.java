package com.hqyj.dao;

import com.hqyj.pojo.Role;

import java.util.List;

public interface RoleMapper {

    List<Role> selectByPage(Role role);
}