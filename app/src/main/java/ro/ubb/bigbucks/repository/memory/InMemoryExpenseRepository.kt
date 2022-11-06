package ro.ubb.bigbucks.repository.memory

import ro.ubb.bigbucks.model.Expense
import ro.ubb.bigbucks.repository.ExpenseRepository

class InMemoryExpenseRepository : ExpenseRepository {
    private val expenses: MutableList<Expense> = ArrayList()
    private var lastGeneratedId: UInt = 0u

    override fun add(expense: Expense): Expense {
        assert(expense.id == 0u) { "Cannot add Expense with an already generated id" }
        lastGeneratedId += 1u
        return expense.copy(id = lastGeneratedId)
    }

    override fun getById(id: UInt): Expense? {
        return expenses.find { expense -> expense.id == id }
    }

    override fun getAll(): List<Expense> {
        return expenses
    }

    override fun size(): Int {
        return expenses.size
    }

    override fun deleteById(id: UInt): Boolean {
        return expenses.removeIf { expense -> expense.id == id }
    }

    override fun deleteAll() {
        return expenses.clear()
    }
}