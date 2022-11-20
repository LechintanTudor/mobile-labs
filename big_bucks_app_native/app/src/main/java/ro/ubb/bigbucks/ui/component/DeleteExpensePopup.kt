package ro.ubb.bigbucks.ui.component

import androidx.compose.material.AlertDialog
import androidx.compose.material.Button
import androidx.compose.material.ButtonDefaults
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color

@Composable
fun DeleteExpensePopup(
    onConfirm: () -> Unit,
    onDismiss: () -> Unit,
) {
    AlertDialog(title = { Text("Are you sure you want to delete the expense?") }, confirmButton = {
        Button(
            colors = ButtonDefaults.buttonColors(backgroundColor = Color(0xffee1111)),
            onClick = onConfirm,
        ) {
            Text(text = "DELETE")
        }
    }, dismissButton = {
        Button(
            colors = ButtonDefaults.buttonColors(backgroundColor = Color.LightGray),
            onClick = onDismiss,
        ) {
            Text("CANCEL")
        }
    }, onDismissRequest = onDismiss)
}
