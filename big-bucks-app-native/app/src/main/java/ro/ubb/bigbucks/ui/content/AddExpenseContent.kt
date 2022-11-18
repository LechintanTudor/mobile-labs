package ro.ubb.bigbucks.ui.content

import androidx.compose.foundation.layout.*
import androidx.compose.material.Button
import androidx.compose.material.Text
import androidx.compose.material.TextField
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.unit.dp
import ro.ubb.bigbucks.model.Expense
import ro.ubb.bigbucks.model.Recurrence
import java.util.*

@Composable
fun AddExpenseBody(
    onSave: (Expense) -> Unit,
    onCancel: () -> Unit,
) {
    var name by remember { mutableStateOf(TextFieldValue("")) }

    Column(
        modifier = Modifier
            .fillMaxWidth()
            .padding(10.dp)
    ) {
        // Name
        TextField(
            value = name,
            onValueChange = { newName -> name = newName },
            label = { Text("Name") },
            placeholder = { Text("Electricity bill") },
            modifier = Modifier.fillMaxWidth()
        )

        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(10.dp),
        ) {
            Button(
                modifier = Modifier.weight(1f),
                onClick = onCancel,
            ) {
                Text("CANCEL")
            }
            Button(
                modifier = Modifier.weight(1f),
                enabled = name.text.isNotBlank(),
                onClick = {
                    val expense = Expense(
                        id = 0u,
                        name = name.text,
                        recurrence = Recurrence.ONE_TIME,
                        value = 100u,
                        startDate = Date(),
                        endDate = null
                    )

                    onSave(expense)
                }) {
                Text("SAVE")
            }
        }
    }
}
