#!/bin/ruby

CARDS_ORDER = %w{A K Q T 9 8 7 6 5 4 3 2 J}.reverse
CARDS_VALUE = CARDS_ORDER.map.with_index { |v, i| [v, i] }.to_h

def count_cards(hand)
  jokers = hand.split("").map { |c| c=='J' ? 1 : 0 }.sum
  cards = hand.split("").select { |c| c!='J' }.tally.sort_by {|_, value| -value}
  value = 0
  if jokers==5 or cards[0][1]+jokers==5 then # Five of a kind
    value = 5000
  elsif cards[0][1]+jokers==4 then # Four of a kind
    value = 4000
  elsif cards[0][1]+jokers==3 and cards[1][1]==2 # Full house
    value = 3500
  elsif cards[0][1]==3 and cards[1][1]==2+jokers # Full house
    value = 3500
  elsif cards[0][1]+jokers==3 and cards[1][1]==1 # Three of a kind
    value = 3000
  elsif cards[0][1]+jokers==2 and cards[1][1]==2 # Two pair
    value = 2500
  elsif cards[0][1]+jokers==2 and cards[1][1]==1 # One pair
    value = 2000
  elsif cards.length == 5 # High card
    value = 1000
  end

  hand.split("").each do |card|
    label = card[0]
    value = value*100+CARDS_VALUE[label]
  end

  value
end

hands = []
STDIN.each do |line|
  hand, bid = line.strip.split

  hands.push(
    hand: hand,
    bid: bid.to_i,
    value: count_cards(hand),
  )
end

sum = 0

hands = hands.sort_by { |h| h[:value] }

hands.each_with_index do |hand, i|
  sum = sum + hand[:bid]*(i+1)
end

puts sum
