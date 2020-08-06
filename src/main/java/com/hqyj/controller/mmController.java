package com.hqyj.controller;

import com.hqyj.pojo.Emp;
import com.hqyj.pojo.MyPage;
import com.hqyj.pojo.Role;
import com.hqyj.service.EmpService;
import com.hqyj.service.RoleService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

@Controller
public class mmController {

    @Autowired
    private EmpService empService;

    @Autowired
    private RoleService roleService;

    //登录
    @RequestMapping("login.do")
    public String login(@RequestParam("username") String username, @RequestParam("password") String password, HttpServletRequest request) {
        String page = empService.login(username, password);
        if("null".equals(page))
        {
            return "redirect:login.jsp";
        }
        Emp emp=empService.findEmpByUsername(username);
        HttpSession session=request.getSession();
        session.setAttribute("emp",emp);
        return page;
    }





    //shiro退出
    @RequestMapping("logout.do")
    public String logout() {
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        return "redirect:login.jsp";
    }


    //查询所有用户
    @RequestMapping("findAllEmp.ajax")
    @ResponseBody
    public HashMap<String,Object> findAllEmp(String page)
    {
        int Page=Integer.valueOf(page);
        HashMap<String,Object> map=new HashMap<>();
        MyPage myPage=new MyPage();
        myPage.setPage(Page);
        map=empService.findAllEmp(myPage);

        return map;
    }

    //查找用户
    @RequestMapping("searchEmp.ajax")
    @ResponseBody
    public HashMap<String,Object>searchEmp(String username)
    {
        HashMap<String,Object> map=new HashMap<>();
        MyPage myPage=new MyPage();
        myPage.setPage(1);
        map=empService.searchEmpByUserName(myPage,username);

        return map;
    }

    //增加用户
    @RequestMapping("addEmp.ajax")
    @ResponseBody
    public String addEmp(Emp emp,String choose)
    {
//        System.out.println(emp);
        //设置加密方式
        String algorithmName="MD5";
        //设置待加密的原密码
        Object source=emp.getPassword();
        //设置加盐方式(一般来说都是以用户名来加盐)
        Object salt= ByteSource.Util.bytes(emp.getUsername());
        //加密次数
        int hashIterations=1024;
        SimpleHash newPassword=new SimpleHash(algorithmName, source, salt, hashIterations);
        emp.setPassword(newPassword.toString());
        empService.insertEmp(emp);

        int eid=empService.findEmpIdByUsername(emp.getUsername());
        int rid=Integer.parseInt(choose);
        empService.addEmpRole(eid,rid);
        return "true";
    }

    //编辑用户
    @RequestMapping("editEmp.ajax")
    @ResponseBody
    public String editEmp(Emp emp,String choose)
    {
        empService.editEmp(emp);
        int rid=Integer.parseInt(choose);
        empService.editEmpRole(emp.getEmpId(),rid);
        return "true";
    }

    //删除用户
    @RequestMapping("deleteEmpById.ajax")
    @ResponseBody
    public String deleteEmpById(String id)
    {
        empService.deleteEmpById(id);
        return "";
    }

    //查找角色
    @RequestMapping("findAllRole.ajax")
    @ResponseBody
    public HashMap<String,Object> findAllRole()
    {
        HashMap<String,Object> map=new HashMap<>();
        List<Role> roles= roleService.findAllRole();
        map.put("roles",roles);
        return map;
    }

    @RequestMapping("findAllRoleByempId.ajax")
    @ResponseBody
    public HashMap<String,Object> findAllRoleByempId(String empId)
    {
        HashMap<String,Object> map=new HashMap<>();
        List<Role> roles= roleService.findAllRole();
        map.put("roles",roles);
        int eid=Integer.parseInt(empId);
        int rid=empService.findRoleByEmpId(eid);
        map.put("rid",rid);
        return map;
    }
}
