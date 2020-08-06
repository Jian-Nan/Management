package com.hqyj.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hqyj.dao.RoleMapper;
import com.hqyj.pojo.Role;
import com.hqyj.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    private RoleMapper roleMapper;
    @Override
    public HashMap<String, Object> rolelist(Role role) {
        PageHelper.startPage(role.getPage(),role.getRow());
       List<Role> list = roleMapper.selectByPage(role);
        PageInfo<Role> rolePageInfo = new PageInfo<>(list);
        HashMap<String,Object> pageMap = new HashMap<>();
        System.err.println(rolePageInfo.getList());
        pageMap.put("list",rolePageInfo.getList());
        pageMap.put("total",rolePageInfo.getTotal());
        pageMap.put("prePage",rolePageInfo.getPrePage()==0?1:rolePageInfo.getPrePage());
        pageMap.put("nextPage",rolePageInfo.getNextPage()==0?rolePageInfo.getNavigateLastPage():rolePageInfo.getNextPage());
        pageMap.put("firstPage",rolePageInfo.getNavigateFirstPage());
        pageMap.put("endPage",rolePageInfo.getNavigateLastPage());
        pageMap.put("pageSize",rolePageInfo.getPageSize());
        pageMap.put("nowPage",rolePageInfo.getPageNum());
        return pageMap;
    }


    //查询所有用户
    @Override
    public List<Role> findAllRole() {

        return roleMapper.findAllRole();
    }
}
