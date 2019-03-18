package com.inventorysystem.inventorysystem.restcontroller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;

import javax.persistence.EntityManagerFactory;

import org.hibernate.Session;
import org.hibernate.internal.SessionImpl;
import org.hibernate.query.NativeQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.inventorysystem.inventorysystem.bean.Bean;


@RestController
@RequestMapping("/rest")
public class LoadRestController {

	@Autowired
	private EntityManagerFactory emf;
	
	@RequestMapping(value="/save", method=RequestMethod.POST)
	public @ResponseBody String save(@RequestBody Bean b) {
		System.out.println(b.getWarehouse());
		System.out.println(b.getSn());
		System.out.println(b.getModelno());
		System.out.println(b.getQuantity());
		
		try (Session s = emf.createEntityManager().unwrap(Session.class);
				Connection connection = ((SessionImpl) s).connection()) {
			
			PreparedStatement insertStm = connection.prepareStatement("insert into "
					+ " dbo.FGTransaction (Warehouse,ModelNo,SN,Quantity) values (?,?,?,?) ");
			insertStm.setString(1, b.getWarehouse());
			insertStm.setString(2, b.getModelno());
			insertStm.setString(3, b.getSn());
			insertStm.setInt(4, Integer.parseInt(b.getQuantity()));
			
			insertStm.execute();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/get_data", method=RequestMethod.POST)
	public @ResponseBody List<Object> returnData(@RequestBody Bean b) {
		
		try (Session s = emf.createEntityManager().unwrap(Session.class);
				Connection connection = ((SessionImpl) s).connection()) {
			String warehouse = b.getWarehouse();
			if(!"ALL".equals(warehouse)) {
				NativeQuery query = s.createNativeQuery("SELECT Warehouse,ModelNo,SUM(Quantity) " + 
						" FROM dbo.FGTransaction " + 
						" WHERE Warehouse = ? GROUP by Warehouse,ModelNo");
				query.setString(1, warehouse);
				return query.getResultList();
			}else {
				NativeQuery query = s.createNativeQuery("SELECT 'All' AS Warehouse,ModelNo,SUM(Quantity) \n" + 
						"FROM dbo.FGTransaction GROUP by ModelNo");
				return query.getResultList();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
