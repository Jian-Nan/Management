package com.hqyj.realm;

import com.hqyj.dao.EmpMapper;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import java.security.Permissions;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class MyRealm extends AuthorizingRealm {
    @Autowired
    private EmpMapper empMapper;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        //System.out.println("进入授权方法了！！！");
        //测试授权
        //1.通过 principals获取用户信息
        String principal =(String) principalCollection.getPrimaryPrincipal();//得到用户名
        //2.给用户添加角色(以set集合方法添加),可能会通过数据库查询权限
        Set<String> roles = new HashSet<>();
        if(principal.equals("aa"))
        {
            roles.add("emp");
        }
        //查询数据库得到用户的权限
//        List<Permissions> permissionsList = prm.queryPermissionsByPersonName(principal);
//        for (Permissions p: permissionsList) {
//            roles.add(p.getPermissionsName());
//        }
        //3.返回new SimpleAuthorizationInfo(set集合的引用);
        return new SimpleAuthorizationInfo(roles);
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {

        System.out.println("进入了授权。。。。。。。。。。。。");
        UsernamePasswordToken upToken=(UsernamePasswordToken)token;

        String username=upToken.getUsername();

        System.out.println("从数据库中获取username"+"所对应的用户信息");


        Object principal=username;

        Object credentials =empMapper.findPassWordByName(username);

        System.out.println(credentials);
        //设置加盐
        ByteSource salt= ByteSource.Util.bytes(principal);

        String realmName=getName();


        System.out.println(realmName);

        SimpleAuthenticationInfo info = null; //new SimpleAuthenticationInfo(principal, credentials, realmName);
        info = new SimpleAuthenticationInfo(principal, credentials,salt,realmName);
        return info;
    }
    public static void main(String[] args) {
        //加密测试代码
        //设置加密方式
        String algorithmName="MD5";
        //设置待加密的原密码
        Object source="123456";
        //设置加盐方式(一般来说都是以用户名来加盐)
        Object salt= ByteSource.Util.bytes("aa");
        //加密次数
        int hashIterations=1024;
        SimpleHash newPassword=new SimpleHash(algorithmName, source, salt, hashIterations);
        System.out.println(newPassword.toString());
    }
}
