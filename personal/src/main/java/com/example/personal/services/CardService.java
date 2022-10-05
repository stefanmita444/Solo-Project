package com.example.personal.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.personal.models.Card;
import com.example.personal.repositories.CardRepository;


@Service
public class CardService {

	@Autowired
	private CardRepository cardRepo;
	
	public Card findCardById(Long id) {
		Optional<Card> card = cardRepo.findById(id);
		if(card.isPresent()) {
			return card.get();
		} else {
			return null;
		}
	}
	
	public List<Card> findAllCards() {
		return cardRepo.findAll();
	}
	
	public Card createCard(Card newCard) {
		return cardRepo.save(newCard);
	}
	
	public void updateCard(Card card) {
		cardRepo.save(card);
	}
	
	public void deleteCard(Long id) {
		cardRepo.deleteById(id);
	}

}
