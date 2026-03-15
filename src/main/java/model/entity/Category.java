package model.entity;

import java.util.ArrayList;
import java.util.List;

public class Category {

    private int id;
    private String name;
    private int parentID;

    private List<Category> children = new ArrayList<>();

    public List<Category> getChildren() {
        return children;
    }

    public void setChildren(List<Category> children) {
        this.children = children;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getParentId() {
        if (parentID <= 0) return 0;
        return parentID;
    }

    public void setParentId(int parentID) {
        this.parentID = parentID;
    }

    @Override
    public String toString() {
        return "Category [ id=" + id + ", name=" + name + ", parentID=" + parentID + " ]\n";
    }


}
