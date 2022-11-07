package ro.ubb.bigbucks.ui.component

import android.icu.text.DateFormat.getDateInstance
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.Card
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import ro.ubb.bigbucks.model.Expense
import ro.ubb.bigbucks.model.Recurrence
import java.text.SimpleDateFormat

@Composable
fun ExpenseCard(expense: Expense) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .height(140.dp),
        elevation = 10.dp,
    ) {
        Row(
            modifier = Modifier
                .background(MaterialTheme.colors.primary),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceAround,
        ) {
            Column {
                Text(expense.name, style = MaterialTheme.typography.h2)
                Text(
                    expenseSubtitle(expense),
                    style = MaterialTheme.typography.h3,
                )
            }
            Box(
                modifier = Modifier
                    .size(100.dp)
                    .clip(CircleShape)
                    .background(Color.Green),
                contentAlignment = Alignment.Center,
            ) {
                Text("\$${expense.value}", style = MaterialTheme.typography.h1)
            }
        }
    }
}

fun expenseSubtitle(expense: Expense): String {
    return when (expense.recurrence) {
        Recurrence.DAILY -> "daily"
        Recurrence.WEEKLY -> "weekly"
        Recurrence.MONTHLY -> "monthly"
        Recurrence.YEARLY -> "yearly"
        Recurrence.ONE_TIME -> getDateInstance().format(expense.startDate)
    }
}