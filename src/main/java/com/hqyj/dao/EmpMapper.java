package com.hqyj.dao;

import com.hqyj.pojo.Emp;

import java.util.HashMap;
import java.util.List;

public interface EmpMapper {

    String findPassWordByName(String name);

    List<Emp> findAllEmp();

    Emp findEmpByUsername(String username);

    List<Emp> searchEmpByUserName(String username);

    void insertEmp(Emp emp);

    void editEmp(Emp emp);

    void deleteEmpById(String id);

    int findEmpIdByUsername(String username);

    void addEmpRole(int eid, int rid);

    int findRoleByEmpId(int empId);

    void editEmpRole(Long empId, int rid);
}