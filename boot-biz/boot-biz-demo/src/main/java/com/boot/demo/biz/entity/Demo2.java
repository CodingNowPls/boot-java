package com.boot.demo.biz.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("demo2")
public class Demo2 {


    private Long id;
    private String name;

}
