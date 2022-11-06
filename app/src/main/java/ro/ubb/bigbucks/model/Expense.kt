package ro.ubb.bigbucks.model

import java.util.Date

enum class ExpenseRecurrence {
    ONE_TIME,
    DAILY,
    WEEKLY,
    MONTHLY,
    YEARLY,
}

data class Expense(
    val id: UInt,
    val name: String,
    val value: UInt,
    val recurrence: ExpenseRecurrence,
    val startDate: Date,
    val endDate: Date?,
)
