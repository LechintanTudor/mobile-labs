package ro.ubb.bigbucks.ui.content

import androidx.compose.material.FloatingActionButton
import androidx.compose.material.FloatingActionButtonDefaults
import androidx.compose.material.Icon
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.runtime.*
import ro.ubb.bigbucks.model.Expense
import ro.ubb.bigbucks.ui.component.DeleteExpensePopup
import ro.ubb.bigbucks.ui.component.ExpenseDetailsPopup
import ro.ubb.bigbucks.ui.component.ExpenseList

@Composable
fun ExpenseListBody(
    expenses: List<Expense>,
    onExpenseDelete: (UInt) -> Unit,
) {
    var selectedExpense by remember {
        mutableStateOf<Expense?>(null)
    }

    var expenseToDelete by remember {
        mutableStateOf<Expense?>(null)
    }

    ExpenseList(
        expenses,
        onCardDetailsClick = { expense ->
            selectedExpense = expense
        },
        onCardDeleteClick = { expense ->
            expenseToDelete = expense
        }
    )

    if (selectedExpense != null) {
        ExpenseDetailsPopup(
            expense = selectedExpense!!,
            onDismissRequest = { selectedExpense = null }
        )
    } else if (expenseToDelete != null) {
        DeleteExpensePopup(
            onConfirm = {
                onExpenseDelete(expenseToDelete!!.id)
                expenseToDelete = null
            },
            onDismiss = { expenseToDelete = null }
        )
    }
}

@Composable
fun ExpenseListFab(onClick: () -> Unit) {
    FloatingActionButton(
        onClick = onClick,
        elevation = FloatingActionButtonDefaults.elevation(),
    ) {
        Icon(
            Icons.Filled.Add,
            contentDescription = "Add expense",
        )
    }
}
