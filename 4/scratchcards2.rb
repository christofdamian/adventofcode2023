#!/bin/ruby

cards = []
STDIN.each do |line|
  (card, winning, draw) = line.match(/^Card\s+(\d+): ([\d\s]+) \| ([\d\s]+)/).captures

  cards.push({
    number: card.to_i,
    winning: winning.split,
    draw: draw.split,
    count: 1,
  })
end

cards.each_with_index do |card, card_index|
  card[:winning].intersection(card[:draw]).each_with_index do |_, index|
    cards[card[:number]+index][:count] = cards[card[:number]+index][:count] + card[:count]
  end
end

sum = 0
cards.each do |card|
  sum = sum + card[:count]
end
puts sum
