package com.hqyj.pojo;

import java.util.List;

public class Role extends MyPage{
    private Integer roleId;

    private String roleName;

    private Integer state;

    private Permission permission;

    public Permission getPermissions() {
        return permission;
    }

    public void setPermissions(Permission permissions) {
        this.permission = permissions;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }
}