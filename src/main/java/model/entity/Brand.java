package model.entity;


public class Brand {

    private int id;
    private String name;
    private String logoUrl;

    public Brand() {
    }


    public Brand(int id, String name, String logoUrl) {
        this.id = id;
        this.name = name;
        this.logoUrl = logoUrl;
    }

    public String toString() {
        return "Brand {" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", logo='" + logoUrl + '\'' +
                '}';
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

    public String getLogoUrl() {
        return logoUrl;
    }

    public void setLogoUrl(String logoUrl) {
        this.logoUrl = logoUrl;
    }

}

