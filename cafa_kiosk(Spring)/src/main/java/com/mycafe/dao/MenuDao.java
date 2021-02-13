package com.mycafe.dao;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import com.mycafe.beans.MenuDto;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import com.mycafe.config.BeanConfigClass;
import com.mycafe.mapper.MenuMapperinterface;

public class MenuDao extends HttpServlet {

	private static final long serialVersionUID = 1L;
	ResultSet resultSet;
	Connection connection;
	PreparedStatement preparedStatement;
	private static MenuDao admin = new MenuDao();
	AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext(BeanConfigClass.class);
	MenuMapperinterface menuMapperinterface = context.getBean(MenuMapperinterface.class);

	public static synchronized MenuDao getInstance() {
		return admin;
	}

	private MenuDao() {
	}

	public void getCon() {
		try {
			Context initctx = new InitialContext();
			Context envctx = (Context) initctx.lookup("java:/comp/env");
			DataSource dataSource = (DataSource) envctx.lookup("jdbc/Oracle11g");
			connection = dataSource.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void close() {
		try {
			if (connection != null)
				connection.close();
			if (preparedStatement != null)
				preparedStatement.close();
			if (resultSet != null)
				resultSet.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 모든 메뉴 불러오기
	public ArrayList<MenuDto> allmenu() {
		ArrayList<MenuDto> menus = menuMapperinterface.allmenu();
		return menus;
	}

	// 타입에 따른 메뉴 불러오기
	public ArrayList<MenuDto> allmenuType(String type) {
		ArrayList<MenuDto> menus = menuMapperinterface.allmenuType(type);
		return menus;
	}

	// 하나의 메뉴 불러오기
	public MenuDto oneMenu(String name) {
		MenuDto menuDto = menuMapperinterface.onemenu(name);
		return menuDto;
	}

	// 메뉴 등록 이미지 파일이 오라클과 프로젝트 내에 저장이됨
	public int insertMenu(HttpServletRequest request) {
		int fileSize = 1024 * 1024 * 10; // 이미지 크기 설정
		int rownum = 0;

		String uploadPath = "C:\\Users\\admin\\git\\cafe_kiosk-spring\\cafa_kiosk(Spring)\\src\\main\\webapp\\resources\\img";
		getCon();
		try { // 이미지 파일을 받기 위해선 MultipartRequest 타입으로 선언해줘야 한다.
			MultipartRequest multi = new MultipartRequest(request, uploadPath, fileSize, "UTF-8",
					new DefaultFileRenamePolicy());
			String name = multi.getParameter("name");
			int price = Integer.parseInt(multi.getParameter("price"));
			String type = multi.getParameter("category");// db에서 검색하기 위한파일 이름 설정
			String uploadFile = multi.getFilesystemName("image");

			File f = new File(uploadPath + "\\" + uploadFile);
			File fileNew = new File(uploadPath + "\\" + type + uploadFile);
			if (f.exists())
				f.renameTo(fileNew);
			FileInputStream fis = new FileInputStream(fileNew);// 파일을 FileInputStream을 통해 저장

			preparedStatement = connection.prepareStatement("insert into menu values(?,?,?,?,0)");
			preparedStatement.setString(1, name);
			preparedStatement.setInt(2, price);
			preparedStatement.setBinaryStream(3, fis, (int) fileNew.length());// 이미지를 Blob타입으로 넘기기 위해서 바이트스트림사용
			preparedStatement.setString(4, fileNew.getName());
			rownum = preparedStatement.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return rownum;
	}

	// 메뉴 삭제 오라클과 프로젝트내의 이미지도 삭제
	public int deleteMenu(String name) {
		String uploadPath = "C:\\Users\\admin\\git\\cafe_kiosk-spring\\"
				+ "cafa_kiosk(Spring)\\src\\main\\webapp\\resources\\img";
		int result = 0;
		getCon();
		try {
			File f = new File(uploadPath + "\\" + name);
			if (f.exists()) {
				if (f.delete()) {
					String sql = "delete from menu where imgname=?";
					preparedStatement = connection.prepareStatement(sql);
					preparedStatement.setString(1, name);
					result = preparedStatement.executeUpdate();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return result;
	}

	// 메뉴 업데이트 오라클과 프로젝트 내의 이미지 동기화
	public int updateMenu(HttpServletRequest request) {
		int result = 0;
		getCon();
		int fileSize = 1024 * 1024 * 10;
		int rownum = 0;
		boolean update = false;
		String uploadPath = "C:\\Users\\admin\\git\\cafe_kiosk-spring\\cafa_kiosk(Spring)"
				+ "\\src\\main\\webapp\\resources\\img";
		try {
			MultipartRequest multi = new MultipartRequest(request, uploadPath, fileSize, "UTF-8",
					new DefaultFileRenamePolicy());
			String name = multi.getParameter("name");
			int price = Integer.parseInt(multi.getParameter("price"));
			String type = multi.getParameter("category");
			String uploadFile = multi.getFilesystemName("image");
			String filename = multi.getParameter("filename");

			File f = new File(uploadPath + "\\" + uploadFile);
			File fileNew = new File(uploadPath + "\\" + type + uploadFile);
			if (f.exists())
				f.renameTo(fileNew);
			FileInputStream fis = new FileInputStream(fileNew);

			preparedStatement = connection
					.prepareStatement("UPDATE menu SET name=?, price=?, img=?, imgname=? WHERE imgname=?");
			preparedStatement.setString(1, name);
			preparedStatement.setInt(2, price);
			preparedStatement.setBinaryStream(3, fis, (int) fileNew.length());
			preparedStatement.setString(4, fileNew.getName());
			preparedStatement.setString(5, filename);
			rownum = preparedStatement.executeUpdate();
			f = new File(uploadPath + "\\" + filename);
			if (f.exists())
				update = f.delete();

			if (rownum > 0 && update == true)
				System.out.println("메뉴 수정 성공");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return result;
	}

	// 디저트 메뉴 재고 관리 메서드
	public void updateinventory(HttpServletRequest request) {
		String name[] = request.getParameterValues("menu");
		String stock[] = request.getParameterValues("stock3");
		try {
			getCon();
			for (int i = 0; i < name.length; i++) {
				preparedStatement = connection.prepareStatement("update menu set stock=? where name=?");
				preparedStatement.setString(2, name[i]);
				preparedStatement.setString(1, stock[i]);
				preparedStatement.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	// 오라클의 이미지 출력
	public void showImage(HttpServletRequest request, HttpServletResponse response) {
		Connection con = null;
		PreparedStatement stmt = null;
		InputStream is = null;
		try {
			Context context = new InitialContext();
			DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle11g");
			con = dataSource.getConnection();

			stmt = con.prepareStatement("SELECT img FROM menu WHERE name=?");
			stmt.setString(1, request.getParameter("key1"));
			ResultSet resultSet = stmt.executeQuery();
			while (resultSet != null && resultSet.next()) {
				is = resultSet.getBinaryStream("img");
			}
			response.setContentType("jpg");
			ServletOutputStream os = response.getOutputStream();
			int binaryRead;
			while ((binaryRead = is.read()) != -1) {
				os.write(binaryRead);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (con != null)
					con.close();
				if (stmt != null)
					stmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
