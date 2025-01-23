package com.boot.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.boot.common.web.controller.BaseController;
import com.boot.common.core.domain.AjaxResult;
import com.boot.common.mybatis.page.TableDataInfo;
import com.boot.common.core.enums.BusinessType;
import com.boot.common.log.annotation.Log;
import com.boot.common.core.utils.poi.ExcelUtil;
import com.boot.system.domain.SysPost;
import com.boot.system.service.ISysPostService;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 岗位信息操作处理
 *
 * @author boot
 */
@RestController
@RequestMapping("/system/post")
public class SysPostController extends BaseController {
    @Autowired
    private ISysPostService postService;

    /**
     * 获取岗位列表
     */
    @SaCheckPermission("system:post:list")
    @GetMapping("/list")
    public TableDataInfo list(SysPost post) {
        startPage();
        List<SysPost> list = postService.selectPostList(post);
        return getDataTable(list);
    }

    @Log(title = "岗位管理", businessType = BusinessType.EXPORT)
    @SaCheckPermission("system:post:export")
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysPost post) {
        List<SysPost> list = postService.selectPostList(post);
        ExcelUtil<SysPost> util = new ExcelUtil<SysPost>(SysPost.class);
        util.exportExcel(response, list, "岗位数据");
    }

    /**
     * 根据岗位编号获取详细信息
     */
    @SaCheckPermission("system:post:query")
    @GetMapping(value = "/{postId}")
    public AjaxResult getInfo(@PathVariable Long postId) {
        return success(postService.selectPostById(postId));
    }

    /**
     * 新增岗位
     */
    @SaCheckPermission("system:post:add")
    @Log(title = "岗位管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody SysPost post) {
        if (!postService.checkPostNameUnique(post)) {
            return error("新增岗位'" + post.getPostName() + "'失败，岗位名称已存在");
        } else if (!postService.checkPostCodeUnique(post)) {
            return error("新增岗位'" + post.getPostName() + "'失败，岗位编码已存在");
        }
        post.setCreateBy(getUserName());
        return toAjax(postService.insertPost(post));
    }

    /**
     * 修改岗位
     */
    @SaCheckPermission("system:post:edit")
    @Log(title = "岗位管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody SysPost post) {
        if (!postService.checkPostNameUnique(post)) {
            return error("修改岗位'" + post.getPostName() + "'失败，岗位名称已存在");
        } else if (!postService.checkPostCodeUnique(post)) {
            return error("修改岗位'" + post.getPostName() + "'失败，岗位编码已存在");
        }
        post.setUpdateBy(getUserName());
        return toAjax(postService.updatePost(post));
    }

    /**
     * 删除岗位
     */
    @SaCheckPermission("system:post:remove")
    @Log(title = "岗位管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{postIds}")
    public AjaxResult remove(@PathVariable Long[] postIds) {
        return toAjax(postService.deletePostByIds(postIds));
    }

    /**
     * 获取岗位选择框列表
     */
    @GetMapping("/optionselect")
    public AjaxResult optionselect() {
        List<SysPost> posts = postService.selectPostAll();
        return success(posts);
    }
}
