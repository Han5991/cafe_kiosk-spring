package com.mycafe.kiosk;

import java.util.ArrayList;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UrlPathHelper;

import com.mycafe.dao.*;
import com.mycafe.beans.*;

@Controller
public class KioskController {

	private static final Logger logger = LoggerFactory.getLogger(KioskController.class);

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		return "login";
	}
	
	@RequestMapping(value = "/loginProcess.do", method = RequestMethod.POST)
	public String loginProcess(@RequestParam String id, HttpServletRequest request) {

		logger.info("Welcome " + id);
		ClientDto.getinstance().setName(id);

		if (id.equals("admin"))
			return "admin/oderlist";
		else
			return "user/first_page";
	}
	
	@RequestMapping(value = { "/Cart.do", "/oder.do", "/menulist.do" })
	public String user(HttpServletRequest request, Model model) {
		UrlPathHelper urls = new UrlPathHelper();
		String url = urls.getOriginatingServletPath(request);
		String returnUrl = "";
		if ("/Cart.do".equals(url)) {
			returnUrl = "user/Cart";
		} else if ("/oder.do".equals(url)) {
			returnUrl = "user/Payment_Result";
		} else if ("/menulist.do".equals(url)) {
			ArrayList<MenuDto> menuDtos1 = MenuDao.getInstance().allmenuType("espresso");
			model.addAttribute("coffee", menuDtos1);
			ArrayList<MenuDto> menuDtos2 = MenuDao.getInstance().allmenuType("blended");
			model.addAttribute("blended", menuDtos2);
			ArrayList<MenuDto> menuDtos3 = MenuDao.getInstance().allmenuType("etc");
			model.addAttribute("etc", menuDtos3);
			ArrayList<MenuDto> menuDtos4 = MenuDao.getInstance().allmenuType("tea");
			model.addAttribute("tea", menuDtos4);
			ArrayList<MenuDto> menuDtos5 = MenuDao.getInstance().allmenuType("dessert");
			model.addAttribute("dessert", menuDtos5);
			returnUrl = "user/menu_list";
		}
		return returnUrl;
	}
	
	@RequestMapping(value = "/showImage")//spring으로 옮길 때 한 쿼리문에서 전부 다룰 수 있게 해보자
	public void showImage(HttpServletRequest request, HttpServletResponse response){
		MenuDao.getInstance().showImage(request, response);
	}
}
