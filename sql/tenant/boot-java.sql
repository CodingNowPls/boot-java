

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for demo2
-- ----------------------------
DROP TABLE IF EXISTS `demo2`;
CREATE TABLE `demo2` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of demo2
-- ----------------------------
INSERT INTO `demo2` VALUES ('1', '测试1742185783524');
INSERT INTO `demo2` VALUES ('2', '测试1742185783487');
INSERT INTO `demo2` VALUES ('3', '测试1742185892028');
INSERT INTO `demo2` VALUES ('4', '测试1742185981517');
INSERT INTO `demo2` VALUES ('5', '测试1742191119831');

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
INSERT INTO `flw_ext_instance` VALUES ('1882309027063050241', null, '1882302139126718465', '请假审批', null, '{\"name\":\"请假审批\",\"key\":\"process\",\"nodeConfig\":{\"nodeName\":\"发起人\",\"nodeKey\":\"001\",\"type\":0,\"childNode\":{\"nodeName\":\"条件路由\",\"nodeKey\":\"002\",\"type\":4,\"conditionNodes\":[{\"nodeName\":\"长期\",\"nodeKey\":\"0021\",\"type\":3,\"priorityLevel\":1,\"conditionList\":[[{\"label\":\"请假天数\",\"field\":\"day\",\"operator\":\">\",\"value\":\"7\"}]],\"childNode\":{\"nodeName\":\"领导审批\",\"nodeKey\":\"0022\",\"type\":1,\"setType\":1,\"nodeAssigneeList\":[{\"id\":\"test001\",\"name\":\"何敏\"}],\"examineLevel\":1,\"examineMode\":1,\"directorLevel\":1,\"directorMode\":0,\"selectMode\":1,\"termAuto\":false,\"term\":0,\"termMode\":1}},{\"nodeName\":\"短期\",\"nodeKey\":\"0031\",\"type\":3,\"priorityLevel\":2,\"childNode\":{\"nodeName\":\"直接主管审批\",\"nodeKey\":\"0032\",\"type\":1,\"setType\":2,\"nodeAssigneeList\":[{\"id\":\"zg0001\",\"name\":\"张三\"}],\"examineLevel\":1,\"examineMode\":1,\"directorLevel\":1,\"directorMode\":0,\"selectMode\":1,\"termAuto\":false,\"term\":0,\"termMode\":1}}],\"childNode\":{\"nodeName\":\"抄送人\",\"nodeKey\":\"005\",\"type\":2,\"nodeAssigneeList\":[{\"id\":\"test002\",\"name\":\"何秀英\"}]}}}}');
INSERT INTO `flw_ext_instance` VALUES ('1882309047468339202', null, '1882302139126718465', '请假审批', null, '{\"name\":\"请假审批\",\"key\":\"process\",\"nodeConfig\":{\"nodeName\":\"发起人\",\"nodeKey\":\"001\",\"type\":0,\"childNode\":{\"nodeName\":\"条件路由\",\"nodeKey\":\"002\",\"type\":4,\"conditionNodes\":[{\"nodeName\":\"长期\",\"nodeKey\":\"0021\",\"type\":3,\"priorityLevel\":1,\"conditionList\":[[{\"label\":\"请假天数\",\"field\":\"day\",\"operator\":\">\",\"value\":\"7\"}]],\"childNode\":{\"nodeName\":\"领导审批\",\"nodeKey\":\"0022\",\"type\":1,\"setType\":1,\"nodeAssigneeList\":[{\"id\":\"test001\",\"name\":\"何敏\"}],\"examineLevel\":1,\"examineMode\":1,\"directorLevel\":1,\"directorMode\":0,\"selectMode\":1,\"termAuto\":false,\"term\":0,\"termMode\":1}},{\"nodeName\":\"短期\",\"nodeKey\":\"0031\",\"type\":3,\"priorityLevel\":2,\"childNode\":{\"nodeName\":\"直接主管审批\",\"nodeKey\":\"0032\",\"type\":1,\"setType\":2,\"nodeAssigneeList\":[{\"id\":\"zg0001\",\"name\":\"张三\"}],\"examineLevel\":1,\"examineMode\":1,\"directorLevel\":1,\"directorMode\":0,\"selectMode\":1,\"termAuto\":false,\"term\":0,\"termMode\":1}}],\"childNode\":{\"nodeName\":\"抄送人\",\"nodeKey\":\"005\",\"type\":2,\"nodeAssigneeList\":[{\"id\":\"test002\",\"name\":\"何秀英\"}]}}}}');
INSERT INTO `flw_ext_instance` VALUES ('1882309052967071745', null, '1882302139126718465', '请假审批', null, '{\"name\":\"请假审批\",\"key\":\"process\",\"nodeConfig\":{\"nodeName\":\"发起人\",\"nodeKey\":\"001\",\"type\":0,\"childNode\":{\"nodeName\":\"条件路由\",\"nodeKey\":\"002\",\"type\":4,\"conditionNodes\":[{\"nodeName\":\"长期\",\"nodeKey\":\"0021\",\"type\":3,\"priorityLevel\":1,\"conditionList\":[[{\"label\":\"请假天数\",\"field\":\"day\",\"operator\":\">\",\"value\":\"7\"}]],\"childNode\":{\"nodeName\":\"领导审批\",\"nodeKey\":\"0022\",\"type\":1,\"setType\":1,\"nodeAssigneeList\":[{\"id\":\"test001\",\"name\":\"何敏\"}],\"examineLevel\":1,\"examineMode\":1,\"directorLevel\":1,\"directorMode\":0,\"selectMode\":1,\"termAuto\":false,\"term\":0,\"termMode\":1}},{\"nodeName\":\"短期\",\"nodeKey\":\"0031\",\"type\":3,\"priorityLevel\":2,\"childNode\":{\"nodeName\":\"直接主管审批\",\"nodeKey\":\"0032\",\"type\":1,\"setType\":2,\"nodeAssigneeList\":[{\"id\":\"zg0001\",\"name\":\"张三\"}],\"examineLevel\":1,\"examineMode\":1,\"directorLevel\":1,\"directorMode\":0,\"selectMode\":1,\"termAuto\":false,\"term\":0,\"termMode\":1}}],\"childNode\":{\"nodeName\":\"抄送人\",\"nodeKey\":\"005\",\"type\":2,\"nodeAssigneeList\":[{\"id\":\"test002\",\"name\":\"何秀英\"}]}}}}');
INSERT INTO `flw_ext_instance` VALUES ('1882309057048129537', null, '1882302139126718465', '请假审批', null, '{\"name\":\"请假审批\",\"key\":\"process\",\"nodeConfig\":{\"nodeName\":\"发起人\",\"nodeKey\":\"001\",\"type\":0,\"childNode\":{\"nodeName\":\"条件路由\",\"nodeKey\":\"002\",\"type\":4,\"conditionNodes\":[{\"nodeName\":\"长期\",\"nodeKey\":\"0021\",\"type\":3,\"priorityLevel\":1,\"conditionList\":[[{\"label\":\"请假天数\",\"field\":\"day\",\"operator\":\">\",\"value\":\"7\"}]],\"childNode\":{\"nodeName\":\"领导审批\",\"nodeKey\":\"0022\",\"type\":1,\"setType\":1,\"nodeAssigneeList\":[{\"id\":\"test001\",\"name\":\"何敏\"}],\"examineLevel\":1,\"examineMode\":1,\"directorLevel\":1,\"directorMode\":0,\"selectMode\":1,\"termAuto\":false,\"term\":0,\"termMode\":1}},{\"nodeName\":\"短期\",\"nodeKey\":\"0031\",\"type\":3,\"priorityLevel\":2,\"childNode\":{\"nodeName\":\"直接主管审批\",\"nodeKey\":\"0032\",\"type\":1,\"setType\":2,\"nodeAssigneeList\":[{\"id\":\"zg0001\",\"name\":\"张三\"}],\"examineLevel\":1,\"examineMode\":1,\"directorLevel\":1,\"directorMode\":0,\"selectMode\":1,\"termAuto\":false,\"term\":0,\"termMode\":1}}],\"childNode\":{\"nodeName\":\"抄送人\",\"nodeKey\":\"005\",\"type\":2,\"nodeAssigneeList\":[{\"id\":\"test002\",\"name\":\"何秀英\"}]}}}}');
INSERT INTO `flw_ext_instance` VALUES ('1882311147153698818', null, '1882302139126718465', '请假审批', null, '{\"name\":\"请假审批\",\"key\":\"process\",\"nodeConfig\":{\"nodeName\":\"发起人\",\"nodeKey\":\"001\",\"type\":0,\"childNode\":{\"nodeName\":\"条件路由\",\"nodeKey\":\"002\",\"type\":4,\"conditionNodes\":[{\"nodeName\":\"长期\",\"nodeKey\":\"0021\",\"type\":3,\"priorityLevel\":1,\"conditionList\":[[{\"label\":\"请假天数\",\"field\":\"day\",\"operator\":\">\",\"value\":\"7\"}]],\"childNode\":{\"nodeName\":\"领导审批\",\"nodeKey\":\"0022\",\"type\":1,\"setType\":1,\"nodeAssigneeList\":[{\"id\":\"test001\",\"name\":\"何敏\"}],\"examineLevel\":1,\"examineMode\":1,\"directorLevel\":1,\"directorMode\":0,\"selectMode\":1,\"termAuto\":false,\"term\":0,\"termMode\":1}},{\"nodeName\":\"短期\",\"nodeKey\":\"0031\",\"type\":3,\"priorityLevel\":2,\"childNode\":{\"nodeName\":\"直接主管审批\",\"nodeKey\":\"0032\",\"type\":1,\"setType\":2,\"nodeAssigneeList\":[{\"id\":\"zg0001\",\"name\":\"张三\"}],\"examineLevel\":1,\"examineMode\":1,\"directorLevel\":1,\"directorMode\":0,\"selectMode\":1,\"termAuto\":false,\"term\":0,\"termMode\":1}}],\"childNode\":{\"nodeName\":\"抄送人\",\"nodeKey\":\"005\",\"type\":2,\"nodeAssigneeList\":[{\"id\":\"test002\",\"name\":\"何秀英\"}]}}}}');
INSERT INTO `flw_ext_instance` VALUES ('1882311478226944001', null, '1882302139126718465', '请假审批', null, '{\"name\":\"请假审批\",\"key\":\"process\",\"nodeConfig\":{\"nodeName\":\"发起人\",\"nodeKey\":\"001\",\"type\":0,\"childNode\":{\"nodeName\":\"条件路由\",\"nodeKey\":\"002\",\"type\":4,\"conditionNodes\":[{\"nodeName\":\"长期\",\"nodeKey\":\"0021\",\"type\":3,\"priorityLevel\":1,\"conditionList\":[[{\"label\":\"请假天数\",\"field\":\"day\",\"operator\":\">\",\"value\":\"7\"}]],\"childNode\":{\"nodeName\":\"领导审批\",\"nodeKey\":\"0022\",\"type\":1,\"setType\":1,\"nodeAssigneeList\":[{\"id\":\"test001\",\"name\":\"何敏\"}],\"examineLevel\":1,\"examineMode\":1,\"directorLevel\":1,\"directorMode\":0,\"selectMode\":1,\"termAuto\":false,\"term\":0,\"termMode\":1}},{\"nodeName\":\"短期\",\"nodeKey\":\"0031\",\"type\":3,\"priorityLevel\":2,\"childNode\":{\"nodeName\":\"直接主管审批\",\"nodeKey\":\"0032\",\"type\":1,\"setType\":2,\"nodeAssigneeList\":[{\"id\":\"zg0001\",\"name\":\"张三\"}],\"examineLevel\":1,\"examineMode\":1,\"directorLevel\":1,\"directorMode\":0,\"selectMode\":1,\"termAuto\":false,\"term\":0,\"termMode\":1}}],\"childNode\":{\"nodeName\":\"抄送人\",\"nodeKey\":\"005\",\"type\":2,\"nodeAssigneeList\":[{\"id\":\"test002\",\"name\":\"何秀英\"}]}}}}');

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
INSERT INTO `flw_his_instance` VALUES ('1882309027063050241', null, 'test001', '测试001', '2025-01-23 14:06:58', '1882302139126718465', null, null, null, null, '{\"assignee\":\"test001\",\"day\":8}', '领导审批', '0022', null, '测试001', '2025-01-23 14:06:59', '0', null, null);
INSERT INTO `flw_his_instance` VALUES ('1882309047468339202', null, 'test001', '测试001', '2025-01-23 14:07:03', '1882302139126718465', null, null, null, null, '{\"assignee\":\"test001\",\"day\":8}', '领导审批', '0022', null, '测试001', '2025-01-23 14:07:03', '0', null, null);
INSERT INTO `flw_his_instance` VALUES ('1882309052967071745', null, 'test001', '测试001', '2025-01-23 14:07:04', '1882302139126718465', null, null, null, null, '{\"assignee\":\"test001\",\"day\":8}', '领导审批', '0022', null, '测试001', '2025-01-23 14:07:05', '0', null, null);
INSERT INTO `flw_his_instance` VALUES ('1882309057048129537', null, 'test001', '测试001', '2025-01-23 14:07:05', '1882302139126718465', null, null, null, null, '{\"assignee\":\"test001\",\"day\":8}', '领导审批', '0022', null, '测试001', '2025-01-23 14:07:06', '0', null, null);
INSERT INTO `flw_his_instance` VALUES ('1882311147153698818', null, 'test001', '测试001', '2025-01-23 14:15:24', '1882302139126718465', null, null, null, null, '{\"assignee\":\"test001\",\"day\":8}', '领导审批', '0022', null, '测试001', '2025-01-23 14:15:24', '0', null, null);
INSERT INTO `flw_his_instance` VALUES ('1882311478226944001', null, 'test001', '测试001', '2025-01-23 14:16:43', '1882302139126718465', null, null, null, null, '{\"assignee\":\"test001\",\"day\":8}', '领导审批', '0022', null, '测试001', '2025-01-23 14:16:43', '0', null, null);

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
INSERT INTO `flw_his_task` VALUES ('1882309028027740161', null, 'test001', '测试001', '2025-01-23 14:06:58', '1882309027063050241', '0', null, null, '发起人', '001', '0', '0', null, '{\"assignee\":\"test001\",\"day\":8}', null, null, null, null, '0', '0', '2025-01-23 14:06:59', '2', '89');
INSERT INTO `flw_his_task` VALUES ('1882309047535448065', null, 'test001', '测试001', '2025-01-23 14:07:03', '1882309047468339202', '0', null, null, '发起人', '001', '0', '0', null, '{\"assignee\":\"test001\",\"day\":8}', null, null, null, null, '0', '0', '2025-01-23 14:07:03', '2', '11');
INSERT INTO `flw_his_task` VALUES ('1882309053042569217', null, 'test001', '测试001', '2025-01-23 14:07:05', '1882309052967071745', '0', null, null, '发起人', '001', '0', '0', null, '{\"assignee\":\"test001\",\"day\":8}', null, null, null, null, '0', '0', '2025-01-23 14:07:05', '2', '11');
INSERT INTO `flw_his_task` VALUES ('1882309057144598529', null, 'test001', '测试001', '2025-01-23 14:07:05', '1882309057048129537', '0', null, null, '发起人', '001', '0', '0', null, '{\"assignee\":\"test001\",\"day\":8}', null, null, null, null, '0', '0', '2025-01-23 14:07:05', '2', '14');
INSERT INTO `flw_his_task` VALUES ('1882311147220807681', null, 'test001', '测试001', '2025-01-23 14:15:24', '1882311147153698818', '0', null, null, '发起人', '001', '0', '0', null, '{\"assignee\":\"test001\",\"day\":8}', null, null, null, null, '0', '0', '2025-01-23 14:15:24', '2', '10');
INSERT INTO `flw_his_task` VALUES ('1882311479179051009', null, 'test001', '测试001', '2025-01-23 14:16:43', '1882311478226944001', '0', null, null, '发起人', '001', '0', '0', null, '{\"assignee\":\"test001\",\"day\":8}', null, null, null, null, '0', '0', '2025-01-23 14:16:43', '2', '95');

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
INSERT INTO `flw_his_task_actor` VALUES ('1882309028124209154', null, '1882309027063050241', '1882309028027740161', 'test001', '测试001', '0', null, null, null, null);
INSERT INTO `flw_his_task_actor` VALUES ('1882309047581585410', null, '1882309047468339202', '1882309047535448065', 'test001', '测试001', '0', null, null, null, null);
INSERT INTO `flw_his_task_actor` VALUES ('1882309053084512257', null, '1882309052967071745', '1882309053042569217', 'test001', '测试001', '0', null, null, null, null);
INSERT INTO `flw_his_task_actor` VALUES ('1882309057182347265', null, '1882309057048129537', '1882309057144598529', 'test001', '测试001', '0', null, null, null, null);
INSERT INTO `flw_his_task_actor` VALUES ('1882311147250167809', null, '1882311147153698818', '1882311147220807681', 'test001', '测试001', '0', null, null, null, null);
INSERT INTO `flw_his_task_actor` VALUES ('1882311479262937089', null, '1882311478226944001', '1882311479179051009', 'test001', '测试001', '0', null, null, null, null);

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
INSERT INTO `flw_instance` VALUES ('1882309027063050241', null, 'test001', '测试001', '2025-01-23 14:06:58', '1882302139126718465', null, null, null, null, '{\"assignee\":\"test001\",\"day\":8}', '领导审批', '0022', null, '测试001', '2025-01-23 14:06:59');
INSERT INTO `flw_instance` VALUES ('1882309047468339202', null, 'test001', '测试001', '2025-01-23 14:07:03', '1882302139126718465', null, null, null, null, '{\"assignee\":\"test001\",\"day\":8}', '领导审批', '0022', null, '测试001', '2025-01-23 14:07:03');
INSERT INTO `flw_instance` VALUES ('1882309052967071745', null, 'test001', '测试001', '2025-01-23 14:07:04', '1882302139126718465', null, null, null, null, '{\"assignee\":\"test001\",\"day\":8}', '领导审批', '0022', null, '测试001', '2025-01-23 14:07:05');
INSERT INTO `flw_instance` VALUES ('1882309057048129537', null, 'test001', '测试001', '2025-01-23 14:07:05', '1882302139126718465', null, null, null, null, '{\"assignee\":\"test001\",\"day\":8}', '领导审批', '0022', null, '测试001', '2025-01-23 14:07:06');
INSERT INTO `flw_instance` VALUES ('1882311147153698818', null, 'test001', '测试001', '2025-01-23 14:15:24', '1882302139126718465', null, null, null, null, '{\"assignee\":\"test001\",\"day\":8}', '领导审批', '0022', null, '测试001', '2025-01-23 14:15:24');
INSERT INTO `flw_instance` VALUES ('1882311478226944001', null, 'test001', '测试001', '2025-01-23 14:16:43', '1882302139126718465', null, null, null, null, '{\"assignee\":\"test001\",\"day\":8}', '领导审批', '0022', null, '测试001', '2025-01-23 14:16:43');

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
INSERT INTO `flw_process` VALUES ('1882302139126718465', null, 'test001', '测试001', '2025-01-23 13:39:36', 'process', '请假审批', null, null, '1', null, null, '0', '1', '{\"name\":\"请假审批\",\"key\":\"process\",\"nodeConfig\":{\"nodeName\":\"发起人\",\"nodeKey\":\"001\",\"type\":0,\"childNode\":{\"nodeName\":\"条件路由\",\"nodeKey\":\"002\",\"type\":4,\"conditionNodes\":[{\"nodeName\":\"长期\",\"nodeKey\":\"0021\",\"type\":3,\"priorityLevel\":1,\"conditionList\":[[{\"label\":\"请假天数\",\"field\":\"day\",\"operator\":\">\",\"value\":\"7\"}]],\"childNode\":{\"nodeName\":\"领导审批\",\"nodeKey\":\"0022\",\"type\":1,\"setType\":1,\"nodeAssigneeList\":[{\"id\":\"test001\",\"name\":\"何敏\"}],\"examineLevel\":1,\"examineMode\":1,\"directorLevel\":1,\"directorMode\":0,\"selectMode\":1,\"termAuto\":false,\"term\":0,\"termMode\":1}},{\"nodeName\":\"短期\",\"nodeKey\":\"0031\",\"type\":3,\"priorityLevel\":2,\"childNode\":{\"nodeName\":\"直接主管审批\",\"nodeKey\":\"0032\",\"type\":1,\"setType\":2,\"nodeAssigneeList\":[{\"id\":\"zg0001\",\"name\":\"张三\"}],\"examineLevel\":1,\"examineMode\":1,\"directorLevel\":1,\"directorMode\":0,\"selectMode\":1,\"termAuto\":false,\"term\":0,\"termMode\":1}}],\"childNode\":{\"nodeName\":\"抄送人\",\"nodeKey\":\"005\",\"type\":2,\"nodeAssigneeList\":[{\"id\":\"test002\",\"name\":\"何秀英\"}]}}}}', '0');

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
INSERT INTO `flw_task` VALUES ('1882309028312952833', null, 'test001', '测试001', '2025-01-23 14:06:59', '1882309027063050241', '1882309028027740161', '领导审批', '0022', '1', '1', null, '{\"assignee\":\"test001\",\"day\":8}', null, null, null, null, '0', '0');
INSERT INTO `flw_task` VALUES ('1882309047627722754', null, 'test001', '测试001', '2025-01-23 14:07:03', '1882309047468339202', '1882309047535448065', '领导审批', '0022', '1', '1', null, '{\"assignee\":\"test001\",\"day\":8}', null, null, null, null, '0', '0');
INSERT INTO `flw_task` VALUES ('1882309053139038209', null, 'test001', '测试001', '2025-01-23 14:07:05', '1882309052967071745', '1882309053042569217', '领导审批', '0022', '1', '1', null, '{\"assignee\":\"test001\",\"day\":8}', null, null, null, null, '0', '0');
INSERT INTO `flw_task` VALUES ('1882309057249456129', null, 'test001', '测试001', '2025-01-23 14:07:06', '1882309057048129537', '1882309057144598529', '领导审批', '0022', '1', '1', null, '{\"assignee\":\"test001\",\"day\":8}', null, null, null, null, '0', '0');
INSERT INTO `flw_task` VALUES ('1882311147296305154', null, 'test001', '测试001', '2025-01-23 14:15:24', '1882311147153698818', '1882311147220807681', '领导审批', '0022', '1', '1', null, '{\"assignee\":\"test001\",\"day\":8}', null, null, null, null, '0', '0');
INSERT INTO `flw_task` VALUES ('1882311479430709250', null, 'test001', '测试001', '2025-01-23 14:16:43', '1882311478226944001', '1882311479179051009', '领导审批', '0022', '1', '1', null, '{\"assignee\":\"test001\",\"day\":8}', null, null, null, null, '0', '0');

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
INSERT INTO `flw_task_actor` VALUES ('1882309028329730049', null, '1882309027063050241', '1882309028312952833', 'test001', '何敏', '0', null, null, null, null);
INSERT INTO `flw_task_actor` VALUES ('1882309047636111362', null, '1882309047468339202', '1882309047627722754', 'test001', '何敏', '0', null, null, null, null);
INSERT INTO `flw_task_actor` VALUES ('1882309053151621121', null, '1882309052967071745', '1882309053139038209', 'test001', '何敏', '0', null, null, null, null);
INSERT INTO `flw_task_actor` VALUES ('1882309057262039041', null, '1882309057048129537', '1882309057249456129', 'test001', '何敏', '0', null, null, null, null);
INSERT INTO `flw_task_actor` VALUES ('1882311479434903553', null, '1882311478226944001', '1882311479430709250', 'test001', '何敏', '0', null, null, null, null);

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
-- Records of gen_table_column
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
-- Table structure for sys_attachments
-- ----------------------------
DROP TABLE IF EXISTS `sys_attachments`;
CREATE TABLE `sys_attachments` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `file_name` varchar(255) NOT NULL COMMENT '文件名称',
  `file_type` varchar(50) NOT NULL COMMENT '文件类型',
  `upload_time` datetime NOT NULL COMMENT '上传时间',
  `file_size` bigint(20) NOT NULL COMMENT '文件大小（字节）',
  `file_path` varchar(512) NOT NULL COMMENT '文件存储路径',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='附件表';

-- ----------------------------
-- Records of sys_attachments
-- ----------------------------

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
INSERT INTO `sys_config` VALUES ('3', '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-light', 'Y', 'admin', '2024-12-12 12:22:06', 'admin', '2025-04-07 16:29:33', '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES ('4', '账号自助-验证码开关', 'sys.account.captchaEnabled', 'false', 'Y', 'admin', '2024-12-12 12:22:06', 'admin', '2025-04-07 16:26:31', '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES ('5', '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2024-12-12 12:22:06', 'admin', '2025-04-07 15:46:43', '是否开启注册用户功能（true开启，false关闭）');
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
  `tenant_id` bigint(11) DEFAULT NULL COMMENT '租户ID',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COMMENT='部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('100', '0', '0', '科技公司', '0', 'boot', '15888888888', 'boot@qq.com', '0', '0', 'admin', '2024-12-12 12:22:06', 'admin', '2024-12-19 12:21:36', null);
INSERT INTO `sys_dept` VALUES ('101', '100', '0,100', '总公司', '1', 'boot', '15888888888', 'boot@qq.com', '0', '0', 'admin', '2024-12-12 12:22:06', 'admin', '2024-12-12 14:23:29', null);
INSERT INTO `sys_dept` VALUES ('103', '101', '0,100,101', '研发部门', '1', 'boot', '15888888888', 'boot@qq.com', '0', '0', 'admin', '2024-12-12 12:22:06', '', null, null);
INSERT INTO `sys_dept` VALUES ('105', '101', '0,100,101', '测试部门', '3', 'boot', '15888888888', 'boot@qq.com', '0', '0', 'admin', '2024-12-12 12:22:06', '', null, null);
INSERT INTO `sys_dept` VALUES ('106', '101', '0,100,101', '财务部门', '4', 'boot', '15888888888', 'boot@qq.com', '0', '0', 'admin', '2024-12-12 12:22:06', '', null, null);

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
INSERT INTO `sys_dict_type` VALUES ('1', '用户性别', 'sys_user_sex', '0', 'admin', '2024-12-12 12:22:06', 'admin', '2024-12-19 12:21:48', '用户性别列表');
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
INSERT INTO `sys_job` VALUES ('1', '系统默认（无参）', 'DEFAULT', 'bootTask.noParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2024-12-12 12:22:06', 'admin', '2024-12-19 14:39:03', '');
INSERT INTO `sys_job` VALUES ('2', '系统默认（有参）', 'DEFAULT', 'bootTask.params(\'boot\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2024-12-12 12:22:06', 'admin', '2024-12-19 14:39:11', '');
INSERT INTO `sys_job` VALUES ('3', '系统默认（多参）', 'DEFAULT', 'bootTask.multipleParams(\'boot\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2024-12-12 12:22:06', 'admin', '2024-12-19 14:39:19', '');

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
) ENGINE=InnoDB AUTO_INCREMENT=433 DEFAULT CHARSET=utf8mb4 COMMENT='系统访问记录';

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES ('244', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-02-27 16:52:28');
INSERT INTO `sys_logininfor` VALUES ('245', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-06 17:09:13');
INSERT INTO `sys_logininfor` VALUES ('246', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-06 18:14:51');
INSERT INTO `sys_logininfor` VALUES ('247', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-08 17:25:57');
INSERT INTO `sys_logininfor` VALUES ('248', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-08 17:27:02');
INSERT INTO `sys_logininfor` VALUES ('249', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-08 20:05:49');
INSERT INTO `sys_logininfor` VALUES ('250', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-08 20:12:07');
INSERT INTO `sys_logininfor` VALUES ('251', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-08 20:18:20');
INSERT INTO `sys_logininfor` VALUES ('252', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-08 20:19:37');
INSERT INTO `sys_logininfor` VALUES ('253', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-08 20:44:55');
INSERT INTO `sys_logininfor` VALUES ('254', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-08 20:56:24');
INSERT INTO `sys_logininfor` VALUES ('255', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-09 18:09:49');
INSERT INTO `sys_logininfor` VALUES ('256', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-09 18:33:02');
INSERT INTO `sys_logininfor` VALUES ('257', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '密码输入错误1次', '2025-03-13 18:02:12');
INSERT INTO `sys_logininfor` VALUES ('258', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-13 18:02:12');
INSERT INTO `sys_logininfor` VALUES ('259', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-13 18:02:15');
INSERT INTO `sys_logininfor` VALUES ('260', 'admin', '127.0.0.1', '内网IP', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2025-03-13 18:04:00');
INSERT INTO `sys_logininfor` VALUES ('261', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-03-13 18:12:34');
INSERT INTO `sys_logininfor` VALUES ('262', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-13 18:12:41');
INSERT INTO `sys_logininfor` VALUES ('263', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 06:28:32');
INSERT INTO `sys_logininfor` VALUES ('264', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 11:24:56');
INSERT INTO `sys_logininfor` VALUES ('265', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 11:30:44');
INSERT INTO `sys_logininfor` VALUES ('266', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 11:32:07');
INSERT INTO `sys_logininfor` VALUES ('267', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 11:35:28');
INSERT INTO `sys_logininfor` VALUES ('268', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 12:25:43');
INSERT INTO `sys_logininfor` VALUES ('269', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 12:44:38');
INSERT INTO `sys_logininfor` VALUES ('270', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 12:44:38');
INSERT INTO `sys_logininfor` VALUES ('271', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 12:44:39');
INSERT INTO `sys_logininfor` VALUES ('272', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 12:44:39');
INSERT INTO `sys_logininfor` VALUES ('273', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 12:48:55');
INSERT INTO `sys_logininfor` VALUES ('274', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 12:54:08');
INSERT INTO `sys_logininfor` VALUES ('275', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 12:57:40');
INSERT INTO `sys_logininfor` VALUES ('276', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:11:45');
INSERT INTO `sys_logininfor` VALUES ('277', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:18:35');
INSERT INTO `sys_logininfor` VALUES ('278', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:20:13');
INSERT INTO `sys_logininfor` VALUES ('279', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:20:13');
INSERT INTO `sys_logininfor` VALUES ('280', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:20:15');
INSERT INTO `sys_logininfor` VALUES ('281', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:20:15');
INSERT INTO `sys_logininfor` VALUES ('282', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:20:16');
INSERT INTO `sys_logininfor` VALUES ('283', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:20:16');
INSERT INTO `sys_logininfor` VALUES ('284', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:20:27');
INSERT INTO `sys_logininfor` VALUES ('285', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:20:27');
INSERT INTO `sys_logininfor` VALUES ('286', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:21:31');
INSERT INTO `sys_logininfor` VALUES ('287', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:21:35');
INSERT INTO `sys_logininfor` VALUES ('288', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:22:22');
INSERT INTO `sys_logininfor` VALUES ('289', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:22:27');
INSERT INTO `sys_logininfor` VALUES ('290', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:22:46');
INSERT INTO `sys_logininfor` VALUES ('291', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:22:58');
INSERT INTO `sys_logininfor` VALUES ('292', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:26:11');
INSERT INTO `sys_logininfor` VALUES ('293', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:26:16');
INSERT INTO `sys_logininfor` VALUES ('294', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:27:49');
INSERT INTO `sys_logininfor` VALUES ('295', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-03-16 13:28:01');
INSERT INTO `sys_logininfor` VALUES ('296', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:28:06');
INSERT INTO `sys_logininfor` VALUES ('297', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:30:02');
INSERT INTO `sys_logininfor` VALUES ('298', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:30:02');
INSERT INTO `sys_logininfor` VALUES ('299', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:44:25');
INSERT INTO `sys_logininfor` VALUES ('300', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:45:23');
INSERT INTO `sys_logininfor` VALUES ('301', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:45:23');
INSERT INTO `sys_logininfor` VALUES ('302', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 13:45:23');
INSERT INTO `sys_logininfor` VALUES ('303', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 14:02:15');
INSERT INTO `sys_logininfor` VALUES ('304', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 14:02:16');
INSERT INTO `sys_logininfor` VALUES ('305', 'admin1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '密码输入错误1次', '2025-03-16 14:03:39');
INSERT INTO `sys_logininfor` VALUES ('306', 'admin1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-16 14:03:39');
INSERT INTO `sys_logininfor` VALUES ('307', 'admin1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2025-03-16 14:03:48');
INSERT INTO `sys_logininfor` VALUES ('308', 'admin1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '密码输入错误2次', '2025-03-16 14:03:48');
INSERT INTO `sys_logininfor` VALUES ('309', 'admin1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 14:03:52');
INSERT INTO `sys_logininfor` VALUES ('310', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 14:04:12');
INSERT INTO `sys_logininfor` VALUES ('311', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-03-16 14:05:04');
INSERT INTO `sys_logininfor` VALUES ('312', 'admin1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 14:05:09');
INSERT INTO `sys_logininfor` VALUES ('313', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 14:08:52');
INSERT INTO `sys_logininfor` VALUES ('314', 'admin1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 14:12:45');
INSERT INTO `sys_logininfor` VALUES ('315', 'admin1', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-03-16 14:12:49');
INSERT INTO `sys_logininfor` VALUES ('316', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 14:12:55');
INSERT INTO `sys_logininfor` VALUES ('317', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 21:57:00');
INSERT INTO `sys_logininfor` VALUES ('318', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-16 21:57:00');
INSERT INTO `sys_logininfor` VALUES ('319', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-17 15:54:18');
INSERT INTO `sys_logininfor` VALUES ('320', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-23 16:47:45');
INSERT INTO `sys_logininfor` VALUES ('321', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-03-23 16:48:27');
INSERT INTO `sys_logininfor` VALUES ('322', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-23 16:49:03');
INSERT INTO `sys_logininfor` VALUES ('323', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-03-23 16:49:07');
INSERT INTO `sys_logininfor` VALUES ('324', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-23 16:49:30');
INSERT INTO `sys_logininfor` VALUES ('325', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-26 16:26:50');
INSERT INTO `sys_logininfor` VALUES ('326', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '验证码错误', '2025-04-03 11:49:39');
INSERT INTO `sys_logininfor` VALUES ('327', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-03 11:49:43');
INSERT INTO `sys_logininfor` VALUES ('328', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-03 11:56:04');
INSERT INTO `sys_logininfor` VALUES ('329', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-06 11:40:20');
INSERT INTO `sys_logininfor` VALUES ('330', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-06 12:36:13');
INSERT INTO `sys_logininfor` VALUES ('331', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-07 10:44:04');
INSERT INTO `sys_logininfor` VALUES ('332', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-07 12:01:47');
INSERT INTO `sys_logininfor` VALUES ('333', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-07 15:05:42');
INSERT INTO `sys_logininfor` VALUES ('334', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-07 15:06:40');
INSERT INTO `sys_logininfor` VALUES ('335', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-04-07 15:08:31');
INSERT INTO `sys_logininfor` VALUES ('336', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-07 15:08:34');
INSERT INTO `sys_logininfor` VALUES ('337', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-04-07 15:17:56');
INSERT INTO `sys_logininfor` VALUES ('338', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-07 15:18:04');
INSERT INTO `sys_logininfor` VALUES ('339', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-07 15:21:29');
INSERT INTO `sys_logininfor` VALUES ('340', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-07 15:24:07');
INSERT INTO `sys_logininfor` VALUES ('341', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-04-07 15:27:32');
INSERT INTO `sys_logininfor` VALUES ('342', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-07 15:34:07');
INSERT INTO `sys_logininfor` VALUES ('343', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-04-07 15:37:12');
INSERT INTO `sys_logininfor` VALUES ('344', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-07 15:46:10');
INSERT INTO `sys_logininfor` VALUES ('345', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-04-07 15:46:13');
INSERT INTO `sys_logininfor` VALUES ('346', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-07 15:46:30');
INSERT INTO `sys_logininfor` VALUES ('347', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-04-07 15:46:46');
INSERT INTO `sys_logininfor` VALUES ('348', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-07 15:55:44');
INSERT INTO `sys_logininfor` VALUES ('349', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-07 16:10:50');
INSERT INTO `sys_logininfor` VALUES ('350', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-04-07 16:11:08');
INSERT INTO `sys_logininfor` VALUES ('351', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-07 16:26:08');
INSERT INTO `sys_logininfor` VALUES ('352', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-04-07 16:26:14');
INSERT INTO `sys_logininfor` VALUES ('353', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-07 16:26:19');
INSERT INTO `sys_logininfor` VALUES ('354', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-07 16:36:12');
INSERT INTO `sys_logininfor` VALUES ('355', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-04-07 16:55:46');
INSERT INTO `sys_logininfor` VALUES ('356', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-08 09:34:01');
INSERT INTO `sys_logininfor` VALUES ('357', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-04-08 09:39:48');
INSERT INTO `sys_logininfor` VALUES ('358', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-08 10:02:32');
INSERT INTO `sys_logininfor` VALUES ('359', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-04-08 10:04:45');
INSERT INTO `sys_logininfor` VALUES ('360', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-08 10:04:56');
INSERT INTO `sys_logininfor` VALUES ('361', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-04-08 10:12:40');
INSERT INTO `sys_logininfor` VALUES ('362', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-08 10:12:47');
INSERT INTO `sys_logininfor` VALUES ('363', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-04-08 10:12:50');
INSERT INTO `sys_logininfor` VALUES ('364', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-08 10:12:55');
INSERT INTO `sys_logininfor` VALUES ('365', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-08 11:13:59');
INSERT INTO `sys_logininfor` VALUES ('366', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-04-08 11:14:04');
INSERT INTO `sys_logininfor` VALUES ('367', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-08 13:06:39');
INSERT INTO `sys_logininfor` VALUES ('368', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-09 09:27:31');
INSERT INTO `sys_logininfor` VALUES ('369', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-09 09:27:35');
INSERT INTO `sys_logininfor` VALUES ('370', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-09 09:28:00');
INSERT INTO `sys_logininfor` VALUES ('371', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-09 09:28:32');
INSERT INTO `sys_logininfor` VALUES ('372', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-09 09:39:26');
INSERT INTO `sys_logininfor` VALUES ('373', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-09 09:40:29');
INSERT INTO `sys_logininfor` VALUES ('374', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-09 09:41:04');
INSERT INTO `sys_logininfor` VALUES ('375', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-09 09:48:19');
INSERT INTO `sys_logininfor` VALUES ('376', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-09 09:50:15');
INSERT INTO `sys_logininfor` VALUES ('377', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-09 09:51:06');
INSERT INTO `sys_logininfor` VALUES ('378', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-09 09:51:54');
INSERT INTO `sys_logininfor` VALUES ('379', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-09 09:59:43');
INSERT INTO `sys_logininfor` VALUES ('380', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-10 11:00:06');
INSERT INTO `sys_logininfor` VALUES ('381', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '密码输入错误1次', '2025-04-10 11:00:12');
INSERT INTO `sys_logininfor` VALUES ('382', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-10 11:00:12');
INSERT INTO `sys_logininfor` VALUES ('383', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '密码输入错误2次', '2025-04-10 11:01:26');
INSERT INTO `sys_logininfor` VALUES ('384', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-10 11:01:26');
INSERT INTO `sys_logininfor` VALUES ('385', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '密码输入错误3次', '2025-04-10 11:01:57');
INSERT INTO `sys_logininfor` VALUES ('386', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-10 11:01:57');
INSERT INTO `sys_logininfor` VALUES ('387', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '密码输入错误4次', '2025-04-10 11:02:05');
INSERT INTO `sys_logininfor` VALUES ('388', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-10 11:02:05');
INSERT INTO `sys_logininfor` VALUES ('389', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '密码输入错误5次', '2025-04-10 11:04:25');
INSERT INTO `sys_logininfor` VALUES ('390', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-10 11:04:25');
INSERT INTO `sys_logininfor` VALUES ('391', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '密码输入错误5次', '2025-04-10 11:04:28');
INSERT INTO `sys_logininfor` VALUES ('392', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-10 11:04:28');
INSERT INTO `sys_logininfor` VALUES ('393', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2025-04-10 11:04:46');
INSERT INTO `sys_logininfor` VALUES ('394', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-10 11:04:46');
INSERT INTO `sys_logininfor` VALUES ('395', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2025-04-10 11:05:00');
INSERT INTO `sys_logininfor` VALUES ('396', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-10 11:05:00');
INSERT INTO `sys_logininfor` VALUES ('397', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2025-04-10 11:05:14');
INSERT INTO `sys_logininfor` VALUES ('398', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-10 11:05:14');
INSERT INTO `sys_logininfor` VALUES ('399', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2025-04-10 11:06:41');
INSERT INTO `sys_logininfor` VALUES ('400', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-10 11:06:41');
INSERT INTO `sys_logininfor` VALUES ('401', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2025-04-10 11:07:30');
INSERT INTO `sys_logininfor` VALUES ('402', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-10 11:07:30');
INSERT INTO `sys_logininfor` VALUES ('403', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-10 11:08:47');
INSERT INTO `sys_logininfor` VALUES ('404', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-10 11:09:08');
INSERT INTO `sys_logininfor` VALUES ('405', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-04-10 11:20:46');
INSERT INTO `sys_logininfor` VALUES ('406', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-10 11:21:01');
INSERT INTO `sys_logininfor` VALUES ('407', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-10 11:21:02');
INSERT INTO `sys_logininfor` VALUES ('408', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-10 11:21:03');
INSERT INTO `sys_logininfor` VALUES ('409', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-10 11:21:03');
INSERT INTO `sys_logininfor` VALUES ('410', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-10 11:21:03');
INSERT INTO `sys_logininfor` VALUES ('411', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-10 11:21:03');
INSERT INTO `sys_logininfor` VALUES ('412', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-10 11:21:11');
INSERT INTO `sys_logininfor` VALUES ('413', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-10 14:17:19');
INSERT INTO `sys_logininfor` VALUES ('414', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-10 14:17:22');
INSERT INTO `sys_logininfor` VALUES ('415', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-04-10 14:21:52');
INSERT INTO `sys_logininfor` VALUES ('416', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-10 14:22:16');
INSERT INTO `sys_logininfor` VALUES ('417', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-11 09:44:51');
INSERT INTO `sys_logininfor` VALUES ('418', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-11 09:45:53');
INSERT INTO `sys_logininfor` VALUES ('419', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-11 09:48:33');
INSERT INTO `sys_logininfor` VALUES ('420', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-11 10:03:56');
INSERT INTO `sys_logininfor` VALUES ('421', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-11 10:03:56');
INSERT INTO `sys_logininfor` VALUES ('422', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-11 10:04:06');
INSERT INTO `sys_logininfor` VALUES ('423', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-04-11 10:10:01');
INSERT INTO `sys_logininfor` VALUES ('424', 'boot', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-11 10:10:11');
INSERT INTO `sys_logininfor` VALUES ('425', 'boot', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-04-11 10:10:35');
INSERT INTO `sys_logininfor` VALUES ('426', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-11 10:10:42');
INSERT INTO `sys_logininfor` VALUES ('427', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-04-11 10:10:45');
INSERT INTO `sys_logininfor` VALUES ('428', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-11 10:10:49');
INSERT INTO `sys_logininfor` VALUES ('429', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-04-11 10:26:43');
INSERT INTO `sys_logininfor` VALUES ('430', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-11 10:26:45');
INSERT INTO `sys_logininfor` VALUES ('431', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', 'Cannot invoke \"com.boot.common.security.core.domain.model.LoginUser.getUserId()\" because \"loginUser\" is null', '2025-04-11 10:26:46');
INSERT INTO `sys_logininfor` VALUES ('432', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-04-11 10:28:01');

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
  `is_sys` int(1) DEFAULT '1' COMMENT '为`1`标识这个菜单只展示在管理后台中，为`2`标识这个菜单只展示在租户业务后台中',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1067 DEFAULT CHARSET=utf8mb4 COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '系统管理', '0', '1100', 'system', null, '', '1', '0', 'M', '0', '0', '', 'system', 'admin', '2024-12-12 12:22:06', 'admin', '2025-04-07 16:38:02', '系统管理目录', '1');
INSERT INTO `sys_menu` VALUES ('2', '系统监控', '0', '1200', 'monitor', null, '', '1', '0', 'M', '0', '0', '', 'monitor', 'admin', '2024-12-12 12:22:06', 'admin', '2025-04-07 16:36:50', '系统监控目录', '1');
INSERT INTO `sys_menu` VALUES ('3', '系统工具', '0', '1300', 'tool', null, '', '1', '0', 'M', '0', '0', '', 'tool', 'admin', '2024-12-12 12:22:06', 'admin', '2025-04-07 16:36:55', '系统工具目录', '1');
INSERT INTO `sys_menu` VALUES ('100', '用户管理', '1', '1', 'user', 'system/user/index', '', '1', '0', 'C', '0', '0', 'system:user:list', 'user', 'admin', '2024-12-12 12:22:06', '', null, '用户管理菜单', '1');
INSERT INTO `sys_menu` VALUES ('101', '角色管理', '1', '2', 'role', 'system/role/index', '', '1', '0', 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2024-12-12 12:22:06', '', null, '角色管理菜单', '1');
INSERT INTO `sys_menu` VALUES ('102', '菜单管理', '1', '3', 'menu', 'system/menu/index', '', '1', '0', 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2024-12-12 12:22:06', '', null, '菜单管理菜单', '1');
INSERT INTO `sys_menu` VALUES ('103', '部门管理', '1', '4', 'dept', 'system/dept/index', '', '1', '0', 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2024-12-12 12:22:06', '', null, '部门管理菜单', '1');
INSERT INTO `sys_menu` VALUES ('104', '岗位管理', '1', '5', 'post', 'system/post/index', '', '1', '0', 'C', '0', '0', 'system:post:list', 'post', 'admin', '2024-12-12 12:22:06', '', null, '岗位管理菜单', '1');
INSERT INTO `sys_menu` VALUES ('105', '字典管理', '1', '6', 'dict', 'system/dict/index', '', '1', '0', 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2024-12-12 12:22:06', '', null, '字典管理菜单', '1');
INSERT INTO `sys_menu` VALUES ('106', '参数设置', '1', '7', 'config', 'system/config/index', '', '1', '0', 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2024-12-12 12:22:06', '', null, '参数设置菜单', '1');
INSERT INTO `sys_menu` VALUES ('107', '通知公告', '1', '8', 'notice', 'system/notice/index', '', '1', '0', 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2024-12-12 12:22:06', '', null, '通知公告菜单', '1');
INSERT INTO `sys_menu` VALUES ('108', '日志管理', '1', '9', 'log', '', '', '1', '0', 'M', '0', '0', '', 'log', 'admin', '2024-12-12 12:22:06', '', null, '日志管理菜单', '1');
INSERT INTO `sys_menu` VALUES ('109', '在线用户', '2', '1', 'online', 'monitor/online/index', '', '1', '0', 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2024-12-12 12:22:06', '', null, '在线用户菜单', '1');
INSERT INTO `sys_menu` VALUES ('110', '定时任务', '2', '2', 'job', 'monitor/job/index', '', '1', '0', 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2024-12-12 12:22:06', '', null, '定时任务菜单', '1');
INSERT INTO `sys_menu` VALUES ('111', '数据监控', '2', '3', 'druid', 'monitor/druid/index', '', '1', '0', 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2024-12-12 12:22:06', '', null, '数据监控菜单', '1');
INSERT INTO `sys_menu` VALUES ('112', '服务监控', '2', '4', 'server', 'monitor/server/index', '', '1', '0', 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2024-12-12 12:22:06', '', null, '服务监控菜单', '1');
INSERT INTO `sys_menu` VALUES ('113', '缓存监控', '2', '5', 'cache', 'monitor/cache/index', '', '1', '0', 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2024-12-12 12:22:06', '', null, '缓存监控菜单', '1');
INSERT INTO `sys_menu` VALUES ('114', '缓存列表', '2', '6', 'cacheList', 'monitor/cache/list', '', '1', '0', 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2024-12-12 12:22:06', '', null, '缓存列表菜单', '1');
INSERT INTO `sys_menu` VALUES ('115', '表单构建', '3', '1', 'build', 'tool/build/index', '', '1', '0', 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2024-12-12 12:22:06', '', null, '表单构建菜单', '1');
INSERT INTO `sys_menu` VALUES ('116', '代码生成', '3', '2', 'gen', 'tool/gen/index', '', '1', '0', 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2024-12-12 12:22:06', '', null, '代码生成菜单', '1');
INSERT INTO `sys_menu` VALUES ('117', '系统接口', '3', '3', 'swagger', 'tool/swagger/index', '', '1', '0', 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2024-12-12 12:22:06', '', null, '系统接口菜单', '1');
INSERT INTO `sys_menu` VALUES ('500', '操作日志', '108', '1', 'operlog', 'monitor/operlog/index', '', '1', '0', 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2024-12-12 12:22:06', '', null, '操作日志菜单', '1');
INSERT INTO `sys_menu` VALUES ('501', '登录日志', '108', '2', 'logininfor', 'monitor/logininfor/index', '', '1', '0', 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2024-12-12 12:22:06', '', null, '登录日志菜单', '1');
INSERT INTO `sys_menu` VALUES ('1000', '用户查询', '100', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:user:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1001', '用户新增', '100', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:user:add', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1002', '用户修改', '100', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:user:edit', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1003', '用户删除', '100', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:user:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1004', '用户导出', '100', '5', '', '', '', '1', '0', 'F', '0', '0', 'system:user:export', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1005', '用户导入', '100', '6', '', '', '', '1', '0', 'F', '0', '0', 'system:user:import', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1006', '重置密码', '100', '7', '', '', '', '1', '0', 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1007', '角色查询', '101', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:role:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1008', '角色新增', '101', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:role:add', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1009', '角色修改', '101', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:role:edit', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1010', '角色删除', '101', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:role:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1011', '角色导出', '101', '5', '', '', '', '1', '0', 'F', '0', '0', 'system:role:export', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1012', '菜单查询', '102', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1013', '菜单新增', '102', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:add', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1014', '菜单修改', '102', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1015', '菜单删除', '102', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1016', '部门查询', '103', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1017', '部门新增', '103', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:add', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1018', '部门修改', '103', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1019', '部门删除', '103', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1020', '岗位查询', '104', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:post:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1021', '岗位新增', '104', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:post:add', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1022', '岗位修改', '104', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:post:edit', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1023', '岗位删除', '104', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:post:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1024', '岗位导出', '104', '5', '', '', '', '1', '0', 'F', '0', '0', 'system:post:export', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1025', '字典查询', '105', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1026', '字典新增', '105', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:add', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1027', '字典修改', '105', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1028', '字典删除', '105', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1029', '字典导出', '105', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:export', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1030', '参数查询', '106', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1031', '参数新增', '106', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:add', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1032', '参数修改', '106', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:edit', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1033', '参数删除', '106', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1034', '参数导出', '106', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:export', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1035', '公告查询', '107', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1036', '公告新增', '107', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:add', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1037', '公告修改', '107', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1038', '公告删除', '107', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1039', '操作查询', '500', '1', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1040', '操作删除', '500', '2', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1041', '日志导出', '500', '3', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1042', '登录查询', '501', '1', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1043', '登录删除', '501', '2', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1044', '日志导出', '501', '3', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1045', '账户解锁', '501', '4', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1046', '在线查询', '109', '1', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1047', '批量强退', '109', '2', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1048', '单条强退', '109', '3', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1049', '任务查询', '110', '1', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1050', '任务新增', '110', '2', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1051', '任务修改', '110', '3', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1052', '任务删除', '110', '4', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1053', '状态修改', '110', '5', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1054', '任务导出', '110', '6', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1055', '生成查询', '116', '1', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1056', '生成修改', '116', '2', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1057', '生成删除', '116', '3', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1058', '导入代码', '116', '4', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1059', '预览代码', '116', '5', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1060', '生成代码', '116', '6', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2024-12-12 12:22:06', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1062', 'MagicApi', '0', '1400', 'magicApi', null, null, '1', '0', 'M', '0', '0', '', 'code', 'admin', '2025-03-09 18:13:35', 'admin', '2025-04-07 16:36:58', '', '1');
INSERT INTO `sys_menu` VALUES ('1063', '编写代码', '1062', '10', 'http://localhost:8081/magicApi/index.html', null, null, '0', '0', 'C', '0', '0', 'magic:api:code', 'clipboard', 'admin', '2025-03-09 18:15:09', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1064', '租户管理', '0', '100', 'tenant', '', null, '1', '0', 'M', '0', '0', null, 'peoples', 'admin', '2025-04-07 16:39:18', '', null, '', '1');
INSERT INTO `sys_menu` VALUES ('1065', '租户列表', '1064', '10', 'list', 'tenant/index', null, '1', '0', 'M', '0', '0', '', 'list', 'admin', '2025-04-07 16:40:00', 'admin', '2025-04-07 16:40:31', '', '1');
INSERT INTO `sys_menu` VALUES ('1066', '租户菜单', '1064', '20', 'menu', 'tenant/menu', null, '1', '0', 'M', '0', '0', '', 'nested', 'admin', '2025-04-07 16:40:22', 'admin', '2025-04-07 16:40:46', '', '1');

-- ----------------------------
-- Table structure for sys_menu_pack
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu_pack`;
CREATE TABLE `sys_menu_pack` (
  `id` int(11) NOT NULL,
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='菜单包';

-- ----------------------------
-- Records of sys_menu_pack
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu_pack_detail
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu_pack_detail`;
CREATE TABLE `sys_menu_pack_detail` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='菜单包详细';

-- ----------------------------
-- Records of sys_menu_pack_detail
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='通知公告表';

-- ----------------------------
-- Records of sys_notice
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8mb4 COMMENT='操作日志记录';

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES ('126', '操作日志', '3', 'com.boot.system.controller.SysOperlogController.remove()', 'DELETE', '1', 'admin', null, '/monitor/operlog/125,124,123,122,121,120,119,118,117,116,115,114,113,112,111,110,109,108,107,106,105,104,103,102,101,100', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-02-27 13:53:34', '76');
INSERT INTO `sys_oper_log` VALUES ('127', '登录日志', '3', 'com.boot.system.controller.SysLogininforController.remove()', 'DELETE', '1', 'admin', null, '/monitor/logininfor/243,242,241,240,239,238,237,236,235,234,233,232,231,230,229,228,227,226,225,224,223,222,221,220,219,218,217,216,215,214,213,212,211,210,209,208,207,206,205,204,203,202,201,200,199,198,197,196,195,194,193,192,191,190,189,188,187,186,185', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-02-27 13:53:41', '35');
INSERT INTO `sys_oper_log` VALUES ('128', '菜单管理', '1', 'com.boot.system.controller.SysMenuController.add()', 'POST', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"table\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"数据展示\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"/data\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-03-06 18:16:14', '55');
INSERT INTO `sys_oper_log` VALUES ('129', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2024-12-12 12:22:06\",\"icon\":\"system\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1,\"menuName\":\"系统管理\",\"menuType\":\"M\",\"orderNum\":100,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-03-06 18:16:23', '20');
INSERT INTO `sys_oper_log` VALUES ('130', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2024-12-12 12:22:06\",\"icon\":\"monitor\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2,\"menuName\":\"系统监控\",\"menuType\":\"M\",\"orderNum\":200,\"params\":{},\"parentId\":0,\"path\":\"monitor\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-03-06 18:16:30', '12');
INSERT INTO `sys_oper_log` VALUES ('131', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2024-12-12 12:22:06\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":300,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-03-06 18:16:35', '14');
INSERT INTO `sys_oper_log` VALUES ('132', '菜单管理', '1', 'com.boot.system.controller.SysMenuController.add()', 'POST', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"code\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"MagicApi\",\"menuType\":\"M\",\"orderNum\":400,\"params\":{},\"parentId\":0,\"path\":\"magicApi\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-03-09 18:13:36', '60');
INSERT INTO `sys_oper_log` VALUES ('133', '菜单管理', '1', 'com.boot.system.controller.SysMenuController.add()', 'POST', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuName\":\"编写代码\",\"menuType\":\"C\",\"orderNum\":10,\"params\":{},\"parentId\":1062,\"path\":\"writeCode\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"新增菜单\'编写代码\'失败，地址必须以http(s)://开头\",\"code\":500}', '0', null, '2025-03-09 18:14:32', '4');
INSERT INTO `sys_oper_log` VALUES ('134', '菜单管理', '1', 'com.boot.system.controller.SysMenuController.add()', 'POST', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuName\":\"编写代码\",\"menuType\":\"C\",\"orderNum\":10,\"params\":{},\"parentId\":1062,\"path\":\"http://localhost:8081/magic/web/index.html\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-03-09 18:15:09', '10');
INSERT INTO `sys_oper_log` VALUES ('135', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-03-09 18:13:35\",\"icon\":\"code\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1062,\"menuName\":\"MagicApi\",\"menuType\":\"M\",\"orderNum\":400,\"params\":{},\"parentId\":0,\"path\":\"magicApi\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-03-16 06:29:13', '249');
INSERT INTO `sys_oper_log` VALUES ('136', '参数管理', '2', 'com.boot.system.controller.SysConfigController.edit()', 'PUT', '1', 'admin', null, '/system/config', '127.0.0.1', '内网IP', '{\"configId\":4,\"configKey\":\"sys.account.captchaEnabled\",\"configName\":\"账号自助-验证码开关\",\"configType\":\"Y\",\"configValue\":\"true\",\"createBy\":\"admin\",\"createTime\":\"2024-12-12 12:22:06\",\"params\":{},\"remark\":\"是否开启验证码功能（true开启，false关闭）\",\"updateBy\":\"admin\",\"updateTime\":\"2024-12-19 14:19:29\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-03-23 16:48:07', '267');
INSERT INTO `sys_oper_log` VALUES ('137', '参数管理', '2', 'com.boot.system.controller.SysConfigController.edit()', 'PUT', '1', 'admin', null, '/system/config', '127.0.0.1', '内网IP', '{\"configId\":5,\"configKey\":\"sys.account.registerUser\",\"configName\":\"账号自助-是否开启用户注册功能\",\"configType\":\"Y\",\"configValue\":\"true\",\"createBy\":\"admin\",\"createTime\":\"2024-12-12 12:22:06\",\"params\":{},\"remark\":\"是否开启注册用户功能（true开启，false关闭）\",\"updateBy\":\"admin\",\"updateTime\":\"2024-12-23 12:16:32\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-03-23 16:48:19', '13');
INSERT INTO `sys_oper_log` VALUES ('138', '参数管理', '2', 'com.boot.system.controller.SysConfigController.edit()', 'PUT', '1', 'admin', null, '/system/config', '127.0.0.1', '内网IP', '{\"configId\":4,\"configKey\":\"sys.account.captchaEnabled\",\"configName\":\"账号自助-验证码开关\",\"configType\":\"Y\",\"configValue\":\"false\",\"createBy\":\"admin\",\"createTime\":\"2024-12-12 12:22:06\",\"params\":{},\"remark\":\"是否开启验证码功能（true开启，false关闭）\",\"updateBy\":\"admin\",\"updateTime\":\"2025-03-23 16:48:06\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-04-06 11:40:38', '240');
INSERT INTO `sys_oper_log` VALUES ('139', '用户管理', '3', 'com.boot.system.controller.SysUserController.remove()', 'DELETE', '1', 'admin', null, '/system/user/3', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-04-07 11:14:08', '233');
INSERT INTO `sys_oper_log` VALUES ('140', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"icon\":\"code\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1062,\"menuName\":\"MagicApi\",\"menuType\":\"C\",\"orderNum\":400,\"params\":{},\"parentId\":0,\"path\":\"magicApi\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-04-07 11:14:50', '56');
INSERT INTO `sys_oper_log` VALUES ('141', '参数管理', '2', 'com.boot.system.controller.SysConfigController.edit()', 'PUT', '1', 'admin', null, '/system/config', '127.0.0.1', '内网IP', '{\"configId\":5,\"configKey\":\"sys.account.registerUser\",\"configName\":\"账号自助-是否开启用户注册功能\",\"configType\":\"Y\",\"configValue\":\"false\",\"createBy\":\"admin\",\"createTime\":\"2024-12-12 12:22:06\",\"params\":{},\"remark\":\"是否开启注册用户功能（true开启，false关闭）\",\"updateBy\":\"admin\",\"updateTime\":\"2025-03-23 16:48:19\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-04-07 15:46:43', '60');
INSERT INTO `sys_oper_log` VALUES ('142', '账户解锁', '0', 'com.boot.system.controller.SysLogininforController.unlock()', 'GET', '1', 'admin', null, '/monitor/logininfor/unlock/admin', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-04-07 15:56:10', '0');
INSERT INTO `sys_oper_log` VALUES ('143', '账户解锁', '0', 'com.boot.system.controller.SysLogininforController.unlock()', 'GET', '1', 'admin', null, '/monitor/logininfor/unlock/admin', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-04-07 15:56:15', '0');
INSERT INTO `sys_oper_log` VALUES ('144', '参数管理', '2', 'com.boot.system.controller.SysConfigController.edit()', 'PUT', '1', 'admin', null, '/system/config', '127.0.0.1', '内网IP', '{\"configId\":4,\"configKey\":\"sys.account.captchaEnabled\",\"configName\":\"账号自助-验证码开关\",\"configType\":\"Y\",\"configValue\":\"true\",\"createBy\":\"admin\",\"createTime\":\"2024-12-12 12:22:06\",\"params\":{},\"remark\":\"是否开启验证码功能（true开启，false关闭）\",\"updateBy\":\"admin\",\"updateTime\":\"2025-04-06 11:40:37\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-04-07 16:11:04', '15');
INSERT INTO `sys_oper_log` VALUES ('145', '参数管理', '2', 'com.boot.system.controller.SysConfigController.edit()', 'PUT', '1', 'admin', null, '/system/config', '127.0.0.1', '内网IP', '{\"configId\":4,\"configKey\":\"sys.account.captchaEnabled\",\"configName\":\"账号自助-验证码开关\",\"configType\":\"Y\",\"configValue\":\"false\",\"createBy\":\"admin\",\"createTime\":\"2024-12-12 12:22:06\",\"params\":{},\"remark\":\"是否开启验证码功能（true开启，false关闭）\",\"updateBy\":\"admin\",\"updateTime\":\"2025-04-07 16:11:04\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-04-07 16:26:31', '9');
INSERT INTO `sys_oper_log` VALUES ('146', '参数管理', '2', 'com.boot.system.controller.SysConfigController.edit()', 'PUT', '1', 'admin', null, '/system/config', '127.0.0.1', '内网IP', '{\"configId\":3,\"configKey\":\"sys.index.sideTheme\",\"configName\":\"主框架页-侧边栏主题\",\"configType\":\"Y\",\"configValue\":\"theme-light\",\"createBy\":\"admin\",\"createTime\":\"2024-12-12 12:22:06\",\"params\":{},\"remark\":\"深色主题theme-dark，浅色主题theme-light\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-04-07 16:29:33', '14');
INSERT INTO `sys_oper_log` VALUES ('147', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-03-09 18:13:35\",\"icon\":\"code\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1062,\"menuName\":\"MagicApi\",\"menuType\":\"M\",\"orderNum\":400,\"params\":{},\"parentId\":0,\"path\":\"magicApi\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-04-07 16:31:44', '37');
INSERT INTO `sys_oper_log` VALUES ('148', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2024-12-12 12:22:06\",\"icon\":\"system\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1,\"menuName\":\"系统管理\",\"menuType\":\"M\",\"orderNum\":1000,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-04-07 16:36:44', '72');
INSERT INTO `sys_oper_log` VALUES ('149', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2024-12-12 12:22:06\",\"icon\":\"monitor\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2,\"menuName\":\"系统监控\",\"menuType\":\"M\",\"orderNum\":1200,\"params\":{},\"parentId\":0,\"path\":\"monitor\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-04-07 16:36:50', '17');
INSERT INTO `sys_oper_log` VALUES ('150', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2024-12-12 12:22:06\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":1300,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-04-07 16:36:55', '14');
INSERT INTO `sys_oper_log` VALUES ('151', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-03-09 18:13:35\",\"icon\":\"code\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1062,\"menuName\":\"MagicApi\",\"menuType\":\"M\",\"orderNum\":1400,\"params\":{},\"parentId\":0,\"path\":\"magicApi\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-04-07 16:36:58', '14');
INSERT INTO `sys_oper_log` VALUES ('152', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2024-12-12 12:22:06\",\"icon\":\"system\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1,\"menuName\":\"系统管理\",\"menuType\":\"M\",\"orderNum\":1100,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-04-07 16:38:02', '16');
INSERT INTO `sys_oper_log` VALUES ('153', '菜单管理', '1', 'com.boot.system.controller.SysMenuController.add()', 'POST', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"租户管理\",\"menuType\":\"M\",\"orderNum\":100,\"params\":{},\"parentId\":0,\"path\":\"tenant\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-04-07 16:39:18', '12');
INSERT INTO `sys_oper_log` VALUES ('154', '菜单管理', '1', 'com.boot.system.controller.SysMenuController.add()', 'POST', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"租户列表\",\"menuType\":\"M\",\"orderNum\":10,\"params\":{},\"parentId\":1064,\"path\":\"list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-04-07 16:40:00', '10');
INSERT INTO `sys_oper_log` VALUES ('155', '菜单管理', '1', 'com.boot.system.controller.SysMenuController.add()', 'POST', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"租户菜单\",\"menuType\":\"M\",\"orderNum\":20,\"params\":{},\"parentId\":1064,\"path\":\"menu\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-04-07 16:40:22', '8');
INSERT INTO `sys_oper_log` VALUES ('156', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-04-07 16:40:00\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1065,\"menuName\":\"租户列表\",\"menuType\":\"M\",\"orderNum\":10,\"params\":{},\"parentId\":1064,\"path\":\"list\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-04-07 16:40:31', '14');
INSERT INTO `sys_oper_log` VALUES ('157', '菜单管理', '2', 'com.boot.system.controller.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-04-07 16:40:22\",\"icon\":\"nested\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1066,\"menuName\":\"租户菜单\",\"menuType\":\"M\",\"orderNum\":20,\"params\":{},\"parentId\":1064,\"path\":\"menu\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2025-04-07 16:40:46', '15');

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
  `tenant_id` bigint(11) DEFAULT NULL COMMENT '租户ID',
  `is_admin` int(1) DEFAULT '2' COMMENT '标识是否为管理员:  1 : 管理员  2：非管理员',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='角色信息表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '超级管理员', 'admin', '1', '1', '1', '1', '0', '0', 'admin', '2024-12-12 12:22:06', '', null, '超级管理员', '0', '1');
INSERT INTO `sys_role` VALUES ('2', '普通角色', 'normal', '2', '2', '1', '1', '0', '0', 'admin', '2024-12-12 12:22:06', 'boot', '2024-12-19 13:41:40', '普通角色', '0', '2');

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
INSERT INTO `sys_role_menu` VALUES ('2', '100');
INSERT INTO `sys_role_menu` VALUES ('2', '101');
INSERT INTO `sys_role_menu` VALUES ('2', '102');
INSERT INTO `sys_role_menu` VALUES ('2', '103');
INSERT INTO `sys_role_menu` VALUES ('2', '104');
INSERT INTO `sys_role_menu` VALUES ('2', '105');
INSERT INTO `sys_role_menu` VALUES ('2', '106');
INSERT INTO `sys_role_menu` VALUES ('2', '107');
INSERT INTO `sys_role_menu` VALUES ('2', '108');
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

-- ----------------------------
-- Table structure for sys_tenant
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant`;
CREATE TABLE `sys_tenant` (
  `tenant_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '租户ID',
  `tenant_name` varchar(255) DEFAULT NULL COMMENT '租户名称',
  `tenant_code` varchar(255) DEFAULT NULL COMMENT '租户编码',
  `contact_name` varchar(255) DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(255) DEFAULT NULL COMMENT '联系电话',
  `status` varchar(255) DEFAULT NULL COMMENT '0：启用 1： 禁用',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='租户表';

-- ----------------------------
-- Records of sys_tenant
-- ----------------------------
INSERT INTO `sys_tenant` VALUES ('0', '默认', 'default', '测试', '测试', '0', null, '', '2025-04-10 10:59:39', '', '2025-04-10 10:59:45');

-- ----------------------------
-- Table structure for sys_tenant_menu_pack
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant_menu_pack`;
CREATE TABLE `sys_tenant_menu_pack` (
  `id` int(11) NOT NULL,
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='租户菜单包';

-- ----------------------------
-- Records of sys_tenant_menu_pack
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `tenant_id` bigint(11) DEFAULT NULL COMMENT '租户ID',
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
  `is_sys` int(1) DEFAULT '2' COMMENT 'is_sys`标识，只有为`1`的用户才能登录管理后台，管理后台中创建新用户时可以选择',
  `is_admin` int(1) DEFAULT '2' COMMENT '是否是管理员:  1: 管理员  2：非管理员',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '0', '103', 'admin', 'boot', '00', 'boot@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-04-11 10:28:01', 'admin', '2024-12-12 12:22:06', '', '2025-04-11 10:28:01', '管理员', '1', '1');
INSERT INTO `sys_user` VALUES ('2', '0', '105', 'boot', 'boot', '2', 'boot@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-04-11 10:10:11', 'admin', '2024-12-12 12:22:06', 'admin', '2025-04-11 10:10:11', '测试员', '1', '0');
INSERT INTO `sys_user` VALUES ('3', '0', null, 'admin1', 'admin1', '00', '', '', '0', '', '$2a$10$QO2Bm5KxGh0VlOIdRv4GyeHeKqEoFlaEadn8DgeSV3/vtD/yp.EM6', '0', '2', '127.0.0.1', '2025-03-16 14:12:45', '', '2024-12-23 12:15:42', '', '2025-03-16 14:12:45', null, '1', '0');

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
