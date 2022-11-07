package ro.ubb.bigbucks.model

import java.util.Date

data class Expense(
    val id: UInt,
    val name: String,
    val recurrence: Recurrence,
    val value: UInt,
    val startDate: Date,
    val endDate: Date?,
)
