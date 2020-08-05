package com.hqyj.realm;

import com.hqyj.dao.EmpMapper;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

public class MyRealm extends AuthorizingRealm {
    @Autowired
    private EmpMapper empMapper;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        return null;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        UsernamePasswordToken upToken=(UsernamePasswordToken)token;

        String username=upToken.getUsername();

        System.out.println("从数据库中获取username"+"所对应的用户信息");


        Object principal=username;

        Object credentials =empMapper.findPassWordByName(username);
        System.out.println(credentials);
        String realmName=getName();
        System.out.println(realmName);

        SimpleAuthenticationInfo info = null; //new SimpleAuthenticationInfo(principal, credentials, realmName);
        info = new SimpleAuthenticationInfo(principal, credentials, realmName);
        return info;
    }
}
