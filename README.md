# Continuous Integration with the Supermarket Receipt Refactoring Kata

This is a fork of Emily Bache's https://github.com/emilybache/SupermarketReceipt-Refactoring-Kata with\_tests branch.

The aim of the exercise is to refactor this code as a team, and add a new feature. 

## The Domain

The supermarket has a catalog with different types of products (rice, apples, milk, toothbrushes,...). Each product has a price, and the total price of the shopping cart is the total of all the prices of the items. You get a receipt that details the items you've bought, the total price and any discounts that were applied.

The supermarket runs special deals, e.g.
 - Buy two toothbrushes, get one free. Normal toothbrush price is €0.99
 - 20% discount on apples, normal price €1.99 per kilo.
 - 10% discount on rice, normal price €2.49 per bag
 - Five tubes of toothpaste for €7.49, normal price €1.79
 - Two boxes of cherry tomatoes for €0.99, normal price €0.69 per box.

These are just examples: the actual special deals change each week.

## The Challenge

You must refactor the code, using the safety of the test suite provided.

As a team identify code smells such as Long Method, Innappropriate Intimacy. Apply relevant refactorings.

When the team is confident it can handle this code, choose a pair to implement the new feature described below using TDD.

**Rules**

* Split into pairs.
* When refactoring, use a modified version of TCR; `test && (commit ; push) || revert.` - you can run `make tcr`
* Don't go longer than 3 minutes without running your tests.
* Push to master.
* Collaborate to solve merge conflicts.
* Every commit in master should pass all tests.
* Don't worry about commit messages, that's not what we're doing here.

## Details of the Backlog 

The owner of the system has a new feature request.

They want to introduce a new kind of special offer - bundles. 
When you buy all the items in a product bundle you get 10% off the 
total for those items. 

For example you could make a bundle offer of 
one toothbrush and one toothpaste. 
If you then you buy one toothbrush and one toothpaste, 
the discount will be 10% of €0.99 + €1.79. 
If you instead buy two toothbrushes and one toothpaste, 
you get the same discount as if you'd bought 
only one of each - ie only complete bundles are discounted.

