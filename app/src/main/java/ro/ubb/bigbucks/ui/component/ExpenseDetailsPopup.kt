package ro.ubb.bigbucks.ui.component

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Card
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.Dialog
import ro.ubb.bigbucks.model.Expense

@Composable
fun ExpenseDetailsPopup(expense: Expense, onDismissRequest: () -> Unit) {
    Dialog(onDismissRequest) {
        Card {
            Column(
                modifier = Modifier
                    .padding(12.dp)
            ) {
                Text(
                    text = "#${expense.id} ${expense.name}",
                    style = MaterialTheme.typography.h1,
                )
                Text("Recurrence: ${expense.subtitleText()}")
                Text("Value: \$${expense.value}")
            }
        }
    }
}