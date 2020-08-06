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

    void editEmp(Emp emp);

    void deleteEmpById(String id);

    int findEmpIdByUsername(String username);

    void addEmpRole(int eid, int rid);

    int findRoleByEmpId(int empId);

    void editEmpRole(Long empId, int rid);


//    String findPassWordByName(String Name);
}
