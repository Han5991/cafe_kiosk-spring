package com.mycafe.mapper;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.mycafe.beans.MenuDto;
import java.util.ArrayList;

public interface MenuMapperinterface {
	@Select("SELECT * FROM menu")
	ArrayList<MenuDto> allmenu();

	@Select("SELECT * FROM menu where imgname LIKE '${type}%'")
	ArrayList<MenuDto> allmenuType(String type);

	@Select("SELECT * FROM menu where name='${name}'")
	MenuDto onemenu(String name);
	
	@Select("SELECT name FROM menu where imgname LIKE 'dessert%'")
	ArrayList<String> dessertnamelist();
	
	@Update("update menu set stock=stock+'${Quantity}' where name='${menu}'")
	void updateinven (String Quantity, String menu);
	
	@Update("update oder2 set status= '조리완료' where odernum='${num}'")
	int startoder(String num);
}