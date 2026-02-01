package com.nutrition.backend.model;

import jakarta.persistence.*;
// import lombok.Data;
import java.util.List;

@Entity
public class Product {

    @Id
    @Column(name = "code")
    private String barcode;

    @Column(name = "name")
    private String name;
    @Column(name = "brand")
    private String brand;
    @Column(name = "image_url", length = 2048)
    private String imageUrl;

    @Column(name = "nutri_score")
    private String nutriScore;
    @Column(name = "nova_group")
    private Integer novaGroup;

    // ... (skipping interim lines if possible, but replace_file_content needs
    // contiguous block or I use multi_replace.
    // Wait, the field is at line 24. methods are at line 77.
    // I should use multi_replace for this.

    @Column(name = "ingredients", columnDefinition = "TEXT")
    private String ingredients;

    private double protein;
    private double carbs;
    private double fat;
    private double fiber;
    private double sugar;
    private double salt;

    public String getBarcode() {
        return barcode;
    }

    public void setBarcode(String barcode) {
        this.barcode = barcode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getNutriScore() {
        return nutriScore;
    }

    public void setNutriScore(String nutriScore) {
        this.nutriScore = nutriScore;
    }

    public Integer getNovaGroup() {
        return novaGroup;
    }

    public void setNovaGroup(Integer novaGroup) {
        this.novaGroup = novaGroup;
    }

    public String getIngredients() {
        return ingredients;
    }

    public void setIngredients(String ingredients) {
        this.ingredients = ingredients;
    }

    public double getProtein() {
        return protein;
    }

    public void setProtein(double protein) {
        this.protein = protein;
    }

    public double getCarbs() {
        return carbs;
    }

    public void setCarbs(double carbs) {
        this.carbs = carbs;
    }

    public double getFat() {
        return fat;
    }

    public void setFat(double fat) {
        this.fat = fat;
    }

    public double getFiber() {
        return fiber;
    }

    public void setFiber(double fiber) {
        this.fiber = fiber;
    }

    public double getSugar() {
        return sugar;
    }

    public void setSugar(double sugar) {
        this.sugar = sugar;
    }

    public double getSalt() {
        return salt;
    }

    public void setSalt(double salt) {
        this.salt = salt;
    }
}
