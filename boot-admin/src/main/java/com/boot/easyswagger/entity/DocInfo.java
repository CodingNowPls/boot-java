package com.boot.easyswagger.entity;

import java.util.HashMap;
import java.util.Map;

public class DocInfo {
    public Map<String, ApiDoc> apiMap = new HashMap<>();
    public Map<String, ModelDoc> modelMap = new HashMap<>();
}
