package com.hqyj.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hqyj.dao.EmpMapper;
import com.hqyj.pojo.Emp;
import com.hqyj.pojo.MyPage;
import com.hqyj.service.EmpService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class EmpServiceImpl implements EmpService {

    @Autowired
    private EmpMapper empMapper;

    @Override
    public String login(String username, String password) {
        //获取当前用户
        Subject currentUser = SecurityUtils.getSubject();

        if (!currentUser.isAuthenticated()) {
            // 把用户名和密码封装为 UsernamePasswordToken 对象
            UsernamePasswordToken token = new UsernamePasswordToken(username, password);
            // rememberme
            token.setRememberMe(true);
            try {
                System.out.println("1. " + token.hashCode());
                // 执行登录. 调用的是自定义realm的方法
                currentUser.login(token);
                currentUser.getSession().setAttribute("userName",username);
                return "index";
            }
            // ... catch more exceptions here (maybe custom ones specific to your application?
            // 所有认证时异常的父类.
            catch (AuthenticationException ae) {
                //unexpected condition?  error?
                System.out.println("登录失败: " + ae.getMessage());
                return "null";
            }
        }
        return "index";
    }

    //查询所有用户
    @Override
    public HashMap<String, Object> findAllEmp(MyPage myPage) {
        PageHelper.startPage(myPage.getPage(),myPage.getRow());
        List<Emp> empList= empMapper.findAllEmp();
        PageInfo<Emp> pageInfo = new PageInfo<>(empList);
        HashMap<String,Object> pageMap = new HashMap<>(8);

        pageMap.put("emps",pageInfo.getList());
        pageMap.put("total",pageInfo.getTotal());
        pageMap.put("prePage",pageInfo.getPrePage()==0?1:pageInfo.getPrePage());
        pageMap.put("nextPage",pageInfo.getNextPage()==0?pageInfo.getNavigateLastPage():pageInfo.getNextPage());
        pageMap.put("firstPage",pageInfo.getNavigateFirstPage());
        pageMap.put("endPage",pageInfo.getNavigateLastPage());
        pageMap.put("pageSize",pageInfo.getPageSize());
        pageMap.put("nowPage",pageInfo.getPageNum());
        return pageMap;
    }

    @Override
    public Emp findEmpByUsername(String username) {
        return empMapper.findEmpByUsername(username);
    }

    @Override
    public HashMap<String, Object> searchEmpByUserName(MyPage myPage, String username) {
        PageHelper.startPage(myPage.getPage(),myPage.getRow());
        List<Emp> empList= empMapper.searchEmpByUserName(username);
        PageInfo<Emp> pageInfo = new PageInfo<>(empList);
        HashMap<String,Object> pageMap = new HashMap<>(8);

        pageMap.put("emps",pageInfo.getList());
        pageMap.put("total",pageInfo.getTotal());
        pageMap.put("prePage",pageInfo.getPrePage()==0?1:pageInfo.getPrePage());
        pageMap.put("nextPage",pageInfo.getNextPage()==0?pageInfo.getNavigateLastPage():pageInfo.getNextPage());
        pageMap.put("firstPage",pageInfo.getNavigateFirstPage());
        pageMap.put("endPage",pageInfo.getNavigateLastPage());
        pageMap.put("pageSize",pageInfo.getPageSize());
        pageMap.put("nowPage",pageInfo.getPageNum());
        return pageMap;
    }

    @Override
    public void insertEmp(Emp emp) {
        empMapper.insertEmp(emp);
    }

//    @Override
//    public String findPassWordByName(String Name) {
//        return empMapper.findPassWordByName(Name);
//    }
}
