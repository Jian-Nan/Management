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
}