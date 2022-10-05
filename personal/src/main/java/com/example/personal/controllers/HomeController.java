package com.example.personal.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;

import com.example.personal.models.Card;
import com.example.personal.models.LoginUser;
import com.example.personal.models.User;
import com.example.personal.services.CardService;
import com.example.personal.services.UserService;

@Controller
public class HomeController {
	@Autowired
	UserService userService;
	
	@Autowired
	CardService cardService;

	@GetMapping("/")
	public String home(Model model) {
		model.addAttribute("newUser", new User());
		model.addAttribute("loginUser", new LoginUser());
		return "home.jsp";
	}
	
	@PutMapping("/register")
	public String register(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, HttpSession session, Model model) {
		if (result.hasErrors()) {
			model.addAttribute("errors", result.getAllErrors());
			model.addAttribute("loginUser", new LoginUser());
			return "home.jsp";
		} else {
			User loggedUser = userService.register(newUser, result);
			if (result.hasErrors()) {
				model.addAttribute("loginUser", new LoginUser());
				return "home.jsp";
			} else {
				session.setAttribute("user_id", loggedUser.getId());
				return "redirect:/dashboard";
			}
		}
	}
	
	@PutMapping("/login")
	public String login(@Valid @ModelAttribute("loginUser") LoginUser loginUser, BindingResult result,
			HttpSession session, Model model) {
		User loggedUser = userService.findUserByEmail(loginUser, result);
		if (result.hasErrors()) {
			model.addAttribute("newUser", new User());
			return "home.jsp";
		} else {
			session.setAttribute("user_id", loggedUser.getId());
			return "redirect:/dashboard";
		}
	}
	
	@GetMapping("/dashboard")
	public String dashboard(HttpSession session, Model model) {
		List<Card> cards = cardService.findAllCards();
		Long id = (Long) session.getAttribute("user_id");
		model.addAttribute("newCard", new Card());
		model.addAttribute("user", userService.findUserById(id));
		model.addAttribute("cards", cards);
		return "dashboard.jsp";
	}
	
	@PutMapping("/cards/create")
	public String newCard(@Valid @ModelAttribute("newCard") Card newCard, BindingResult result, HttpSession session, Model model) {
		if (result.hasErrors()) {
			return "dashboard.jsp";
		} else {
			newCard.setUser(userService.findUserById((Long) session.getAttribute("user_id")));
			newCard.setAlpha(newCard.getAlpha() / 100);
			cardService.createCard(newCard);
			return "redirect:/dashboard";
		}
	}
	
	
	@GetMapping("/cards/{id}/edit")
	public String edit(@PathVariable("id") Long id, Model model) {
		Card card = cardService.findCardById(id);
		model.addAttribute("newCard", new Card());
		model.addAttribute("card", card);
		return "editCard.jsp";
	}
	
	@PutMapping("/cards/{id}/update")
	public String updateCard(@Valid @ModelAttribute("newCard") Card newCard, BindingResult result,
			HttpSession session, @PathVariable("id") Long id, Model model) {
		if (result.hasErrors()) {
			User user = userService.findUserById((Long) session.getAttribute("user_id"));
			model.addAttribute("user", user);
			model.addAttribute("cards", user.getCards());
			edit(id, model);
			return "dashboard.jsp";
		} else {
			newCard.setId(id);
			newCard.setUser(userService.findUserById((Long) session.getAttribute("user_id")));
			newCard.setAlpha(newCard.getAlpha() / 100);
			newCard.setNumber(cardService.findCardById(id).getNumber());
			newCard.setExpDate(cardService.findCardById(id).getExpDate());
			cardService.updateCard(newCard);
			return "redirect:/dashboard";
		}
	}
	
	@DeleteMapping("/cards/{id}/delete")
	public String delete(@PathVariable("id") Long id) {
		cardService.deleteCard(id);
		return "redirect:/dashboard";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("user_id");
		return "redirect:/";
	}

}
