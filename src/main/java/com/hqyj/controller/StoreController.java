package com.hqyj.controller;

import com.hqyj.pojo.Store;
import com.hqyj.service.StoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;

/**
 * @author 文宏
 * @date 2020/8/3
 */
@RequestMapping("store")
@Controller
public class StoreController {

    @Autowired
    private StoreService ss;

    /**
     * 入库操作库存页面
     * @author 文宏
     * @date 2020/8/4
     * @param
     * @return java.lang.String
     */
    @RequestMapping("inStoreListPage.do")
    public String inStoreListPage() {
        return "inStore/showStore";
    }
    @RequestMapping("storeListPage.do")
    public String storeListPage() {
        return "storeManage/showStore";
    }

    @RequestMapping("storeList.ajax")
    @ResponseBody
    public HashMap<String,Object> storeList(Store store) {
        HashMap<String, Object> map = ss.storeList(store);
        return map;
    }

    @RequestMapping("updateStorePage.do")
    public String updateStorePage(Store store) {
        return "storeManage/updateStore";
    } 
    @RequestMapping("updateStore.ajax")
    @ResponseBody
    public String updateStore(Store store) {

        return null;
    }

    @RequestMapping("test.do")
    public String test() {
        return "inStore/test";
    }
}
