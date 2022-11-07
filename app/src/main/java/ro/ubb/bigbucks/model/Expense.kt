package ro.ubb.bigbucks.model

import android.icu.text.DateFormat
import java.io.Serializable
import java.util.*

data class Expense(
    val id: UInt,
    val name: String,
    val recurrence: Recurrence,
    val value: UInt,
    val startDate: Date,
    val endDate: Date?,
) : Serializable {
    fun subtitleText(): String {
        return when (recurrence) {
            Recurrence.DAILY -> "daily"
            Recurrence.WEEKLY -> "weekly"
            Recurrence.MONTHLY -> "monthly"
            Recurrence.YEARLY -> "yearly"
            Recurrence.ONE_TIME -> DateFormat.getDateInstance().format(startDate)
        }
    }
}
