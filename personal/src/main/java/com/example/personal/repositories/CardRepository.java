package com.example.personal.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.example.personal.models.Card;

@Repository
public interface CardRepository extends CrudRepository<Card, Long> {

	List<Card> findAll();
	Optional<Card> findById(Long id);
	
}
