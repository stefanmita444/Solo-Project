package com.example.personal.services;

import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.example.personal.models.LoginUser;
import com.example.personal.models.User;
import com.example.personal.repositories.UserRepository;

@Service
public class UserService {

	@Autowired
	private UserRepository userRepo;
	
	public User register(User newUser, BindingResult result) {
		Optional<User> user= userRepo.findByEmail(newUser.getEmail());
		if (user.isPresent()) {
			result.rejectValue("email", "Taken", "This email has been taken");
			return null;
		} else {
			if (newUser.getPassword().equals(newUser.getConfirmPass())) {
				newUser.setPassword(BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt()));
				return userRepo.save(newUser);
			} else {
				result.rejectValue("confirmPass", "Matches", "Passwords do not match");
				return null;
			}
		}
	}
			
	
	public User findUserById(Long id) {
		Optional<User> user = userRepo.findById(id);
		if(user.isPresent()) {
			return user.get();
		} else {
			return null;
		}
	}
	
	public User findUserByEmail(LoginUser loginUser, BindingResult result) {
		
		Optional<User> user= userRepo.findByEmail(loginUser.getEmail());
		if (user.isPresent()) {
			if (BCrypt.checkpw(loginUser.getPassword(), user.get().getPassword())) {
				return user.get();
			} else {
				result.rejectValue("email", "login", "Invalid username/password");
				return null;
			}
		} else {
			result.rejectValue("email", "login", "Invalid username/password");
			return null;
		}
	}

}
