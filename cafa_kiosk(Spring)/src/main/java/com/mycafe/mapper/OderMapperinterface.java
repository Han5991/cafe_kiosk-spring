package com.mycafe.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.mycafe.beans.MenuDto;

public interface OderMapperinterface {
	@Select("SELECT * FROM menu where imgname LIKE '${type}%'")
	ArrayList<MenuDto> allmenuType(String type);

	@Select("SELECT * FROM menu where name='${name}'")
	MenuDto onemenu(String name);

	@Update("update jdbc_table set str_data=#{str_data} where int_data=#{int_data}")
//	void update(JdbcBean bean);

	@Delete("delete jdbc_table where int_data=#{int_data}")
	void delete(int int_data);
}
