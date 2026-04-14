package model.entity;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

public class Role {
    private int id;

    @ColumnName("role_name")
    private String roleName;
    private String permissions;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getRoleName() { return roleName; }
    public void setRoleName(String roleName) { this.roleName = roleName; }

    public String getPermissions() { return permissions; }
    public void setPermissions(String permissions) { this.permissions = permissions; }

    public List<String> getPermissionsList() {
        if (this.permissions == null || this.permissions.trim().isEmpty()) {
            return new ArrayList<>();
        }
        Gson gson = new Gson();
        Type listType = new TypeToken<List<String>>(){}.getType();
        return gson.fromJson(this.permissions, listType);
    }

    @Override
    public String toString() {
        return "Role{id=" + id + ", roleName='" + roleName + "', permissions=" + getPermissionsList() + '}';
    }
}