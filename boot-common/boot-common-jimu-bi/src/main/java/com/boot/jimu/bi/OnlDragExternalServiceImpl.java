//package com.boot.jimu.bi;
//
//import cn.hutool.core.util.StrUtil;
//import com.alibaba.fastjson.JSONObject;
//import com.boot.common.core.utils.bean.BeanUtils;
//import org.apache.commons.collections4.CollectionUtils;
//import org.jeecg.modules.drag.service.IOnlDragExternalService;
//import org.jeecg.modules.drag.vo.DragDictModel;
//import org.springframework.stereotype.Service;
//
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//@Service
//public class OnlDragExternalServiceImpl implements IOnlDragExternalService {
//
//
//    /**
//     *  根据多个字典code查询多个字典项
//     * @param codeList
//     * @return key = dictCode ； value=对应的字典项
//     */
//    @Override
//    public Map<String, List<DragDictModel>> getManyDictItems(List<String> codeList, List<JSONObject> tableDictList) {
//        Map<String, List<DragDictModel>> manyDragDictItems  = new HashMap<>();
//        if(!CollectionUtils.isEmpty(codeList)){
//            Map<String, List<DragDictModel>> dictItemsMap = sysBaseApi.getManyDictItems(codeList);
//            dictItemsMap.forEach((k,v)->{
//                List<DragDictModel> dictItems  = new ArrayList<>();
//                v.forEach(dictItem->{
//                    DragDictModel dictModel = new DragDictModel();
//                    BeanUtils.copyProperties(dictItem,dictModel);
//                    dictItems.add(dictModel);
//                });
//                manyDragDictItems.put(k,dictItems);
//            });
//        }
//
//        if(!CollectionUtils.isEmpty(tableDictList)){
//            tableDictList.forEach(item->{
//                List<DragDictModel> dictItems  = new ArrayList<>();
//                JSONObject object = JSONObject.parseObject(item.toString());
//                String dictField = object.getString("dictField");
//                String dictTable = object.getString("dictTable");
//                String dictText = object.getString("dictText");
//                String fieldName = object.getString("fieldName");
//                List<DragDictModel> dictItemsList = sysBaseApi.queryTableDictItemsByCode(dictTable,dictText,dictField);
//                dictItemsList.forEach(dictItem->{
//                    DragDictModel dictModel = new DragDictModel();
//                    BeanUtils.copyProperties(dictItem,dictModel);
//                    dictItems.add(dictModel);
//                });
//                manyDragDictItems.put(fieldName,dictItems);
//            });
//        }
//        return manyDragDictItems;
//    }
//
//    /**
//     *
//     * @param dictCode
//     * @return
//     */
//    @Override
//    public List<DragDictModel> getDictItems(String dictCode) {
//        List<DragDictModel> dictItems  = new ArrayList<>();
//        if(StrUtil.isNotEmpty(dictCode)){
//            List<DragDictModel> dictItemsList = sysBaseApi.getDictItems(dictCode);
//            dictItemsList.forEach(dictItem->{
//                DragDictModel dictModel = new DragDictModel();
//                BeanUtils.copyProperties(dictItem,dictModel);
//                dictItems.add(dictModel);
//            });
//        }
//        return dictItems;
//    }
//
//
//
//
//}