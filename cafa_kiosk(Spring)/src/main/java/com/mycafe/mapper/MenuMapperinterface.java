package com.mycafe.mapper;

import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.mycafe.beans.MenuDto;

import java.util.ArrayList;
import java.util.List;

public interface MenuMapperinterface {
//데이터 컬럼의 값을 빈 어디에 넣을 것인가를 설정
//	@Results({ @Result(column = "int_data", property = "int_data"),
//			@Result(column = "str_data", property = "str_data") })

	@Select("SELECT * FROM menu")
	ArrayList<MenuDto> allmenu();
	
	@Select("SELECT * FROM menu where imgname LIKE '${type}%'")
	ArrayList<MenuDto> allmenuType(String type);
	
	@Select("SELECT * FROM menu where name='${name}'")
	MenuDto onemenu(String name);
	
	@Insert("insert into jdbc_table values(#{int_data},#{str_data})")
//	void insert_data(JdbcBean bean);

	@Update("update jdbc_table set str_data=#{str_data} where int_data=#{int_data}")
//	void update(JdbcBean bean);

	@Delete("delete jdbc_table where int_data=#{int_data}")
	void delete(int int_data);
}
