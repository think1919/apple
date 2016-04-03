/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.apple.entity;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.util.Collection;

/**
 *
 * @author THINK
 */
@Entity
@Table(catalog = "betago", schema = "")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Region.findAll", query = "SELECT r FROM Region r"),
    @NamedQuery(name = "Region.findById", query = "SELECT r FROM Region r WHERE r.id = :id"),
    @NamedQuery(name = "Region.findByProvince", query = "SELECT r FROM Region r WHERE r.province = :province"),
    @NamedQuery(name = "Region.findByCity", query = "SELECT r FROM Region r WHERE r.city = :city"),
    @NamedQuery(name = "Region.findByDistrict", query = "SELECT r FROM Region r WHERE r.district = :district"),
    @NamedQuery(name = "Region.findByStreet", query = "SELECT r FROM Region r WHERE r.street = :street"),
    @NamedQuery(name = "Region.findByLongitude", query = "SELECT r FROM Region r WHERE r.longitude = :longitude"),
    @NamedQuery(name = "Region.findByLatitude", query = "SELECT r FROM Region r WHERE r.latitude = :latitude")})
public class Region implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 40)
    @Column(nullable = false, length = 40)
    private String id;
    @Size(max = 40)
    @Column(length = 40)
    private String province;
    @Size(max = 40)
    @Column(length = 40)
    private String city;
    @Size(max = 40)
    @Column(length = 40)
    private String district;
    @Size(max = 40)
    @Column(length = 40)
    private String street;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(precision = 12)
    private Float longitude;
    @Column(precision = 12)
    private Float latitude;

    @Transient
    private String shortName;

    public Region() {
    }

    public Region(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }
    @Transient
    public String getShortName() {

        int length = id.length();
        switch (length){
            case 9:
                if(street==null||street.trim().isEmpty()){
                    return district;
                }else {
                    return street;
                }
            case 6:
                return district;
            case 4:
                return city;
            default:
                return province;
        }
    }

    public void setShortName(String shortName) {
        this.shortName = shortName;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public Float getLongitude() {
        return longitude;
    }

    public void setLongitude(Float longitude) {
        this.longitude = longitude;
    }

    public Float getLatitude() {
        return latitude;
    }

    public void setLatitude(Float latitude) {
        this.latitude = latitude;
    }



    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Region)) {
            return false;
        }
        Region other = (Region) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "cn.apple.betago.entity.Region[ id=" + id + " ]";
    }
    
}
