package com.hqyj.service;

import com.hqyj.pojo.Emp;
import com.hqyj.pojo.MyPage;

import java.util.HashMap;

public interface EmpService {
    String login(String username, String password);

    HashMap<String,Object> findAllEmp(MyPage myPage);

    Emp findEmpByUsername(String username);

    HashMap<String, Object> searchEmpByUserName(MyPage myPage, String username);

    void insertEmp(Emp emp);


//    String findPassWordByName(String Name);
}
