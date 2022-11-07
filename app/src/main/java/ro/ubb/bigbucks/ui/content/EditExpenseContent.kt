package ro.ubb.bigbucks.ui.content;

import androidx.compose.foundation.layout.*
import androidx.compose.material.Button
import androidx.compose.material.Text
import androidx.compose.material.TextField
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.unit.dp
import ro.ubb.bigbucks.model.Expense

@Composable
fun EditExpenseBody(
    expense: Expense,
    onSave: (Expense) -> Unit,
    onCancel: () -> Unit,
) {
    var name by remember { mutableStateOf(TextFieldValue(expense.name)) }

    Column(modifier = Modifier
        .fillMaxWidth()
        .padding(10.dp)) {
        // Name
        TextField(value = name,
            onValueChange = { newName -> name = newName },
            label = { Text("Name") },
            placeholder = { Text("Electricity bill") },
            modifier = Modifier.fillMaxWidth())

        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween,
        ) {
            Button(
                onClick = onCancel,
            ) {
                Text("CANCEL")
            }
            Button(enabled = name.text.isNotBlank(), onClick = {
                onSave(expense.copy(name = name.text))
            }) {
                Text("SAVE")
            }
        }
    }
}
