package com.hqyj.controller;

import com.hqyj.pojo.Emp;
import com.hqyj.pojo.MyPage;
import com.hqyj.service.EmpService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
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






    @RequestMapping("logout.do")
    public String logout() {
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        return "redirect:login.jsp";
    }


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

    @RequestMapping("addEmp.ajax")
    @ResponseBody
    public String addEmp(Emp emp)
    {
//        System.out.println(emp);
        empService.insertEmp(emp);
        return "true";
    }
}
