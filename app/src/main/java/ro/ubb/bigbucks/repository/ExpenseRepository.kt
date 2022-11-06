package ro.ubb.bigbucks.repository

import ro.ubb.bigbucks.model.Expense

interface ExpenseRepository {
    fun add(expense: Expense): Expense

    fun getById(id: UInt): Expense?

    fun getAll(): List<Expense>

    fun size(): Int

    fun deleteById(id: UInt): Boolean

    fun deleteAll()
}
