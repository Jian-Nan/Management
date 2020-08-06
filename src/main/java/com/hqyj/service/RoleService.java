package com.hqyj.service;

import com.hqyj.pojo.Role;

import java.util.HashMap;
import java.util.List;

public interface RoleService {
    HashMap<String, Object> rolelist(Role role);

    List<Role> findAllRole();
}
