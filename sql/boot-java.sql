/*
Navicat MySQL Data Transfer

Source Server         : 本地mysql
Source Server Version : 50719
Source Host           : localhost:3306
Source Database       : boot-java

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2025-12-01 13:19:52
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for demo2
-- ----------------------------
DROP TABLE IF EXISTS `demo2`;
CREATE TABLE `demo2` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of demo2
-- ----------------------------

-- ----------------------------
-- Table structure for flw_ext_instance
-- ----------------------------
DROP TABLE IF EXISTS `flw_ext_instance`;
CREATE TABLE `flw_ext_instance` (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `tenant_id` varchar(50) DEFAULT NULL COMMENT '租户ID',
  `process_id` bigint(20) NOT NULL COMMENT '流程定义ID',
  `process_name` varchar(100) DEFAULT NULL COMMENT '流程名称',
  `process_type` varchar(100) DEFAULT NULL COMMENT '流程类型',
  `model_content` text COMMENT '流程模型定义JSON内容',
  PRIMARY KEY (`id`) USING BTREE,
  CONSTRAINT `fk_ext_instance_id` FOREIGN KEY (`id`) REFERENCES `flw_his_instance` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='扩展流程实例表';

-- ----------------------------
-- Records of flw_ext_instance
-- ----------------------------

-- ----------------------------
-- Table structure for flw_his_instance
-- ----------------------------
DROP TABLE IF EXISTS `flw_his_instance`;
CREATE TABLE `flw_his_instance` (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `tenant_id` varchar(50) DEFAULT NULL COMMENT '租户ID',
  `create_id` varchar(50) NOT NULL COMMENT '创建人ID',
  `create_by` varchar(50) NOT NULL COMMENT '创建人名称',
  `create_time` timestamp NOT NULL COMMENT '创建时间',
  `process_id` bigint(20) NOT NULL COMMENT '流程定义ID',
  `parent_instance_id` bigint(20) DEFAULT NULL COMMENT '父流程实例ID',
  `priority` tinyint(1) DEFAULT NULL COMMENT '优先级',
  `instance_no` varchar(50) DEFAULT NULL COMMENT '流程实例编号',
  `business_key` varchar(100) DEFAULT NULL COMMENT '业务KEY',
  `variable` text COMMENT '变量json',
  `current_node_name` varchar(100) NOT NULL COMMENT '当前所在节点名称',
  `current_node_key` varchar(100) NOT NULL COMMENT '当前所在节点key',
  `expire_time` timestamp NULL DEFAULT NULL COMMENT '期望完成时间',
  `last_update_by` varchar(50) DEFAULT NULL COMMENT '上次更新人',
  `last_update_time` timestamp NULL DEFAULT NULL COMMENT '上次更新时间',
  `instance_state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 0，审批中 1，审批通过 2，审批拒绝 3，撤销审批 4，超时结束 5，强制终止',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '结束时间',
  `duration` bigint(20) DEFAULT NULL COMMENT '处理耗时',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_his_instance_process_id` (`process_id`) USING BTREE,
  CONSTRAINT `fk_his_instance_process_id` FOREIGN KEY (`process_id`) REFERENCES `flw_process` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='历史流程实例表';

-- ----------------------------
-- Records of flw_his_instance
-- ----------------------------

-- ----------------------------
-- Table structure for flw_his_task
-- ----------------------------
DROP TABLE IF EXISTS `flw_his_task`;
CREATE TABLE `flw_his_task` (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `tenant_id` varchar(50) DEFAULT NULL COMMENT '租户ID',
  `create_id` varchar(50) NOT NULL COMMENT '创建人ID',
  `create_by` varchar(50) NOT NULL COMMENT '创建人名称',
  `create_time` timestamp NOT NULL COMMENT '创建时间',
  `instance_id` bigint(20) NOT NULL COMMENT '流程实例ID',
  `parent_task_id` bigint(20) DEFAULT NULL COMMENT '父任务ID',
  `call_process_id` bigint(20) DEFAULT NULL COMMENT '调用外部流程定义ID',
  `call_instance_id` bigint(20) DEFAULT NULL COMMENT '调用外部流程实例ID',
  `task_name` varchar(100) NOT NULL COMMENT '任务名称',
  `task_key` varchar(100) NOT NULL COMMENT '任务 key 唯一标识',
  `task_type` tinyint(1) NOT NULL COMMENT '任务类型',
  `perform_type` tinyint(1) DEFAULT NULL COMMENT '参与类型',
  `action_url` varchar(200) DEFAULT NULL COMMENT '任务处理的url',
  `variable` text COMMENT '变量json',
  `assignor_id` varchar(100) DEFAULT NULL COMMENT '委托人ID',
  `assignor` varchar(255) DEFAULT NULL COMMENT '委托人',
  `expire_time` timestamp NULL DEFAULT NULL COMMENT '任务期望完成时间',
  `remind_time` timestamp NULL DEFAULT NULL COMMENT '提醒时间',
  `remind_repeat` tinyint(1) NOT NULL DEFAULT '0' COMMENT '提醒次数',
  `viewed` tinyint(1) NOT NULL DEFAULT '0' COMMENT '已阅 0，否 1，是',
  `finish_time` timestamp NULL DEFAULT NULL COMMENT '任务完成时间',
  `task_state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '任务状态 0，活动 1，跳转 2，完成 3，拒绝 4，撤销审批  5，超时 6，终止 7，驳回终止',
  `duration` bigint(20) DEFAULT NULL COMMENT '处理耗时',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_his_task_instance_id` (`instance_id`) USING BTREE,
  KEY `idx_his_task_parent_task_id` (`parent_task_id`) USING BTREE,
  CONSTRAINT `fk_his_task_instance_id` FOREIGN KEY (`instance_id`) REFERENCES `flw_his_instance` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='历史任务表';

-- ----------------------------
-- Records of flw_his_task
-- ----------------------------

-- ----------------------------
-- Table structure for flw_his_task_actor
-- ----------------------------
DROP TABLE IF EXISTS `flw_his_task_actor`;
CREATE TABLE `flw_his_task_actor` (
  `id` bigint(20) NOT NULL COMMENT '主键 ID',
  `tenant_id` varchar(50) DEFAULT NULL COMMENT '租户ID',
  `instance_id` bigint(20) NOT NULL COMMENT '流程实例ID',
  `task_id` bigint(20) NOT NULL COMMENT '任务ID',
  `actor_id` varchar(100) NOT NULL COMMENT '参与者ID',
  `actor_name` varchar(100) NOT NULL COMMENT '参与者名称',
  `actor_type` int(11) NOT NULL COMMENT '参与者类型 0，用户 1，角色 2，部门',
  `weight` int(11) DEFAULT NULL COMMENT '权重，票签任务时，该值为不同处理人员的分量比例，代理任务时，该值为 1 时为代理人',
  `agent_id` varchar(100) DEFAULT NULL COMMENT '代理人ID',
  `agent_type` int(11) DEFAULT NULL COMMENT '代理人类型 0，代理 1，被代理 2，认领角色 3，认领部门',
  `extend` text COMMENT '扩展json',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_his_task_actor_task_id` (`task_id`) USING BTREE,
  CONSTRAINT `fk_his_task_actor_task_id` FOREIGN KEY (`task_id`) REFERENCES `flw_his_task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='历史任务参与者表';

-- ----------------------------
-- Records of flw_his_task_actor
-- ----------------------------

-- ----------------------------
-- Table structure for flw_instance
-- ----------------------------
DROP TABLE IF EXISTS `flw_instance`;
CREATE TABLE `flw_instance` (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `tenant_id` varchar(50) DEFAULT NULL COMMENT '租户ID',
  `create_id` varchar(50) NOT NULL COMMENT '创建人ID',
  `create_by` varchar(50) NOT NULL COMMENT '创建人名称',
  `create_time` timestamp NOT NULL COMMENT '创建时间',
  `process_id` bigint(20) NOT NULL COMMENT '流程定义ID',
  `parent_instance_id` bigint(20) DEFAULT NULL COMMENT '父流程实例ID',
  `priority` tinyint(1) DEFAULT NULL COMMENT '优先级',
  `instance_no` varchar(50) DEFAULT NULL COMMENT '流程实例编号',
  `business_key` varchar(100) DEFAULT NULL COMMENT '业务KEY',
  `variable` text COMMENT '变量json',
  `current_node_name` varchar(100) NOT NULL COMMENT '当前所在节点名称',
  `current_node_key` varchar(100) NOT NULL COMMENT '当前所在节点key',
  `expire_time` timestamp NULL DEFAULT NULL COMMENT '期望完成时间',
  `last_update_by` varchar(50) DEFAULT NULL COMMENT '上次更新人',
  `last_update_time` timestamp NULL DEFAULT NULL COMMENT '上次更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_instance_process_id` (`process_id`) USING BTREE,
  CONSTRAINT `fk_instance_process_id` FOREIGN KEY (`process_id`) REFERENCES `flw_process` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='流程实例表';

-- ----------------------------
-- Records of flw_instance
-- ----------------------------

-- ----------------------------
-- Table structure for flw_process
-- ----------------------------
DROP TABLE IF EXISTS `flw_process`;
CREATE TABLE `flw_process` (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `tenant_id` varchar(50) DEFAULT NULL COMMENT '租户ID',
  `create_id` varchar(50) NOT NULL COMMENT '创建人ID',
  `create_by` varchar(50) NOT NULL COMMENT '创建人名称',
  `create_time` timestamp NOT NULL COMMENT '创建时间',
  `process_key` varchar(100) NOT NULL COMMENT '流程定义 key 唯一标识',
  `process_name` varchar(100) NOT NULL COMMENT '流程定义名称',
  `process_icon` varchar(255) DEFAULT NULL COMMENT '流程图标地址',
  `process_type` varchar(100) DEFAULT NULL COMMENT '流程类型',
  `process_version` int(11) NOT NULL DEFAULT '1' COMMENT '流程版本，默认 1',
  `instance_url` varchar(200) DEFAULT NULL COMMENT '实例地址',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注说明',
  `use_scope` tinyint(1) NOT NULL DEFAULT '0' COMMENT '使用范围 0，全员 1，指定人员（业务关联） 2，均不可提交',
  `process_state` tinyint(1) NOT NULL DEFAULT '1' COMMENT '流程状态 0，不可用 1，可用 2，历史版本',
  `model_content` text COMMENT '流程模型定义JSON内容',
  `sort` tinyint(1) DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_process_name` (`process_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='流程定义表';

-- ----------------------------
-- Records of flw_process
-- ----------------------------

-- ----------------------------
-- Table structure for flw_task
-- ----------------------------
DROP TABLE IF EXISTS `flw_task`;
CREATE TABLE `flw_task` (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `tenant_id` varchar(50) DEFAULT NULL COMMENT '租户ID',
  `create_id` varchar(50) NOT NULL COMMENT '创建人ID',
  `create_by` varchar(50) NOT NULL COMMENT '创建人名称',
  `create_time` timestamp NOT NULL COMMENT '创建时间',
  `instance_id` bigint(20) NOT NULL COMMENT '流程实例ID',
  `parent_task_id` bigint(20) DEFAULT NULL COMMENT '父任务ID',
  `task_name` varchar(100) NOT NULL COMMENT '任务名称',
  `task_key` varchar(100) NOT NULL COMMENT '任务 key 唯一标识',
  `task_type` tinyint(1) NOT NULL COMMENT '任务类型',
  `perform_type` tinyint(1) DEFAULT NULL COMMENT '参与类型',
  `action_url` varchar(200) DEFAULT NULL COMMENT '任务处理的url',
  `variable` text COMMENT '变量json',
  `assignor_id` varchar(100) DEFAULT NULL COMMENT '委托人ID',
  `assignor` varchar(255) DEFAULT NULL COMMENT '委托人',
  `expire_time` timestamp NULL DEFAULT NULL COMMENT '任务期望完成时间',
  `remind_time` timestamp NULL DEFAULT NULL COMMENT '提醒时间',
  `remind_repeat` tinyint(1) NOT NULL DEFAULT '0' COMMENT '提醒次数',
  `viewed` tinyint(1) NOT NULL DEFAULT '0' COMMENT '已阅 0，否 1，是',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_task_instance_id` (`instance_id`) USING BTREE,
  CONSTRAINT `fk_task_instance_id` FOREIGN KEY (`instance_id`) REFERENCES `flw_instance` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='任务表';

-- ----------------------------
-- Records of flw_task
-- ----------------------------

-- ----------------------------
-- Table structure for flw_task_actor
-- ----------------------------
DROP TABLE IF EXISTS `flw_task_actor`;
CREATE TABLE `flw_task_actor` (
  `id` bigint(20) NOT NULL COMMENT '主键 ID',
  `tenant_id` varchar(50) DEFAULT NULL COMMENT '租户ID',
  `instance_id` bigint(20) NOT NULL COMMENT '流程实例ID',
  `task_id` bigint(20) NOT NULL COMMENT '任务ID',
  `actor_id` varchar(100) NOT NULL COMMENT '参与者ID',
  `actor_name` varchar(100) NOT NULL COMMENT '参与者名称',
  `actor_type` int(11) NOT NULL COMMENT '参与者类型 0，用户 1，角色 2，部门',
  `weight` int(11) DEFAULT NULL COMMENT '权重，票签任务时，该值为不同处理人员的分量比例，代理任务时，该值为 1 时为代理人',
  `agent_id` varchar(100) DEFAULT NULL COMMENT '代理人ID',
  `agent_type` int(11) DEFAULT NULL COMMENT '代理人类型 0，代理 1，被代理 2，认领角色 3，认领部门',
  `extend` text COMMENT '扩展json',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_task_actor_task_id` (`task_id`) USING BTREE,
  CONSTRAINT `fk_task_actor_task_id` FOREIGN KEY (`task_id`) REFERENCES `flw_task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='任务参与者表';

-- ----------------------------
-- Records of flw_task_actor
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table` (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
  `code_type` char(1) DEFAULT '1' COMMENT '生成代码风格（0原生mybatis 1增强mybatis-plus）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='代码生成业务表';

-- ----------------------------
-- Records of gen_table
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column` (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='代码生成业务表字段';

-- ----------------------------
-- Records of onl_drag_table_relation
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Blob类型的触发器表';

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='日历信息表';

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Cron类型的触发器表';

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint(13) NOT NULL COMMENT '触发的时间',
  `sched_time` bigint(13) NOT NULL COMMENT '定时器制定的时间',
  `priority` int(11) NOT NULL COMMENT '优先级',
  `state` varchar(16) NOT NULL COMMENT '状态',
  `job_name` varchar(200) DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='已触发的触发器表';

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) NOT NULL COMMENT '任务组名',
  `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='任务详细信息表';

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='存储的悲观锁信息表';

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='暂停的触发器表';

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint(13) NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint(13) NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='调度器状态表';

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint(7) NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint(12) NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint(10) NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='简单触发器的信息表';

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int(11) DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int(11) DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint(20) DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint(20) DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='同步机制的行锁表';

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint(13) DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint(13) DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int(11) DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) NOT NULL COMMENT '触发器的类型',
  `start_time` bigint(13) NOT NULL COMMENT '开始时间',
  `end_time` bigint(13) DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint(2) DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='触发器详细信息表';

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for rep_demo_dxtj
-- ----------------------------
DROP TABLE IF EXISTS `rep_demo_dxtj`;
CREATE TABLE `rep_demo_dxtj` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `name` varchar(50) DEFAULT NULL COMMENT '姓名',
  `gtime` datetime DEFAULT NULL COMMENT '雇佣日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '职务',
  `jphone` varchar(125) DEFAULT NULL COMMENT '家庭电话',
  `birth` datetime DEFAULT NULL COMMENT '出生日期',
  `hukou` varchar(32) DEFAULT NULL COMMENT '户口所在地',
  `laddress` varchar(125) DEFAULT NULL COMMENT '联系地址',
  `jperson` varchar(32) DEFAULT NULL COMMENT '紧急联系人',
  `sex` varchar(32) DEFAULT NULL COMMENT 'xingbie',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of rep_demo_dxtj
-- ----------------------------
INSERT INTO `rep_demo_dxtj` VALUES ('1338808084247613441', '张三', '2019-11-06 00:00:00', '1', '18034596970', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '1');
INSERT INTO `rep_demo_dxtj` VALUES ('13388080842476134411', '张三', '2019-11-06 00:00:00', '1', '18034596970', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '1');
INSERT INTO `rep_demo_dxtj` VALUES ('1338809169074982920', '张小哲', '2019-11-06 00:00:00', '2', '18034596971', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '1');
INSERT INTO `rep_demo_dxtj` VALUES ('1338809448658898952', '闫妮', '2019-11-06 00:00:00', '2', '18034596972', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '1');
INSERT INTO `rep_demo_dxtj` VALUES ('1338809620973490184', '陌生', '2019-11-06 00:00:00', '2', '18034596973', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '1');
INSERT INTO `rep_demo_dxtj` VALUES ('1338809652606930952', '贺江', '2019-11-06 00:00:00', '2', '18034596974', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '2');
INSERT INTO `rep_demo_dxtj` VALUES ('1338809685200867336', '村子明', '2019-11-06 00:00:00', '3', '18034596975', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '2');
INSERT INTO `rep_demo_dxtj` VALUES ('1338809710203113481', '尚德', '2019-11-06 00:00:00', '4', '18034596977', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '1');
INSERT INTO `rep_demo_dxtj` VALUES ('1338809749470187528', '郑恺', '2019-11-06 00:00:00', '4', '18034596978', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '1');
INSERT INTO `rep_demo_dxtj` VALUES ('1338809774971555849', '未名园', '2019-11-06 00:00:00', '4', '18034596970', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '1');
INSERT INTO `rep_demo_dxtj` VALUES ('1338809805199904777', '韩寒', '2019-11-06 00:00:00', '5', '18034596970', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '1');
INSERT INTO `rep_demo_dxtj` VALUES ('1338809830017601544', '迪丽热拉', '2019-11-06 00:00:00', '6', '18034596970', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '1');
INSERT INTO `rep_demo_dxtj` VALUES ('1338809864356368393', '张一山', '2019-11-06 00:00:00', '6', '18034596970', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '1');
INSERT INTO `rep_demo_dxtj` VALUES ('1339160157602480137', '张三', '2019-11-06 00:00:00', '1', '18034596970', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '1');
INSERT INTO `rep_demo_dxtj` VALUES ('1339160157602480146', '张大大', '2019-11-06 00:00:00', '2', '18034596971', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '1');
INSERT INTO `rep_demo_dxtj` VALUES ('1339160157606674439', '郭美美', '2019-11-06 00:00:00', '2', '18034596972', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '1');
INSERT INTO `rep_demo_dxtj` VALUES ('1339160157606674448', '莫愁', '2019-11-06 00:00:00', '2', '18034596973', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '1');
INSERT INTO `rep_demo_dxtj` VALUES ('1339160157606674457', '鲁与', '2019-11-06 00:00:00', '2', '18034596974', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '2');
INSERT INTO `rep_demo_dxtj` VALUES ('1339160157606674466', '高尚', '2019-11-06 00:00:00', '3', '18034596975', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '2');
INSERT INTO `rep_demo_dxtj` VALUES ('1339160157606674475', '尚北京', '2019-11-06 00:00:00', '4', '18034596977', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '1');
INSERT INTO `rep_demo_dxtj` VALUES ('1339160157606674484', '杨颖花', '2019-11-06 00:00:00', '4', '18034596978', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '1');
INSERT INTO `rep_demo_dxtj` VALUES ('1339160157606674493', '李丽', '2019-11-06 00:00:00', '4', '18034596970', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '1');
INSERT INTO `rep_demo_dxtj` VALUES ('1339160157606674502', '韩露露', '2019-11-06 00:00:00', '5', '18034596970', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '1');
INSERT INTO `rep_demo_dxtj` VALUES ('1339160157606674511', '李凯泽', '2019-11-06 00:00:00', '6', '18034596970', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '1');
INSERT INTO `rep_demo_dxtj` VALUES ('1339160157606674520', '王明阳', '2019-11-06 00:00:00', '6', '18034596970', '1988-12-15 00:00:00', '北京市朝阳区奥运村街道亚运村小区', '18034596972', '王亮', '1');

-- ----------------------------
-- Table structure for rep_demo_employee
-- ----------------------------
DROP TABLE IF EXISTS `rep_demo_employee`;
CREATE TABLE `rep_demo_employee` (
  `id` varchar(10) NOT NULL COMMENT '主键',
  `num` varchar(50) DEFAULT NULL COMMENT '编号',
  `name` varchar(100) DEFAULT NULL COMMENT '姓名',
  `sex` varchar(10) DEFAULT NULL COMMENT '性别',
  `birthday` datetime DEFAULT NULL COMMENT '出生日期',
  `nation` varchar(30) DEFAULT NULL COMMENT '民族',
  `political` varchar(30) DEFAULT NULL COMMENT '政治面貌',
  `native_place` varchar(30) DEFAULT NULL COMMENT '籍贯',
  `height` varchar(30) DEFAULT NULL COMMENT '身高',
  `weight` varchar(30) DEFAULT NULL COMMENT '体重',
  `health` varchar(30) DEFAULT NULL COMMENT '健康状况',
  `id_card` varchar(80) DEFAULT NULL COMMENT '身份证号',
  `education` varchar(30) DEFAULT NULL COMMENT '学历',
  `school` varchar(80) DEFAULT NULL COMMENT '毕业学校',
  `major` varchar(80) DEFAULT NULL COMMENT '专业',
  `address` varchar(100) DEFAULT NULL COMMENT '联系地址',
  `zip_code` varchar(30) DEFAULT NULL COMMENT '邮编',
  `email` varchar(30) DEFAULT NULL COMMENT 'Email',
  `phone` varchar(30) DEFAULT NULL COMMENT '手机号',
  `foreign_language` varchar(30) DEFAULT NULL COMMENT '外语语种',
  `foreign_language_level` varchar(30) DEFAULT NULL COMMENT '外语水平',
  `computer_level` varchar(30) DEFAULT NULL COMMENT '计算机水平',
  `graduation_time` datetime DEFAULT NULL COMMENT '毕业时间',
  `arrival_time` datetime DEFAULT NULL COMMENT '到职时间',
  `positional_titles` varchar(30) DEFAULT NULL COMMENT '职称',
  `education_experience` text COMMENT '教育经历',
  `work_experience` text COMMENT '工作经历',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `del_flag` tinyint(1) DEFAULT NULL COMMENT '删除标识0-正常,1-已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of rep_demo_employee
-- ----------------------------
INSERT INTO `rep_demo_employee` VALUES ('1', '001', '张三', '男', '2000-02-04 13:36:19', '汉族', '团员', '北京', '170', '65', '良好', '110101200002044853', '大专', '北京科技', '计算机', '北京朝阳区', '1001', 'zhang@163.com', '18011111111', '英语', '三级', '三级', '2019-02-04 13:41:17', '2020-02-04 13:41:31', '项目经理', '2018年9月—2019年7月：北京语言文化大学比较文学研究所攻读博士学位，获得比较文学博士学位', '2019年5月---至今 XX公司     网络系统工程师  \n2019年5月---至今 XX公司     网络系统工程师', null, '2020-02-04 15:18:03', null, null, null);
INSERT INTO `rep_demo_employee` VALUES ('2', '002', '王红', '女', '2000-02-04 13:36:19', '汉族', '团员', '北京', '170', '65', '良好', '110101200002044853', '大专', '北京科技', '计算机', '北京朝阳区', '1001', 'zhang@163.com', '18011111111', '英语', '三级', '三级', '2019-02-04 13:41:17', '2020-02-04 13:41:31', '项目经理', '2018年9月—2019年7月：北京语言文化大学比较文学研究所攻读博士学位，获得比较文学博士学位', '2019年5月---至今 XX公司     网络系统工程师  \n2019年5月---至今 XX公司     网络系统工程师', null, '2020-02-04 18:39:27', null, null, null);

-- ----------------------------
-- Table structure for rep_demo_gongsi
-- ----------------------------
DROP TABLE IF EXISTS `rep_demo_gongsi`;
CREATE TABLE `rep_demo_gongsi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gname` varchar(125) NOT NULL COMMENT '货品名称',
  `gdata` varchar(255) NOT NULL COMMENT '返利',
  `tdata` varchar(125) NOT NULL COMMENT '备注',
  `didian` varchar(255) NOT NULL,
  `zhaiyao` varchar(255) NOT NULL,
  `num` varchar(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of rep_demo_gongsi
-- ----------------------------
INSERT INTO `rep_demo_gongsi` VALUES ('1', '北京天山海世界', '2020-02-30 11:12:25', '2020-02-25', '天山大厦', '1', '2399845661');
INSERT INTO `rep_demo_gongsi` VALUES ('2', 'dd天山海世界', '2020-02-30 11:12:25', '2020-02-25', '天山大厦', '1', '2399845661');

-- ----------------------------
-- Table structure for rep_demo_jianpiao
-- ----------------------------
DROP TABLE IF EXISTS `rep_demo_jianpiao`;
CREATE TABLE `rep_demo_jianpiao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bnum` varchar(125) NOT NULL,
  `ftime` varchar(125) NOT NULL,
  `sfkong` varchar(125) NOT NULL,
  `kaishi` varchar(125) NOT NULL,
  `jieshu` varchar(125) NOT NULL,
  `hezairen` varchar(125) NOT NULL,
  `jpnum` varchar(125) NOT NULL,
  `shihelv` varchar(125) NOT NULL,
  `s_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of rep_demo_jianpiao
-- ----------------------------
INSERT INTO `rep_demo_jianpiao` VALUES ('1', 'K7725', '21:13', '否', '秦皇岛', '邯郸', '300', '258', '86', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('2', 'k99', '16:55', '否', '包头', '广州', '800', '700', '88', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('3', 'G6737', '05:34', '否', '北京西', '邯郸东', '500', '256', '51', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('4', 'K7705', '07:03', '否', '北京', '邯郸', '400', '200', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('5', 'G437', '06:27', '否', '北京西', '兰州西', '800', '586', '73', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('6', 'G673', '06:32', '否', '北京西', '邯郸东', '300', '289', '87', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('7', 'G507', '06:43', '否', '北京西', '邯郸东', '300', '200', '67', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('8', 'G89', '06:53', '否', '北京西', '成都东', '800', '500', '62', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('9', 'K7712', '09:43', '否', '北京西', '西安北', '400', '200', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('10', 'G405', '10:05', '否', '北京西', '昆明南', '300', '200', '67', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('11', 'G6701', '10:38', '否', '北京西', '石家庄', '300', '200', '67', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('12', 'G487', '10:52', '否', '北京西', '南昌西', '800', '700', '88', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('13', 'G607', '11:14', '否', '北京西', '太原南', '400', '200', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('14', 'G667', '11:19', '否', '北京西', '西安北', '400', '200', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('15', 'Z49', '11:28', '否', '北京西', '成都', '400', '200', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('16', 'Z49', '11:28', '否', '北京西', '上海', '300', '200', '80', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('17', 'Z49', '11:56', '否', '北京西', '上海', '200', '180', '95', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('18', 'Z49', '11:36', '否', '北京南', '大晒', '200', '180', '96', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('19', 'Z123', '12:00', '否', '北京南', '重庆', '1000', '1000', '100', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('20', 'G78', '13:56', '否', '北京东', '厦门北', '800', '700', '90', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('21', 'G56', '18:36', '否', '上海西', '深圳', '800', '700', '90', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('22', 'H78', '12:00', '否', '上海', '北京西', '800', '700', '90', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('23', 'H78', '12:00', '否', '上海', '北京西', '800', '700', '90', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('24', 'H78', '12:00', '否', '上海', '北京西', '800', '700', '90', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('25', 'H78', '12:00', '否', '北京西', '南昌', '800', '700', '90', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('26', 'G70', '7:23', '是', '北京西', '厦门', '500', '450', '95', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('27', 'G14', '9:50', '是', '北京西', '上海', '800', '700', '95', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('28', 'G90', '8:30', '是', '北京南', '武昌', '1000', '1000', '100', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('29', 'G25', '7:56', '是', '厦门北', '福州', '500', '100', '20', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('30', 'G50', '14:23', '否', '北京西', '深圳', '500', '100', '20', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('31', 'G10', '13:00', '否', '北京西', '深圳', '500', '100', '20', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('32', 'G10', '13:00', '否', '北京西', '深圳', '500', '100', '20', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('33', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('34', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('35', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('36', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('37', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('38', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('39', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('40', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('41', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('42', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('43', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('44', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('45', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('46', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('47', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('48', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('49', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('50', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('51', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('52', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('53', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('54', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('55', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('56', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('57', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('58', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('59', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('60', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('61', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('62', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('63', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('64', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('65', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('66', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('67', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('68', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('69', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('70', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('71', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('72', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('73', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('74', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('75', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('76', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('77', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('78', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('79', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('80', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('81', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('82', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('83', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('84', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('85', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');
INSERT INTO `rep_demo_jianpiao` VALUES ('86', 'G10', '13:00', '否', '北京西', '深圳', '200', '100', '50', '1');

-- ----------------------------
-- Table structure for rep_demo_xiaoshou
-- ----------------------------
DROP TABLE IF EXISTS `rep_demo_xiaoshou`;
CREATE TABLE `rep_demo_xiaoshou` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hnum` varchar(125) NOT NULL COMMENT '货品编码',
  `hname` varchar(125) NOT NULL COMMENT '货品名称',
  `xinghao` varchar(125) NOT NULL COMMENT '单位',
  `fahuocangku` varchar(125) NOT NULL COMMENT '数量',
  `danwei` varchar(125) NOT NULL COMMENT '单价',
  `num` int(11) NOT NULL COMMENT '返利',
  `danjia` varchar(125) NOT NULL COMMENT '备注',
  `zhekoulv` int(11) NOT NULL,
  `xiaoshoujine` varchar(125) NOT NULL,
  `beizhu` varchar(125) DEFAULT NULL,
  `s_id` varchar(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of rep_demo_xiaoshou
-- ----------------------------
INSERT INTO `rep_demo_xiaoshou` VALUES ('1', '5896', '冰箱', 'H2563', '上海', '件', '300', '1', '20', '1000', '晚上送', '1');
INSERT INTO `rep_demo_xiaoshou` VALUES ('2', '4596', '空调', 'M79', '上海', '件', '800', '2', '10', '2560', '上门安装', '1');
INSERT INTO `rep_demo_xiaoshou` VALUES ('3', '3695', '洗衣机', 'H90', '杭州', '件', '500', '3', '50', '259', '', '1');
INSERT INTO `rep_demo_xiaoshou` VALUES ('4', '1258', '微波炉', 'J89', '广州', '件', '400', '4', '20', '259', '多个排水管', '1');
INSERT INTO `rep_demo_xiaoshou` VALUES ('5', '1258', '烤箱', 'K56', '广州', '件', '800', '5', '50', '368', '', '1');
INSERT INTO `rep_demo_xiaoshou` VALUES ('6', '5623', '电饼铛', 'H56', '上海', '件', '300', '6', '40', '456', '中午送', '1');
INSERT INTO `rep_demo_xiaoshou` VALUES ('7', '5894', '早餐机', 'K67', '杭州', '件', '300', '7', '30', '147', '', '1');
INSERT INTO `rep_demo_xiaoshou` VALUES ('8', '4578', '电饭锅', 'M45', '广州', '件', '800', '8', '50', '148', '', '1');
INSERT INTO `rep_demo_xiaoshou` VALUES ('9', '2589', '豆浆机', 'H56', '上海', '件', '400', '9', '20', '258', '', '1');
INSERT INTO `rep_demo_xiaoshou` VALUES ('10', '1456', '榨汁机', 'H45', '杭州', '件', '300', '10', '10', '456', '', '1');
INSERT INTO `rep_demo_xiaoshou` VALUES ('11', '2578', '热水壶', 'U78', '广州', '件', '300', '11', '50', '258', '', '1');
INSERT INTO `rep_demo_xiaoshou` VALUES ('12', '1369', '热水器', 'J78', '上海', '件', '800', '12', '80', '158', '', '1');
INSERT INTO `rep_demo_xiaoshou` VALUES ('13', '5642', '吸尘器', 'R45', '上海', '件', '400', '13', '90', '125', '', '1');
INSERT INTO `rep_demo_xiaoshou` VALUES ('14', '1356', '挂烫机', 'U67', '上海', '件', '400', '14', '50', '120', '', '1');
INSERT INTO `rep_demo_xiaoshou` VALUES ('15', '2587', '破壁机', 'H56', '杭州', '件', '400', '15', '15', '258', '', '1');
INSERT INTO `rep_demo_xiaoshou` VALUES ('16', '2578', '热水壶11', 'U78', '广州', '件', '300', '11', '50', '258', '', '1');
INSERT INTO `rep_demo_xiaoshou` VALUES ('17', '2578', '热水壶22', 'U78', '广州', '件', '300', '11', '50', '258', '', '1');
INSERT INTO `rep_demo_xiaoshou` VALUES ('18', '2589', '电脑', 'XXP', '北京', '台', '56', '1220', '20', '1000', '', '1');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='参数配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES ('1', '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2024-12-12 12:22:06', '', null, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES ('2', '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2024-12-12 12:22:06', '', null, '初始化密码 123456');
INSERT INTO `sys_config` VALUES ('3', '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-light', 'Y', 'admin', '2024-12-12 12:22:06', '', null, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES ('4', '账号自助-验证码开关', 'sys.account.captchaEnabled', 'false', 'Y', 'admin', '2024-12-12 12:22:06', 'admin', '2025-04-11 10:46:07', '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES ('5', '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2024-12-12 12:22:06', '', null, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES ('6', '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2024-12-12 12:22:06', '', null, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COMMENT='部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('100', '0', '0', 'boot科技公司', '0', 'boot', '15888888888', 'boot@qq.com', '0', '0', 'admin', '2024-12-12 12:22:06', '', null);
INSERT INTO `sys_dept` VALUES ('101', '100', '0,100', '总公司', '1', 'boot', '15888888888', 'boot@qq.com', '0', '0', 'admin', '2024-12-12 12:22:06', 'admin', '2024-12-12 14:23:29');
INSERT INTO `sys_dept` VALUES ('103', '101', '0,100,101', '研发部门', '1', 'boot', '15888888888', 'boot@qq.com', '0', '0', 'admin', '2024-12-12 12:22:06', '', null);
INSERT INTO `sys_dept` VALUES ('105', '101', '0,100,101', '测试部门', '3', 'boot', '15888888888', 'boot@qq.com', '0', '0', 'admin', '2024-12-12 12:22:06', '', null);
INSERT INTO `sys_dept` VALUES ('106', '101', '0,100,101', '财务部门', '4', 'boot', '15888888888', 'boot@qq.com', '0', '0', 'admin', '2024-12-12 12:22:06', '', null);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COMMENT='字典数据表';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES ('1', '1', '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2024-12-12 12:22:06', '', null, '性别男');
INSERT INTO `sys_dict_data` VALUES ('2', '2', '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2024-12-12 12:22:06', '', null, '性别女');
INSERT INTO `sys_dict_data` VALUES ('3', '3', '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2024-12-12 12:22:06', '', null, '性别未知');
INSERT INTO `sys_dict_data` VALUES ('4', '1', '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2024-12-12 12:22:06', '', null, '显示菜单');
INSERT INTO `sys_dict_data` VALUES ('5', '2', '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2024-12-12 12:22:06', '', null, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES ('6', '1', '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2024-12-12 12:22:06', '', null, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('7', '2', '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2024-12-12 12:22:06', '', null, '停用状态');
INSERT INTO `sys_dict_data` VALUES ('8', '1', '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2024-12-12 12:22:06', '', null, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('9', '2', '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2024-12-12 12:22:06', '', null, '停用状态');
INSERT INTO `sys_dict_data` VALUES ('10', '1', '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2024-12-12 12:22:06', '', null, '默认分组');
INSERT INTO `sys_dict_data` VALUES ('11', '2', '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2024-12-12 12:22:06', '', null, '系统分组');
INSERT INTO `sys_dict_data` VALUES ('12', '1', '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2024-12-12 12:22:06', '', null, '系统默认是');
INSERT INTO `sys_dict_data` VALUES ('13', '2', '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2024-12-12 12:22:06', '', null, '系统默认否');
INSERT INTO `sys_dict_data` VALUES ('14', '1', '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2024-12-12 12:22:06', '', null, '通知');
INSERT INTO `sys_dict_data` VALUES ('15', '2', '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2024-12-12 12:22:06', '', null, '公告');
INSERT INTO `sys_dict_data` VALUES ('16', '1', '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2024-12-12 12:22:06', '', null, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('17', '2', '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2024-12-12 12:22:06', '', null, '关闭状态');
INSERT INTO `sys_dict_data` VALUES ('18', '99', '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2024-12-12 12:22:06', '', null, '其他操作');
INSERT INTO `sys_dict_data` VALUES ('19', '1', '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2024-12-12 12:22:06', '', null, '新增操作');
INSERT INTO `sys_dict_data` VALUES ('20', '2', '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2024-12-12 12:22:06', '', null, '修改操作');
INSERT INTO `sys_dict_data` VALUES ('21', '3', '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2024-12-12 12:22:06', '', null, '删除操作');
INSERT INTO `sys_dict_data` VALUES ('22', '4', '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2024-12-12 12:22:06', '', null, '授权操作');
INSERT INTO `sys_dict_data` VALUES ('23', '5', '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2024-12-12 12:22:06', '', null, '导出操作');
INSERT INTO `sys_dict_data` VALUES ('24', '6', '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2024-12-12 12:22:06', '', null, '导入操作');
INSERT INTO `sys_dict_data` VALUES ('25', '7', '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2024-12-12 12:22:06', '', null, '强退操作');
INSERT INTO `sys_dict_data` VALUES ('26', '8', '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2024-12-12 12:22:06', '', null, '生成操作');
INSERT INTO `sys_dict_data` VALUES ('27', '9', '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2024-12-12 12:22:06', '', null, '清空操作');
INSERT INTO `sys_dict_data` VALUES ('28', '1', '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2024-12-12 12:22:06', '', null, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('29', '2', '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2024-12-12 12:22:06', '', null, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='字典类型表';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES ('1', '用户性别', 'sys_user_sex', '0', 'admin', '2024-12-12 12:22:06', '', null, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES ('2', '菜单状态', 'sys_show_hide', '0', 'admin', '2024-12-12 12:22:06', '', null, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES ('3', '系统开关', 'sys_normal_disable', '0', 'admin', '2024-12-12 12:22:06', '', null, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES ('4', '任务状态', 'sys_job_status', '0', 'admin', '2024-12-12 12:22:06', '', null, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES ('5', '任务分组', 'sys_job_group', '0', 'admin', '2024-12-12 12:22:06', '', null, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES ('6', '系统是否', 'sys_yes_no', '0', 'admin', '2024-12-12 12:22:06', '', null, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES ('7', '通知类型', 'sys_notice_type', '0', 'admin', '2024-12-12 12:22:06', '', null, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES ('8', '通知状态', 'sys_notice_status', '0', 'admin', '2024-12-12 12:22:06', '', null, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES ('9', '操作类型', 'sys_oper_type', '0', 'admin', '2024-12-12 12:22:06', '', null, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES ('10', '系统状态', 'sys_common_status', '0', 'admin', '2024-12-12 12:22:06', '', null, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job` (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='定时任务调度表';

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES ('1', '系统默认（无参）', 'DEFAULT', 'bootTask.noParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_job` VALUES ('2', '系统默认（有参）', 'DEFAULT', 'bootTask.params(\'boot\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_job` VALUES ('3', '系统默认（多参）', 'DEFAULT', 'bootTask.multipleParams(\'boot\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2024-12-12 12:22:06', '', null, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
  `status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='定时任务调度日志表';

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`),
  KEY `idx_sys_logininfor_s` (`status`),
  KEY `idx_sys_logininfor_lt` (`login_time`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COMMENT='系统访问记录';

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES ('1', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-09-02 14:19:15');
INSERT INTO `sys_logininfor` VALUES ('2', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-09-03 11:42:21');
INSERT INTO `sys_logininfor` VALUES ('3', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-17 09:27:55');
INSERT INTO `sys_logininfor` VALUES ('4', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-17 09:56:27');
INSERT INTO `sys_logininfor` VALUES ('5', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-17 10:13:52');
INSERT INTO `sys_logininfor` VALUES ('6', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-17 10:46:16');
INSERT INTO `sys_logininfor` VALUES ('7', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-17 12:23:21');
INSERT INTO `sys_logininfor` VALUES ('8', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-10-17 12:24:30');
INSERT INTO `sys_logininfor` VALUES ('9', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-17 12:24:34');
INSERT INTO `sys_logininfor` VALUES ('10', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-10-17 12:28:53');
INSERT INTO `sys_logininfor` VALUES ('11', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-17 12:30:01');
INSERT INTO `sys_logininfor` VALUES ('12', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-10-17 12:30:13');
INSERT INTO `sys_logininfor` VALUES ('13', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-17 12:30:27');
INSERT INTO `sys_logininfor` VALUES ('14', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-10-17 13:11:23');
INSERT INTO `sys_logininfor` VALUES ('15', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-17 13:28:01');
INSERT INTO `sys_logininfor` VALUES ('16', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-10-17 13:38:07');
INSERT INTO `sys_logininfor` VALUES ('17', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-17 13:38:09');
INSERT INTO `sys_logininfor` VALUES ('18', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-10-17 15:08:23');
INSERT INTO `sys_logininfor` VALUES ('19', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-17 15:08:29');
INSERT INTO `sys_logininfor` VALUES ('20', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-10-17 15:13:24');
INSERT INTO `sys_logininfor` VALUES ('21', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-17 15:13:26');
INSERT INTO `sys_logininfor` VALUES ('22', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-10-17 15:18:42');
INSERT INTO `sys_logininfor` VALUES ('23', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-17 15:18:44');
INSERT INTO `sys_logininfor` VALUES ('24', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-10-17 15:29:06');
INSERT INTO `sys_logininfor` VALUES ('25', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-17 15:29:07');
INSERT INTO `sys_logininfor` VALUES ('26', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-10-17 16:22:40');
INSERT INTO `sys_logininfor` VALUES ('27', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-17 16:22:50');
INSERT INTO `sys_logininfor` VALUES ('28', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-10-17 16:53:52');
INSERT INTO `sys_logininfor` VALUES ('29', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-17 16:54:02');
INSERT INTO `sys_logininfor` VALUES ('30', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-10-17 17:01:06');
INSERT INTO `sys_logininfor` VALUES ('31', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-17 17:01:07');
INSERT INTO `sys_logininfor` VALUES ('32', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-10-17 17:05:57');
INSERT INTO `sys_logininfor` VALUES ('33', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-17 17:05:58');
INSERT INTO `sys_logininfor` VALUES ('34', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-10-17 17:16:40');
INSERT INTO `sys_logininfor` VALUES ('35', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-17 17:16:51');
INSERT INTO `sys_logininfor` VALUES ('36', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-10-17 17:24:32');
INSERT INTO `sys_logininfor` VALUES ('37', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-17 17:24:33');
INSERT INTO `sys_logininfor` VALUES ('38', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-10-17 17:48:33');
INSERT INTO `sys_logininfor` VALUES ('39', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-17 17:48:35');
INSERT INTO `sys_logininfor` VALUES ('40', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-18 12:43:41');
INSERT INTO `sys_logininfor` VALUES ('41', 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-10-18 13:18:26');
INSERT INTO `sys_logininfor` VALUES ('42', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-20 09:09:18');
INSERT INTO `sys_logininfor` VALUES ('43', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-20 09:36:11');
INSERT INTO `sys_logininfor` VALUES ('44', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-10-20 09:45:29');
INSERT INTO `sys_logininfor` VALUES ('45', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-20 09:45:38');
INSERT INTO `sys_logininfor` VALUES ('46', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-10-20 09:57:57');
INSERT INTO `sys_logininfor` VALUES ('47', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-20 09:58:00');
INSERT INTO `sys_logininfor` VALUES ('48', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-10-20 10:23:22');
INSERT INTO `sys_logininfor` VALUES ('49', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-20 10:23:24');
INSERT INTO `sys_logininfor` VALUES ('50', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-10-20 10:31:06');
INSERT INTO `sys_logininfor` VALUES ('51', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-20 10:31:08');
INSERT INTO `sys_logininfor` VALUES ('52', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-10-20 10:33:06');
INSERT INTO `sys_logininfor` VALUES ('53', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-20 10:33:54');
INSERT INTO `sys_logininfor` VALUES ('54', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-20 12:26:24');
INSERT INTO `sys_logininfor` VALUES ('55', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-20 12:26:24');
INSERT INTO `sys_logininfor` VALUES ('56', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-10-20 13:55:40');
INSERT INTO `sys_logininfor` VALUES ('57', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-10-20 13:56:06');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int(4) DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) DEFAULT NULL COMMENT '路由参数',
  `is_frame` int(1) DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `frame_embed_flag` int(1) DEFAULT '1' COMMENT '外链  外置跳转还是内嵌页面（1内嵌  2 外置） 默认 内嵌',
  `is_cache` int(1) DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1077 DEFAULT CHARSET=utf8mb4 COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '系统管理', '0', '1100', 'system', null, '', '1', null, '0', 'M', '0', '0', '', 'system', 'admin', '2024-12-12 12:22:06', 'admin', '2025-04-15 16:38:39', '系统管理目录');
INSERT INTO `sys_menu` VALUES ('2', '系统监控', '0', '1200', 'monitor', null, '', '1', null, '0', 'M', '1', '0', '', 'monitor', 'admin', '2024-12-12 12:22:06', 'admin', '2025-04-15 13:47:06', '系统监控目录');
INSERT INTO `sys_menu` VALUES ('3', '系统工具', '0', '1300', 'tool', null, '', '1', null, '0', 'M', '1', '0', '', 'tool', 'admin', '2024-12-12 12:22:06', 'admin', '2025-04-15 13:47:09', '系统工具目录');
INSERT INTO `sys_menu` VALUES ('100', '用户管理', '1', '1', 'user', 'system/user/index', '', '1', null, '0', 'C', '0', '0', 'system:user:list', 'user', 'admin', '2024-12-12 12:22:06', '', null, '用户管理菜单');
INSERT INTO `sys_menu` VALUES ('101', '角色管理', '1', '2', 'role', 'system/role/index', '', '1', null, '0', 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2024-12-12 12:22:06', '', null, '角色管理菜单');
INSERT INTO `sys_menu` VALUES ('102', '菜单管理', '1', '3', 'menu', 'system/menu/index', '', '1', null, '0', 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2024-12-12 12:22:06', '', null, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES ('103', '部门管理', '1', '4', 'dept', 'system/dept/index', '', '1', null, '0', 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2024-12-12 12:22:06', '', null, '部门管理菜单');
INSERT INTO `sys_menu` VALUES ('104', '岗位管理', '1', '5', 'post', 'system/post/index', '', '1', null, '0', 'C', '0', '0', 'system:post:list', 'post', 'admin', '2024-12-12 12:22:06', '', null, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES ('105', '字典管理', '1', '6', 'dict', 'system/dict/index', '', '1', null, '0', 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2024-12-12 12:22:06', '', null, '字典管理菜单');
INSERT INTO `sys_menu` VALUES ('106', '参数设置', '1', '7', 'config', 'system/config/index', '', '1', null, '0', 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2024-12-12 12:22:06', '', null, '参数设置菜单');
INSERT INTO `sys_menu` VALUES ('107', '通知公告', '1', '8', 'notice', 'system/notice/index', '', '1', null, '0', 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2024-12-12 12:22:06', '', null, '通知公告菜单');
INSERT INTO `sys_menu` VALUES ('108', '日志管理', '1', '9', 'log', '', '', '1', null, '0', 'M', '0', '0', '', 'log', 'admin', '2024-12-12 12:22:06', '', null, '日志管理菜单');
INSERT INTO `sys_menu` VALUES ('109', '在线用户', '2', '1', 'online', 'monitor/online/index', '', '1', null, '0', 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2024-12-12 12:22:06', '', null, '在线用户菜单');
INSERT INTO `sys_menu` VALUES ('110', '定时任务', '2', '2', 'job', 'monitor/job/index', '', '1', null, '0', 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2024-12-12 12:22:06', '', null, '定时任务菜单');
INSERT INTO `sys_menu` VALUES ('111', '数据监控', '2', '3', 'druid', 'monitor/druid/index', '', '1', null, '0', 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2024-12-12 12:22:06', '', null, '数据监控菜单');
INSERT INTO `sys_menu` VALUES ('112', '服务监控', '2', '4', 'server', 'monitor/server/index', '', '1', null, '0', 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2024-12-12 12:22:06', '', null, '服务监控菜单');
INSERT INTO `sys_menu` VALUES ('113', '缓存监控', '2', '5', 'cache', 'monitor/cache/index', '', '1', null, '0', 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2024-12-12 12:22:06', '', null, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES ('114', '缓存列表', '2', '6', 'cacheList', 'monitor/cache/list', '', '1', null, '0', 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2024-12-12 12:22:06', '', null, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES ('115', '表单构建', '3', '1', 'build', 'tool/build/index', '', '1', null, '0', 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2024-12-12 12:22:06', '', null, '表单构建菜单');
INSERT INTO `sys_menu` VALUES ('116', '代码生成', '3', '2', 'gen', 'tool/gen/index', '', '1', null, '0', 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2024-12-12 12:22:06', '', null, '代码生成菜单');
INSERT INTO `sys_menu` VALUES ('117', '系统接口', '3', '3', 'swagger', 'tool/swagger/index', '', '1', null, '0', 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2024-12-12 12:22:06', '', null, '系统接口菜单');
INSERT INTO `sys_menu` VALUES ('500', '操作日志', '108', '1', 'operlog', 'monitor/operlog/index', '', '1', null, '0', 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2024-12-12 12:22:06', '', null, '操作日志菜单');
INSERT INTO `sys_menu` VALUES ('501', '登录日志', '108', '2', 'logininfor', 'monitor/logininfor/index', '', '1', null, '0', 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2024-12-12 12:22:06', '', null, '登录日志菜单');
INSERT INTO `sys_menu` VALUES ('1000', '用户查询', '100', '1', '', '', '', '1', null, '0', 'F', '0', '0', 'system:user:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1001', '用户新增', '100', '2', '', '', '', '1', null, '0', 'F', '0', '0', 'system:user:add', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1002', '用户修改', '100', '3', '', '', '', '1', null, '0', 'F', '0', '0', 'system:user:edit', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1003', '用户删除', '100', '4', '', '', '', '1', null, '0', 'F', '0', '0', 'system:user:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1004', '用户导出', '100', '5', '', '', '', '1', null, '0', 'F', '0', '0', 'system:user:export', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1005', '用户导入', '100', '6', '', '', '', '1', null, '0', 'F', '0', '0', 'system:user:import', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1006', '重置密码', '100', '7', '', '', '', '1', null, '0', 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1007', '角色查询', '101', '1', '', '', '', '1', null, '0', 'F', '0', '0', 'system:role:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1008', '角色新增', '101', '2', '', '', '', '1', null, '0', 'F', '0', '0', 'system:role:add', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1009', '角色修改', '101', '3', '', '', '', '1', null, '0', 'F', '0', '0', 'system:role:edit', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1010', '角色删除', '101', '4', '', '', '', '1', null, '0', 'F', '0', '0', 'system:role:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1011', '角色导出', '101', '5', '', '', '', '1', null, '0', 'F', '0', '0', 'system:role:export', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1012', '菜单查询', '102', '1', '', '', '', '1', null, '0', 'F', '0', '0', 'system:menu:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1013', '菜单新增', '102', '2', '', '', '', '1', null, '0', 'F', '0', '0', 'system:menu:add', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1014', '菜单修改', '102', '3', '', '', '', '1', null, '0', 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1015', '菜单删除', '102', '4', '', '', '', '1', null, '0', 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1016', '部门查询', '103', '1', '', '', '', '1', null, '0', 'F', '0', '0', 'system:dept:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1017', '部门新增', '103', '2', '', '', '', '1', null, '0', 'F', '0', '0', 'system:dept:add', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1018', '部门修改', '103', '3', '', '', '', '1', null, '0', 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1019', '部门删除', '103', '4', '', '', '', '1', null, '0', 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1020', '岗位查询', '104', '1', '', '', '', '1', null, '0', 'F', '0', '0', 'system:post:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1021', '岗位新增', '104', '2', '', '', '', '1', null, '0', 'F', '0', '0', 'system:post:add', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1022', '岗位修改', '104', '3', '', '', '', '1', null, '0', 'F', '0', '0', 'system:post:edit', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1023', '岗位删除', '104', '4', '', '', '', '1', null, '0', 'F', '0', '0', 'system:post:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1024', '岗位导出', '104', '5', '', '', '', '1', null, '0', 'F', '0', '0', 'system:post:export', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1025', '字典查询', '105', '1', '#', '', '', '1', null, '0', 'F', '0', '0', 'system:dict:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1026', '字典新增', '105', '2', '#', '', '', '1', null, '0', 'F', '0', '0', 'system:dict:add', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1027', '字典修改', '105', '3', '#', '', '', '1', null, '0', 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1028', '字典删除', '105', '4', '#', '', '', '1', null, '0', 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1029', '字典导出', '105', '5', '#', '', '', '1', null, '0', 'F', '0', '0', 'system:dict:export', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1030', '参数查询', '106', '1', '#', '', '', '1', null, '0', 'F', '0', '0', 'system:config:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1031', '参数新增', '106', '2', '#', '', '', '1', null, '0', 'F', '0', '0', 'system:config:add', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1032', '参数修改', '106', '3', '#', '', '', '1', null, '0', 'F', '0', '0', 'system:config:edit', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1033', '参数删除', '106', '4', '#', '', '', '1', null, '0', 'F', '0', '0', 'system:config:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1034', '参数导出', '106', '5', '#', '', '', '1', null, '0', 'F', '0', '0', 'system:config:export', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1035', '公告查询', '107', '1', '#', '', '', '1', null, '0', 'F', '0', '0', 'system:notice:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1036', '公告新增', '107', '2', '#', '', '', '1', null, '0', 'F', '0', '0', 'system:notice:add', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1037', '公告修改', '107', '3', '#', '', '', '1', null, '0', 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1038', '公告删除', '107', '4', '#', '', '', '1', null, '0', 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1039', '操作查询', '500', '1', '#', '', '', '1', null, '0', 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1040', '操作删除', '500', '2', '#', '', '', '1', null, '0', 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1041', '日志导出', '500', '3', '#', '', '', '1', null, '0', 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1042', '登录查询', '501', '1', '#', '', '', '1', null, '0', 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1043', '登录删除', '501', '2', '#', '', '', '1', null, '0', 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1044', '日志导出', '501', '3', '#', '', '', '1', null, '0', 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1045', '账户解锁', '501', '4', '#', '', '', '1', null, '0', 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1046', '在线查询', '109', '1', '#', '', '', '1', null, '0', 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1047', '批量强退', '109', '2', '#', '', '', '1', null, '0', 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1048', '单条强退', '109', '3', '#', '', '', '1', null, '0', 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1049', '任务查询', '110', '1', '#', '', '', '1', null, '0', 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1050', '任务新增', '110', '2', '#', '', '', '1', null, '0', 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1051', '任务修改', '110', '3', '#', '', '', '1', null, '0', 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1052', '任务删除', '110', '4', '#', '', '', '1', null, '0', 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1053', '状态修改', '110', '5', '#', '', '', '1', null, '0', 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1054', '任务导出', '110', '6', '#', '', '', '1', null, '0', 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1055', '生成查询', '116', '1', '#', '', '', '1', null, '0', 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1056', '生成修改', '116', '2', '#', '', '', '1', null, '0', 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1057', '生成删除', '116', '3', '#', '', '', '1', null, '0', 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1058', '导入代码', '116', '4', '#', '', '', '1', null, '0', 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1059', '预览代码', '116', '5', '#', '', '', '1', null, '0', 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1060', '生成代码', '116', '6', '#', '', '', '1', null, '0', 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_menu` VALUES ('1062', '在线开发', '0', '1400', 'magicApi', null, null, '1', null, '0', 'M', '0', '0', 'magic:api:code', 'code', 'admin', '2025-03-09 18:13:35', 'admin', '2025-10-20 10:25:38', '');
INSERT INTO `sys_menu` VALUES ('1063', '接口开发', '1062', '10', 'http://127.0.0.1:8081/magicApi/index.html', null, null, '0', null, '0', 'C', '0', '0', 'magic:api:code', 'clipboard', 'admin', '2025-03-09 18:15:09', 'admin', '2025-10-20 10:25:28', '');
INSERT INTO `sys_menu` VALUES ('1064', '报表设计', '1066', '1', 'http://127.0.0.1:8081/jmreport/list', null, null, '0', null, '0', 'C', '0', '0', '', 'chart', 'admin', '2025-10-17 10:00:34', 'admin', '2025-10-18 13:28:37', '');
INSERT INTO `sys_menu` VALUES ('1065', 'BI设计', '1066', '2', 'http://127.0.0.1:8081/drag/list', null, null, '0', null, '0', 'C', '0', '0', '', 'chart', 'admin', '2025-10-17 10:01:20', 'admin', '2025-10-18 13:28:42', '');
INSERT INTO `sys_menu` VALUES ('1066', '图表设计', '0', '100', 'design', null, null, '1', null, '0', 'M', '0', '0', '', 'edit', 'admin', '2025-10-17 16:24:34', 'admin', '2025-10-17 16:27:41', '');
INSERT INTO `sys_menu` VALUES ('1067', '测试页面', '0', '10', 'test', null, null, '1', null, '0', 'M', '0', '0', null, 'list', 'admin', '2025-10-17 16:26:17', '', null, '');
INSERT INTO `sys_menu` VALUES ('1068', '乡村振兴', '1067', '10', 'http://localhost:8081/jmreport/shareView/864668240323870720', null, null, '0', '1', '0', 'C', '0', '0', '', 'eye-open', 'admin', '2025-10-17 16:26:45', 'admin', '2025-10-17 17:48:55', '');
INSERT INTO `sys_menu` VALUES ('1076', '首页管理', '1', '0', 'https://blog.csdn.net/weixin_44588243/article/details/116244504', null, null, '0', '1', '0', 'M', '1', '0', '', 'dashboard', 'admin', '2025-10-23 09:50:26', 'admin', '2025-10-23 10:35:42', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice` (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
  `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='通知公告表';

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES ('1', '温馨提醒：2018-07-01 boot新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2024-12-12 12:22:06', '', null, '管理员');
INSERT INTO `sys_notice` VALUES ('2', '维护通知：2018-07-01 boot系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2024-12-12 12:22:06', '', null, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) DEFAULT '' COMMENT '返回参数',
  `status` int(1) DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint(20) DEFAULT '0' COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`),
  KEY `idx_sys_oper_log_bt` (`business_type`),
  KEY `idx_sys_oper_log_s` (`status`),
  KEY `idx_sys_oper_log_ot` (`oper_time`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COMMENT='操作日志记录';

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES ('1', '操作日志', '9', 'com.boot.system.controller.SysOperlogController.clean()', 'DELETE', '1', 'admin', null, '/monitor/operlog/clean', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-08-21 15:40:34', '18');
INSERT INTO `sys_oper_log` VALUES ('2', '登录日志', '9', 'com.boot.system.controller.SysLogininforController.clean()', 'DELETE', '1', 'admin', null, '/monitor/logininfor/clean', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-08-21 15:40:40', '12');
INSERT INTO `sys_oper_log` VALUES ('3', '菜单管理', '1', 'com.boot.system.controller.SysMenuController.add()', 'POST', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuName\":\"报表设计\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"http://localhost:8080/jmreport/list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-17 10:00:34', '109');
INSERT INTO `sys_oper_log` VALUES ('4', '菜单管理', '1', 'com.boot.system.controller.SysMenuController.add()', 'POST', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuName\":\"BI报表\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"http://localhost:8080/drag/list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-17 10:01:20', '13');
INSERT INTO `sys_oper_log` VALUES ('5', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-10-17 10:01:20\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":1065,\"menuName\":\"BI报表设计\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"http://localhost:8080/drag/list\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-17 10:14:10', '46');
INSERT INTO `sys_oper_log` VALUES ('6', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-10-17 10:01:20\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":1065,\"menuName\":\"BI设计\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"http://localhost:8080/drag/list\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-17 10:19:40', '22');
INSERT INTO `sys_oper_log` VALUES ('7', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-10-17 10:00:34\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":1064,\"menuName\":\"报表设计\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"http://localhost:8081/jmreport/list\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-17 13:38:20', '55');
INSERT INTO `sys_oper_log` VALUES ('8', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-10-17 10:01:20\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":1065,\"menuName\":\"BI设计\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"http://localhost:8081/drag/list\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-17 13:38:26', '17');
INSERT INTO `sys_oper_log` VALUES ('9', '菜单管理', '1', 'com.boot.system.controller.SysMenuController.add()', 'POST', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"报表设计\",\"menuType\":\"M\",\"orderNum\":100,\"params\":{},\"parentId\":0,\"path\":\"design\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"新增菜单\'报表设计\'失败，菜单名称已存在\",\"code\":500}', '0', null, '2025-10-17 16:24:26', '23');
INSERT INTO `sys_oper_log` VALUES ('10', '菜单管理', '1', 'com.boot.system.controller.SysMenuController.add()', 'POST', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"报表设计1\",\"menuType\":\"M\",\"orderNum\":100,\"params\":{},\"parentId\":0,\"path\":\"design\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-17 16:24:34', '16');
INSERT INTO `sys_oper_log` VALUES ('11', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-10-17 10:00:34\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":1064,\"menuName\":\"报表设计\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1066,\"path\":\"http://localhost:8081/jmreport/list\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-17 16:24:43', '19');
INSERT INTO `sys_oper_log` VALUES ('12', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-10-17 10:01:20\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":1065,\"menuName\":\"BI设计\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":1066,\"path\":\"http://localhost:8081/drag/list\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-17 16:24:49', '18');
INSERT INTO `sys_oper_log` VALUES ('13', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-10-17 16:24:34\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1066,\"menuName\":\"报表设计\",\"menuType\":\"M\",\"orderNum\":100,\"params\":{},\"parentId\":0,\"path\":\"design\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-17 16:24:54', '15');
INSERT INTO `sys_oper_log` VALUES ('14', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-03-09 18:15:09\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":1063,\"menuName\":\"编写代码\",\"menuType\":\"C\",\"orderNum\":10,\"params\":{},\"parentId\":1062,\"path\":\"http://localhost:8080/magicApi/index.html\",\"perms\":\"magic:api:code\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-17 16:25:11', '20');
INSERT INTO `sys_oper_log` VALUES ('15', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-03-09 18:13:35\",\"icon\":\"code\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1062,\"menuName\":\"MagicApi\",\"menuType\":\"M\",\"orderNum\":1400,\"params\":{},\"parentId\":0,\"path\":\"magicApi\",\"perms\":\"magic:api:code\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-17 16:25:32', '18');
INSERT INTO `sys_oper_log` VALUES ('16', '菜单管理', '1', 'com.boot.system.controller.SysMenuController.add()', 'POST', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"测试页面\",\"menuType\":\"M\",\"orderNum\":10,\"params\":{},\"parentId\":0,\"path\":\"test\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-17 16:26:17', '11');
INSERT INTO `sys_oper_log` VALUES ('17', '菜单管理', '1', 'com.boot.system.controller.SysMenuController.add()', 'POST', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuName\":\"乡村振兴\",\"menuType\":\"C\",\"orderNum\":10,\"params\":{},\"parentId\":1067,\"path\":\"http://localhost:8081/jmreport/shareView/864668240323870720\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-17 16:26:45', '11');
INSERT INTO `sys_oper_log` VALUES ('18', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-10-17 16:24:34\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1066,\"menuName\":\"图表设计\",\"menuType\":\"M\",\"orderNum\":100,\"params\":{},\"parentId\":0,\"path\":\"design\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-17 16:27:41', '19');
INSERT INTO `sys_oper_log` VALUES ('19', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-03-09 18:15:09\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":1063,\"menuName\":\"编写代码\",\"menuType\":\"C\",\"orderNum\":10,\"params\":{},\"parentId\":1062,\"path\":\"http://localhost:8081/magicApi/index.html\",\"perms\":\"magic:api:code\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-17 16:56:24', '40');
INSERT INTO `sys_oper_log` VALUES ('20', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-10-17 16:26:45\",\"icon\":\"eye-open\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":1068,\"menuName\":\"乡村振兴\",\"menuType\":\"C\",\"orderNum\":10,\"params\":{},\"parentId\":1067,\"path\":\"http://localhost:8081/jmreport/shareView/864668240323870720\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-17 17:48:55', '49');
INSERT INTO `sys_oper_log` VALUES ('21', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-03-09 18:15:09\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":1063,\"menuName\":\"编写代码\",\"menuType\":\"C\",\"orderNum\":10,\"params\":{},\"parentId\":1062,\"path\":\"/magicApi/index.html\",\"perms\":\"magic:api:code\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"修改菜单\'编写代码\'失败，地址必须以http(s)://开头\",\"code\":500}', '0', null, '2025-10-18 12:56:03', '21');
INSERT INTO `sys_oper_log` VALUES ('22', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-03-09 18:15:09\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":1063,\"menuName\":\"编写代码\",\"menuType\":\"C\",\"orderNum\":10,\"params\":{},\"parentId\":1062,\"path\":\"/magicApi/index.html\",\"perms\":\"magic:api:code\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"修改菜单\'编写代码\'失败，地址必须以http(s)://开头\",\"code\":500}', '0', null, '2025-10-18 12:56:18', '4');
INSERT INTO `sys_oper_log` VALUES ('23', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-03-09 18:15:09\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":1063,\"menuName\":\"编写代码\",\"menuType\":\"C\",\"orderNum\":10,\"params\":{},\"parentId\":1062,\"path\":\"magicApi/index.html\",\"perms\":\"magic:api:code\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"修改菜单\'编写代码\'失败，地址必须以http(s)://开头\",\"code\":500}', '0', null, '2025-10-18 12:56:33', '4');
INSERT INTO `sys_oper_log` VALUES ('24', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-03-09 18:15:09\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1063,\"menuName\":\"编写代码\",\"menuType\":\"C\",\"orderNum\":10,\"params\":{},\"parentId\":1062,\"path\":\"magicApi/index.html\",\"perms\":\"magic:api:code\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-18 12:58:02', '16');
INSERT INTO `sys_oper_log` VALUES ('25', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-10-17 10:00:34\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1064,\"menuName\":\"报表设计\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1066,\"path\":\"/jmreport/list\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-18 12:58:59', '13');
INSERT INTO `sys_oper_log` VALUES ('26', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-10-17 10:01:20\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":1065,\"menuName\":\"BI设计\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":1066,\"path\":\"/drag/list\",\"perms\":\"\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"修改菜单\'BI设计\'失败，地址必须以http(s)://开头\",\"code\":500}', '0', null, '2025-10-18 12:59:12', '3');
INSERT INTO `sys_oper_log` VALUES ('27', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-10-17 10:01:20\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":1065,\"menuName\":\"BI设计\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":1066,\"path\":\"/drag/list\",\"perms\":\"\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"修改菜单\'BI设计\'失败，地址必须以http(s)://开头\",\"code\":500}', '0', null, '2025-10-18 12:59:13', '6');
INSERT INTO `sys_oper_log` VALUES ('28', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-10-17 10:01:20\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1065,\"menuName\":\"BI设计\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":1066,\"path\":\"/drag/list\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-18 12:59:16', '12');
INSERT INTO `sys_oper_log` VALUES ('29', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-10-17 10:00:34\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1064,\"menuName\":\"报表设计\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1066,\"path\":\"http://127.0.0.1:8081/jmreport/list\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-18 13:07:31', '10');
INSERT INTO `sys_oper_log` VALUES ('30', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-10-17 10:01:20\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1065,\"menuName\":\"BI设计\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":1066,\"path\":\"http://127.0.0.1:8081/drag/list\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-18 13:07:46', '15');
INSERT INTO `sys_oper_log` VALUES ('31', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-10-17 10:00:34\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":1064,\"menuName\":\"报表设计\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1066,\"path\":\"http://127.0.0.1:8081/jmreport/list\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-18 13:28:37', '11');
INSERT INTO `sys_oper_log` VALUES ('32', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-10-17 10:01:20\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":1065,\"menuName\":\"BI设计\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":1066,\"path\":\"http://127.0.0.1:8081/drag/list\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-18 13:28:42', '13');
INSERT INTO `sys_oper_log` VALUES ('33', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-03-09 18:15:09\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1063,\"menuName\":\"编写代码\",\"menuType\":\"C\",\"orderNum\":10,\"params\":{},\"parentId\":1062,\"path\":\"http://127.0.0.1:8081/magicApi/index.html\",\"perms\":\"magic:api:code\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-20 10:24:55', '33');
INSERT INTO `sys_oper_log` VALUES ('34', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-03-09 18:15:09\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":1063,\"menuName\":\"编写代码\",\"menuType\":\"C\",\"orderNum\":10,\"params\":{},\"parentId\":1062,\"path\":\"http://127.0.0.1:8081/magicApi/index.html\",\"perms\":\"magic:api:code\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-20 10:25:28', '14');
INSERT INTO `sys_oper_log` VALUES ('35', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-03-09 18:13:35\",\"icon\":\"code\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1062,\"menuName\":\"在线开发\",\"menuType\":\"M\",\"orderNum\":1400,\"params\":{},\"parentId\":0,\"path\":\"magicApi\",\"perms\":\"magic:api:code\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-20 10:25:38', '15');
INSERT INTO `sys_oper_log` VALUES ('36', '菜单管理', '1', 'com.boot.system.controller.SysMenuController.add()', 'POST', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"生产模块\",\"menuType\":\"M\",\"orderNum\":100,\"params\":{},\"parentId\":0,\"path\":\"product\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-20 14:43:00', '40');
INSERT INTO `sys_oper_log` VALUES ('37', '菜单管理', '3', 'com.boot.system.controller.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/1069', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-10-20 14:43:17', '14');

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post` (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='岗位信息表';

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES ('1', 'ceo', '董事长', '1', '0', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_post` VALUES ('2', 'se', '项目经理', '2', '0', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_post` VALUES ('3', 'hr', '人力资源', '3', '0', 'admin', '2024-12-12 12:22:06', '', null, '');
INSERT INTO `sys_post` VALUES ('4', 'user', '普通员工', '4', '0', 'admin', '2024-12-12 12:22:06', '', null, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='角色信息表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '超级管理员', 'admin', '1', '1', '1', '1', '0', '0', 'admin', '2024-12-12 12:22:06', '', null, '超级管理员');
INSERT INTO `sys_role` VALUES ('2', '普通角色', 'normal', '2', '2', '1', '1', '0', '0', 'admin', '2024-12-12 12:22:06', '', null, '普通角色');
INSERT INTO `sys_role` VALUES ('3', '管理组', 'adminGroup', '2', '1', '1', '1', '0', '0', 'admin', '2024-11-18 06:46:31', 'admin', '2025-02-06 09:09:56', null);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色和部门关联表';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES ('2', '100');
INSERT INTO `sys_role_dept` VALUES ('2', '101');
INSERT INTO `sys_role_dept` VALUES ('2', '105');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色和菜单关联表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('2', '1');
INSERT INTO `sys_role_menu` VALUES ('2', '2');
INSERT INTO `sys_role_menu` VALUES ('2', '3');
INSERT INTO `sys_role_menu` VALUES ('2', '4');
INSERT INTO `sys_role_menu` VALUES ('2', '100');
INSERT INTO `sys_role_menu` VALUES ('2', '101');
INSERT INTO `sys_role_menu` VALUES ('2', '102');
INSERT INTO `sys_role_menu` VALUES ('2', '103');
INSERT INTO `sys_role_menu` VALUES ('2', '104');
INSERT INTO `sys_role_menu` VALUES ('2', '105');
INSERT INTO `sys_role_menu` VALUES ('2', '106');
INSERT INTO `sys_role_menu` VALUES ('2', '107');
INSERT INTO `sys_role_menu` VALUES ('2', '108');
INSERT INTO `sys_role_menu` VALUES ('2', '109');
INSERT INTO `sys_role_menu` VALUES ('2', '110');
INSERT INTO `sys_role_menu` VALUES ('2', '111');
INSERT INTO `sys_role_menu` VALUES ('2', '112');
INSERT INTO `sys_role_menu` VALUES ('2', '113');
INSERT INTO `sys_role_menu` VALUES ('2', '114');
INSERT INTO `sys_role_menu` VALUES ('2', '115');
INSERT INTO `sys_role_menu` VALUES ('2', '116');
INSERT INTO `sys_role_menu` VALUES ('2', '117');
INSERT INTO `sys_role_menu` VALUES ('2', '500');
INSERT INTO `sys_role_menu` VALUES ('2', '501');
INSERT INTO `sys_role_menu` VALUES ('2', '1000');
INSERT INTO `sys_role_menu` VALUES ('2', '1001');
INSERT INTO `sys_role_menu` VALUES ('2', '1002');
INSERT INTO `sys_role_menu` VALUES ('2', '1003');
INSERT INTO `sys_role_menu` VALUES ('2', '1004');
INSERT INTO `sys_role_menu` VALUES ('2', '1005');
INSERT INTO `sys_role_menu` VALUES ('2', '1006');
INSERT INTO `sys_role_menu` VALUES ('2', '1007');
INSERT INTO `sys_role_menu` VALUES ('2', '1008');
INSERT INTO `sys_role_menu` VALUES ('2', '1009');
INSERT INTO `sys_role_menu` VALUES ('2', '1010');
INSERT INTO `sys_role_menu` VALUES ('2', '1011');
INSERT INTO `sys_role_menu` VALUES ('2', '1012');
INSERT INTO `sys_role_menu` VALUES ('2', '1013');
INSERT INTO `sys_role_menu` VALUES ('2', '1014');
INSERT INTO `sys_role_menu` VALUES ('2', '1015');
INSERT INTO `sys_role_menu` VALUES ('2', '1016');
INSERT INTO `sys_role_menu` VALUES ('2', '1017');
INSERT INTO `sys_role_menu` VALUES ('2', '1018');
INSERT INTO `sys_role_menu` VALUES ('2', '1019');
INSERT INTO `sys_role_menu` VALUES ('2', '1020');
INSERT INTO `sys_role_menu` VALUES ('2', '1021');
INSERT INTO `sys_role_menu` VALUES ('2', '1022');
INSERT INTO `sys_role_menu` VALUES ('2', '1023');
INSERT INTO `sys_role_menu` VALUES ('2', '1024');
INSERT INTO `sys_role_menu` VALUES ('2', '1025');
INSERT INTO `sys_role_menu` VALUES ('2', '1026');
INSERT INTO `sys_role_menu` VALUES ('2', '1027');
INSERT INTO `sys_role_menu` VALUES ('2', '1028');
INSERT INTO `sys_role_menu` VALUES ('2', '1029');
INSERT INTO `sys_role_menu` VALUES ('2', '1030');
INSERT INTO `sys_role_menu` VALUES ('2', '1031');
INSERT INTO `sys_role_menu` VALUES ('2', '1032');
INSERT INTO `sys_role_menu` VALUES ('2', '1033');
INSERT INTO `sys_role_menu` VALUES ('2', '1034');
INSERT INTO `sys_role_menu` VALUES ('2', '1035');
INSERT INTO `sys_role_menu` VALUES ('2', '1036');
INSERT INTO `sys_role_menu` VALUES ('2', '1037');
INSERT INTO `sys_role_menu` VALUES ('2', '1038');
INSERT INTO `sys_role_menu` VALUES ('2', '1039');
INSERT INTO `sys_role_menu` VALUES ('2', '1040');
INSERT INTO `sys_role_menu` VALUES ('2', '1041');
INSERT INTO `sys_role_menu` VALUES ('2', '1042');
INSERT INTO `sys_role_menu` VALUES ('2', '1043');
INSERT INTO `sys_role_menu` VALUES ('2', '1044');
INSERT INTO `sys_role_menu` VALUES ('2', '1045');
INSERT INTO `sys_role_menu` VALUES ('2', '1046');
INSERT INTO `sys_role_menu` VALUES ('2', '1047');
INSERT INTO `sys_role_menu` VALUES ('2', '1048');
INSERT INTO `sys_role_menu` VALUES ('2', '1049');
INSERT INTO `sys_role_menu` VALUES ('2', '1050');
INSERT INTO `sys_role_menu` VALUES ('2', '1051');
INSERT INTO `sys_role_menu` VALUES ('2', '1052');
INSERT INTO `sys_role_menu` VALUES ('2', '1053');
INSERT INTO `sys_role_menu` VALUES ('2', '1054');
INSERT INTO `sys_role_menu` VALUES ('2', '1055');
INSERT INTO `sys_role_menu` VALUES ('2', '1056');
INSERT INTO `sys_role_menu` VALUES ('2', '1057');
INSERT INTO `sys_role_menu` VALUES ('2', '1058');
INSERT INTO `sys_role_menu` VALUES ('2', '1059');
INSERT INTO `sys_role_menu` VALUES ('2', '1060');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) DEFAULT '' COMMENT '密码',
  `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '103', 'admin', 'boot', '00', 'boot@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-10-20 13:56:06', 'admin', '2024-12-12 12:22:06', '', '2025-10-20 13:56:06', '管理员');
INSERT INTO `sys_user` VALUES ('2', '105', 'boot', 'boot', '00', 'boot@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2024-12-12 12:22:06', 'admin', '2024-12-12 12:22:06', '', null, '测试员');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户与岗位关联表';

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES ('1', '1');
INSERT INTO `sys_user_post` VALUES ('2', '2');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户和角色关联表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1');
INSERT INTO `sys_user_role` VALUES ('2', '2');

-- ----------------------------
-- Table structure for test_customer
-- ----------------------------
DROP TABLE IF EXISTS `test_customer`;
CREATE TABLE `test_customer` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL COMMENT '客户编号',
  `name` varchar(50) DEFAULT NULL COMMENT '客户名称',
  `address` varchar(100) DEFAULT NULL COMMENT '客户地址',
  `yylx` varchar(2) DEFAULT NULL COMMENT '营业类型',
  `zyyw` varchar(255) DEFAULT NULL COMMENT '主营业务',
  `clsj` date DEFAULT NULL COMMENT '成立时间',
  `fzr` varchar(50) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机号',
  `khyj` varchar(255) DEFAULT NULL COMMENT '客户意见',
  `xypd` varchar(255) DEFAULT NULL COMMENT '信用评定',
  `tbr` varchar(50) DEFAULT NULL COMMENT '填表人',
  `depts` varchar(50) DEFAULT NULL COMMENT '部门',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of test_customer
-- ----------------------------
INSERT INTO `test_customer` VALUES ('1', '001', '北京科技', '北京朝阳区', '1', '软件服务', '2019-09-01', '张三', '18566666666', '反馈良好', 'A级', '李李', null);

-- ----------------------------
-- Table structure for test_order
-- ----------------------------
DROP TABLE IF EXISTS `test_order`;
CREATE TABLE `test_order` (
  `id` varchar(32) NOT NULL,
  `order_name` varchar(50) DEFAULT NULL COMMENT '订单名称',
  `order_no` varchar(50) DEFAULT NULL COMMENT '订单编号',
  `order_sign_date` datetime DEFAULT NULL COMMENT '订单签订日期',
  `order_delivery_date` datetime DEFAULT NULL COMMENT '订单交付日期',
  `order_coms` varchar(50) DEFAULT NULL COMMENT '客户名称',
  `order_pers` varchar(50) DEFAULT NULL COMMENT '客户联系人',
  `order_phone` varchar(15) DEFAULT NULL COMMENT '客户联系方式',
  `fzr` varchar(50) DEFAULT NULL COMMENT '负责人',
  `depts` varchar(50) DEFAULT NULL COMMENT '负责人部门',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of test_order
-- ----------------------------

-- ----------------------------
-- Table structure for test_order_pros
-- ----------------------------
DROP TABLE IF EXISTS `test_order_pros`;
CREATE TABLE `test_order_pros` (
  `id` varchar(32) NOT NULL,
  `pro_name` varchar(50) DEFAULT NULL COMMENT '产品名称',
  `pro_no` varchar(50) DEFAULT NULL COMMENT '产品编号',
  `pro_count` varchar(11) DEFAULT NULL COMMENT '产品数量',
  `pro_price` decimal(10,2) DEFAULT NULL COMMENT '产品单价',
  `pro_unit` varchar(10) DEFAULT NULL COMMENT '单位',
  `pro_model` varchar(10) DEFAULT NULL COMMENT '型号',
  `main_id` varchar(32) DEFAULT NULL COMMENT '外键',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of test_order_pros
-- ----------------------------

-- ----------------------------
-- Table structure for test_resume
-- ----------------------------
DROP TABLE IF EXISTS `test_resume`;
CREATE TABLE `test_resume` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '姓名',
  `sex` varchar(2) DEFAULT NULL COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '出生日期',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机号',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `address` varchar(255) DEFAULT NULL COMMENT '现住址',
  `native_place` varchar(200) DEFAULT NULL COMMENT '籍贯',
  `nation` varchar(100) DEFAULT NULL COMMENT '民族',
  `political_outlook` varchar(50) DEFAULT NULL COMMENT '政治面貌',
  `education` varchar(10) DEFAULT NULL COMMENT '学历',
  `graduation_school` varchar(50) DEFAULT NULL COMMENT '毕业院校',
  `self_evaluation` varchar(255) DEFAULT NULL COMMENT '自我评价',
  `salary_expectation` decimal(10,2) DEFAULT NULL COMMENT '期望薪资',
  `edu_experience` varchar(255) DEFAULT NULL COMMENT '教育经历',
  `work_experience` varchar(255) DEFAULT NULL COMMENT '工作经历',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of test_resume
-- ----------------------------
INSERT INTO `test_resume` VALUES ('1', '12', '2', '2025-01-02', '18611788532', '111@11.com', null, null, null, null, null, null, null, null, null, null);
INSERT INTO `test_resume` VALUES ('2', '12', '2', '2025-01-02', '18611788532', '111@11.com', null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for tmp_report_data_1
-- ----------------------------
DROP TABLE IF EXISTS `tmp_report_data_1`;
CREATE TABLE `tmp_report_data_1` (
  `monty` varchar(255) DEFAULT NULL COMMENT '月份',
  `main_income` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `his_lowest` decimal(10,2) DEFAULT NULL,
  `his_average` decimal(10,2) DEFAULT NULL,
  `his_highest` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tmp_report_data_1
-- ----------------------------
INSERT INTO `tmp_report_data_1` VALUES ('1月', '483834.66', '483834.66', '57569.77', '216797.62', '483834.66');
INSERT INTO `tmp_report_data_1` VALUES ('2月', '11666578.65', '12150413.31', '22140.00', '4985361.57', '11666578.65');
INSERT INTO `tmp_report_data_1` VALUES ('3月', '27080982.08', '39231395.39', '73106.29', '16192642.30', '27080982.08');
INSERT INTO `tmp_report_data_1` VALUES ('4月', '0.00', '39231395.39', '73106.29', '8513415.34', '17428381.40');
INSERT INTO `tmp_report_data_1` VALUES ('5月', '0.00', '39231395.39', null, null, null);
INSERT INTO `tmp_report_data_1` VALUES ('6月', '0.00', '39231395.39', null, null, null);
INSERT INTO `tmp_report_data_1` VALUES ('7月', '0.00', '39231395.39', null, null, null);
INSERT INTO `tmp_report_data_1` VALUES ('8月', '0.00', '39231395.39', null, null, null);
INSERT INTO `tmp_report_data_1` VALUES ('9月', '0.00', '39231395.39', null, null, null);
INSERT INTO `tmp_report_data_1` VALUES ('10月', '0.00', '39231395.39', null, null, null);
INSERT INTO `tmp_report_data_1` VALUES ('11月', '0.00', '39231395.39', null, null, null);
INSERT INTO `tmp_report_data_1` VALUES ('12月', '0.00', '39231395.39', null, null, null);

-- ----------------------------
-- Table structure for tmp_report_data_income
-- ----------------------------
DROP TABLE IF EXISTS `tmp_report_data_income`;
CREATE TABLE `tmp_report_data_income` (
  `biz_income` varchar(100) DEFAULT NULL,
  `bx_jj_yongjin` decimal(10,2) DEFAULT NULL,
  `bx_zx_money` decimal(10,2) DEFAULT NULL,
  `chengbao_gz_money` decimal(10,2) DEFAULT NULL,
  `bx_gg_moeny` decimal(10,2) DEFAULT NULL,
  `tb_zx_money` decimal(10,2) DEFAULT NULL,
  `neikong_zx_money` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tmp_report_data_income
-- ----------------------------
INSERT INTO `tmp_report_data_income` VALUES ('中国石油全资（集团所属）', '37134.58', '1099273.32', '0.00', '0.00', '0.00', '226415.09', '38460270.57');
INSERT INTO `tmp_report_data_income` VALUES ('中国石油全资（股份所属）', '227595.77', '0.00', '0.00', '0.00', '0.00', '0.00', '227595.77');
INSERT INTO `tmp_report_data_income` VALUES ('中石油控股或有控股权', '310628.11', '369298.64', '0.00', '0.00', '0.00', '0.00', '679926.75');
INSERT INTO `tmp_report_data_income` VALUES ('中石油参股', '72062.45', '0.00', '0.00', '0.00', '0.00', '0.00', '72062.75');
INSERT INTO `tmp_report_data_income` VALUES ('非中石油', '1486526.90', '212070.72', '0.00', '0.00', '0.00', '226415.09', '1698597.62');
