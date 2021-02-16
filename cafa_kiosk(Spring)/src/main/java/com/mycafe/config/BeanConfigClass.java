package com.mycafe.config;

import org.apache.commons.dbcp2.BasicDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.mapper.MapperFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.mycafe.mapper.MenuMapperinterface;;

@Configuration
//@ComponentScan(basePackages = { "kr.co.ezenac.beans" })

public class BeanConfigClass {
	// DataSource
	@Bean
	public BasicDataSource source() {
		BasicDataSource source = new BasicDataSource();
		source.setDriverClassName("oracle.jdbc.OracleDriver"); // db연결 기본 설정
		source.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
		source.setUsername("shop");
		source.setPassword("1234");
		return source;
	}

	// sqlSessionFactory : jdbc를 처리하는 객체
	@Bean
	public SqlSessionFactory factory(BasicDataSource source) throws Exception {
		SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
		factoryBean.setDataSource(source);
		SqlSessionFactory factory = factoryBean.getObject();
		return factory;
	}

	// Mapper
	@Bean
	public MapperFactoryBean<MenuMapperinterface> test_mapper(SqlSessionFactory factory) throws Exception {
		MapperFactoryBean<MenuMapperinterface> factoryBean = new MapperFactoryBean<MenuMapperinterface>(MenuMapperinterface.class);
		factoryBean.setSqlSessionFactory(factory);
		return factoryBean;
	}
	
	
}