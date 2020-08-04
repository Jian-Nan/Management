package com.hqyj.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hqyj.dao.StoreMapper;
import com.hqyj.pojo.Store;
import com.hqyj.service.StoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

/**
 * @author 文宏
 * @date 2020/8/3
 */
@Service
public class StoreServiceImpl implements StoreService {

    @Autowired
    private StoreMapper sm;

    @Override
    public HashMap<String, Object> storeList(Store store) {
        PageHelper.startPage(store.getPage(),store.getRow());
        List<Store> storeList = sm.selectByPage(store);
        PageInfo<Store> pageInfo = new PageInfo<>(storeList);
        HashMap<String,Object> pageMap = new HashMap<>(8);
        pageMap.put("list",pageInfo.getList());
        pageMap.put("total",pageInfo.getTotal());
        pageMap.put("prePage",pageInfo.getPrePage()==0?1:pageInfo.getPrePage());
        pageMap.put("nextPage",pageInfo.getNextPage()==0?pageInfo.getNavigateLastPage():pageInfo.getNextPage());
        pageMap.put("firstPage",pageInfo.getNavigateFirstPage());
        pageMap.put("endPage",pageInfo.getNavigateLastPage());
        pageMap.put("pageSize",pageInfo.getPageSize());
        pageMap.put("nowPage",pageInfo.getPageNum());
        return pageMap;
    }
}
