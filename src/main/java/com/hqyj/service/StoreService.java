package com.hqyj.service;

import com.hqyj.pojo.Store;

import java.util.HashMap;

/**
 * @author 文宏
 * @date 2020/8/3
 */
public interface StoreService {
    HashMap<String, Object> storeList(Store store);
}
