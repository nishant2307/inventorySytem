package com.inventorysystem.inventorysystem.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
@RequestMapping("/")
public class LoadController {

	@RequestMapping(value="input", method=RequestMethod.GET)
	public String input() {
		return "/input";
	}
	
	@RequestMapping(value="", method=RequestMethod.GET)
	public String output() {
		return "/output";
	}
	
}
