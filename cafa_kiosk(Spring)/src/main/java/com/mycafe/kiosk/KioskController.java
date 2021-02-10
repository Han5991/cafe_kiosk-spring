package com.mycafe.kiosk;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
	public String home(Model model) {
		return "login";
	}

	@RequestMapping(value = "/loginProcess.do", method = RequestMethod.POST)
	public String loginProcess(@RequestParam String id, Model model) {

		logger.info("Welcome " + id);
		ClientDto.getinstance().setName(id);

		if (id.equals("admin")) {
			ArrayList<oderlistDto> alloder = OderDao.getInstance().allOder("조리전");
			model.addAttribute("ex", alloder);
			return "admin/oderlist";
		} else
			return "user/first_page";
	}

	@RequestMapping(value = { "/Cart.do", "/oder.do", "/menulist.do" })
	public String user(HttpServletRequest request, Model model, HttpSession session) {
		UrlPathHelper urls = new UrlPathHelper();
		String url = urls.getOriginatingServletPath(request);
		String returnUrl = "";
		if ("/Cart.do".equals(url)) {
			String menu[] = request.getParameterValues("name");
			String quantity[] = request.getParameterValues("quantity1");
			String price[] = request.getParameterValues("price");
			String sum = request.getParameter("sum");
			ArrayList<oderDto> oderDtos = new ArrayList<oderDto>();
			for (int i = 0; i < menu.length; i++)
				oderDtos.add(new oderDto(menu[i], quantity[i], price[i]));
			session.setAttribute("oderlist", oderDtos);
			session.setAttribute("sum", sum);
			returnUrl = "user/Cart";
		} else if ("/oder.do".equals(url)) {
			ArrayList<oderDto> oderDtos = (ArrayList<oderDto>) session.getAttribute("oderlist");
			String sum = (String) session.getAttribute("sum");
			int odernum = OderDao.getInstance().insertOder(oderDtos, sum);
			System.out.println(odernum);
			model.addAttribute("oderDtos", oderDtos);
			model.addAttribute("odernum", odernum);
			returnUrl = "user/Payment_Result";

		} else if ("/menulist.do".equals(url)) {// 메뉴리스트에 보내줄 메뉴 불러와서 설정해줌
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

	@RequestMapping(value = "/showImage") // spring으로 옮길 때 한 쿼리문에서 전부 다룰 수 있게 해보자
	public void showImage(HttpServletRequest request, HttpServletResponse response) {
		MenuDao.getInstance().showImage(request, response);
	}

	@RequestMapping(value = "/admin_menuInsert.do")
	public String insertmenu(HttpServletRequest request) {
		int a = MenuDao.getInstance().insertMenu(request);
		if (a == 1)
			logger.info("메뉴 삽입 성공");
		return "admin/admin_menuInsert";
	}

	@RequestMapping(value = "/admin_menuDelete.do")
	public String deletemenu(HttpServletRequest request, @RequestParam String name) {
		int a = MenuDao.getInstance().deleteMenu(name);
		if (a == 1)
			logger.info("메뉴 삭제 완료");
		return "admin/admin_menuDelete";
	}

	@RequestMapping(value = "/admin_menuModifyOK.do")
	public String updatemenu(HttpServletRequest request) {
		int a = MenuDao.getInstance().updateMenu(request);
		if (a == 1)
			logger.info("메뉴 수정 완료");
		return "admin/admin_menuModify";
	}

	
	
	
	@RequestMapping(value = "/inventoryUpdate.do")
	public String updateinventory(HttpServletRequest request) {
		MenuDao.getInstance().updateinventory(request);
		return "admin/Inventory_Mangenment";
	}

	@RequestMapping(value = "/receiptPrint.do")
	public String receipPrint(HttpServletRequest request,Model model) {
		String num = request.getParameter("odernum");
		String oder = OderDao.getInstance().getOneOder(num);
		request.setAttribute("oneOder", oder);
		ArrayList<oderlistDto> alloder = OderDao.getInstance().allOder("조리전");
		model.addAttribute("ex", alloder);
		return "receiptPrint";
	}

	@RequestMapping(value = "/deleteOder.do")
	public String deleteOder(HttpServletRequest request,Model model) {
		String num = request.getParameter("odernum");
		OderDao.getInstance().deleteOder(num);
		ArrayList<oderlistDto> alloder = OderDao.getInstance().allOder("조리전");
		model.addAttribute("ex", alloder);
		return "admin/oderlist";
	}

	@RequestMapping(value = "/startOder.do")
	public String startOder(HttpServletRequest request,Model model) {
		String num = request.getParameter("odernum");
		OderDao.getInstance().startOder(num);
		ArrayList<oderlistDto> alloder = OderDao.getInstance().allOder("조리전");
		model.addAttribute("ex", alloder);
		return "admin/oderlist";
	}
	
	
	

	@RequestMapping(value = { "/admin_menuInsert", "/admin_menuDelete", "/admin_menuModify", "/admin_menuModify.do",
			"/admin_menuinventory", "/admin_oderlist", "/admin_oderMagenment" })
	public String admin(HttpServletRequest request, HttpSession session, Model model) {
		UrlPathHelper urls = new UrlPathHelper();
		String url = urls.getOriginatingServletPath(request);
		String returnUrl = "";
		if ("/admin_menuInsert".equals(url)) {
			returnUrl = "admin/admin_menuInsert";

		} else if ("/admin_menuDelete".equals(url)) {
			ArrayList<MenuDto> menuDtos = MenuDao.getInstance().allmenu();
			model.addAttribute("menuDtos", menuDtos);
			returnUrl = "admin/admin_menuDelete";

		} else if ("/admin_menuModify".equals(url)) {
			ArrayList<MenuDto> menuDtos = MenuDao.getInstance().allmenu();
			model.addAttribute("menuDtos", menuDtos);
			returnUrl = "admin/admin_menuModify";

		} else if ("/admin_menuModify.do".equals(url)) {
			MenuDto menuDto = MenuDao.getInstance().oneMenu(request.getParameter("name"));
			model.addAttribute("MenuDto", menuDto);
			returnUrl = "admin/admin_menuModifyOK";

		} else if ("/admin_menuinventory".equals(url)) {
			ArrayList<MenuDto> menuDtos5 = MenuDao.getInstance().allmenuType("dessert");
			model.addAttribute("dessert", menuDtos5);
			returnUrl = "admin/Inventory_Mangenment";

		} else if ("/admin_oderlist".equals(url)) {
			returnUrl = "admin/oderlist";
		} else if ("/admin_oderMagenment".equals(url)) {
			returnUrl = "admin/oder_Magenment";
		}
		return returnUrl;
	}
}
