package com.Grownited.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.Grownited.entity.CategoryEntity;
import com.Grownited.repository.CategoryRepository;



@Controller
public class CategoryController {

	@Autowired
	CategoryRepository categoryRepository;
	
	@GetMapping("newCategory")
	public String newCatagory() {
		return "NewCategory";
	}
	
	@PostMapping("saveCategory")
	public String saveCatagory(CategoryEntity categoryEntity) {
		
		categoryRepository.save(categoryEntity);
		return "redirect:/listCategory";
	}
	
	@GetMapping("listCategory")
	public String listCatagory(Model model) {
		
		List<CategoryEntity> categoryList = categoryRepository.findAll();
		model.addAttribute("categoryList",categoryList);
		return "ListCategory";
	}
	@GetMapping("deleteCategory")
	public String deletehackathon(Integer id) {
		categoryRepository.deleteById(id);
		return "redirect:/listCategory";
	}
	
}
