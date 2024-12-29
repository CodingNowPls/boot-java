package com.boot.easyswagger.entity;

import java.util.HashMap;
import java.util.Map;

public class ApiDoc {
    public String description;
    public String controllerDescription;
    public String controllerClass;
    public String methodName;
    public Map<String, String> params = new HashMap<>();
}
