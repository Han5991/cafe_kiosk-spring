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
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int insertMenu(HttpServletRequest request) {
		MultipartRequest multi = null;
		int fileSize = 1024 * 1024 * 10;
		String uploadFile = null;
		String name = null;
		String type = null;
		int rownum = 0;
		int price = 0;

		String uploadPath = "C:\\Users\\admin\\git\\cafe_kiosk\\cafe_kiosk\\src\\main\\webapp\\resources\\img";
		getCon();
		try {
			multi = new MultipartRequest(request, uploadPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());
			name = multi.getParameter("name");
			price = Integer.parseInt(multi.getParameter("price"));
			type = multi.getParameter("category");
			uploadFile = multi.getFilesystemName("image");
		} catch (Exception e) {
			e.printStackTrace();
		}

		try {
			File f = new File(uploadPath + "\\" + uploadFile);
			File fileNew = new File(uploadPath + "\\" + type + uploadFile);
			if (f.exists())
				f.renameTo(fileNew);
			FileInputStream fis = new FileInputStream(fileNew);

			preparedStatement = connection.prepareStatement("insert into menu values(?,?,?,?,0)");
			preparedStatement.setString(1, name);
			preparedStatement.setInt(2, price);
			preparedStatement.setBinaryStream(3, fis, (int) fileNew.length());
			preparedStatement.setString(4, fileNew.getName());
			rownum = preparedStatement.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return rownum;
	}

	public int deleteMenu(String name) {
		String uploadPath = "C:\\Users\\admin\\git\\cafe_kiosk\\cafe_kiosk\\src\\main\\webapp\\resources\\img";
		int result = 0;
		boolean de = false;
		getCon();

		try {
			String sql = "delete from menu where imgname=?";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, name);
			result = preparedStatement.executeUpdate();

			File f = new File(uploadPath + "\\" + name);
			if (f.exists())
				de = f.delete();

			connection.close();
			preparedStatement.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return result;
	}

	public ArrayList<MenuDto> allmenu() {
		ArrayList<MenuDto> menus = new ArrayList<MenuDto>();
		getCon();

		try {
			String sql = "SELECT * FROM menu";
			preparedStatement = connection.prepareStatement(sql);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				MenuDto menuDto = new MenuDto();
				menuDto.setName(resultSet.getString(1));
				menuDto.setPrice(resultSet.getInt(2));
				menuDto.setImgname(resultSet.getString(4));
				menuDto.setStock(resultSet.getInt(5));
				menus.add(menuDto);
			}
			connection.close();
			preparedStatement.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return menus;
	}

	public ArrayList<MenuDto> allmenuType(String type) {
		ArrayList<MenuDto> menus = menuMapperinterface.allmenuType(type);
		return menus;
	}

	public MenuDto oneMenu(String name) {
		MenuDto menuDto = new MenuDto();
		getCon();
		try {
			String sql = "SELECT * FROM menu where name=?";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, name);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				menuDto.setName(resultSet.getString(1));
				menuDto.setPrice(resultSet.getInt(2));
				menuDto.setImgname(resultSet.getString(4));
				menuDto.setStock(resultSet.getInt(5));
			}

			connection.close();
			preparedStatement.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return menuDto;
	}

	public int updateMenu(HttpServletRequest request) {
		int result = 0;
		getCon();
		MultipartRequest multi = null;
		int fileSize = 1024 * 1024 * 10;
		String uploadFile = null;
		String name = null;
		String type = null;
		String filename = null;
		int rownum = 0;
		int price = 0;
		boolean update = false;
		String uploadPath = "C:\\Users\\admin\\git\\cafe_kiosk\\cafe_kiosk\\src\\main\\webapp\\resources\\img";
		try {
			multi = new MultipartRequest(request, uploadPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());
			name = multi.getParameter("name");
			price = Integer.parseInt(multi.getParameter("price"));
			type = multi.getParameter("category");
			uploadFile = multi.getFilesystemName("image");
			filename = multi.getParameter("filename");

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

			if (rownum > 0 && update == true) {
				System.out.println("메뉴 수정 성공");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return result;
	}

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
