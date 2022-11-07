package ro.ubb.bigbucks.ui.activity

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Column
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Menu
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.unit.dp
import ro.ubb.bigbucks.model.Expense
import ro.ubb.bigbucks.model.Recurrence
import ro.ubb.bigbucks.ui.component.DeleteExpensePopup
import ro.ubb.bigbucks.ui.component.ExpenseDetailsPopup
import ro.ubb.bigbucks.ui.component.ExpenseList
import ro.ubb.bigbucks.ui.theme.BigBucksTheme
import java.util.*

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            BigBucksTheme {
                Scaffold(
                    topBar = { TopBar() },
                    content = { Body() },
                    floatingActionButton = { AddExpenseFab() },
                )
            }
        }
    }
}

@Composable
fun TopBar() {
    val tabs = ArrayList<String>()
    tabs.add("Expenses")
    tabs.add("Status")

    Card(elevation = 10.dp) {
        Column {
            TopAppBar(
                title = { Text("BIG BUCK$") },
                navigationIcon = {
                    Icon(
                        Icons.Filled.Menu,
                        contentDescription = "Menu",
                    )
                },
            )
            MyTabRow(tabs, 0)
        }
    }
}

@Composable
fun MyTabRow(tabs: List<String>, selectedTabIndex: Int) {
    TabRow(selectedTabIndex) {
        tabs.forEachIndexed { index, tabTitle ->
            Tab(
                selected = index == selectedTabIndex,
                onClick = {},
                text = { Text(tabTitle) },
            )
        }
    }
}

@Composable
fun Body() {
    val expenses = remember {
        mutableStateListOf(
            Expense(1u, "Electricity1", Recurrence.MONTHLY, 100u, Date(), null),
            Expense(2u, "Bus Tickets", Recurrence.DAILY, 5u, Date(), null),
            Expense(3u, "Keyboard", Recurrence.ONE_TIME, 100u, Date(), null),
        )
    }

    val selectedExpense = remember {
        mutableStateOf<Expense?>(null)
    }

    val expenseToDelete = remember {
        mutableStateOf<Expense?>(null)
    }

    ExpenseList(
        expenses,
        onCardDetailsClick = { expense ->
            selectedExpense.value = expense
        },
        onCardDeleteClick = { expense ->
            expenseToDelete.value = expense
        }
    )

    if (selectedExpense.value != null) {
        ExpenseDetailsPopup(
            expense = selectedExpense.value!!,
            onDismissRequest = { selectedExpense.value = null }
        )
    } else if (expenseToDelete.value != null) {
        DeleteExpensePopup(
            onConfirm = {
                val expenseToDeleteId = expenseToDelete.value!!.id
                expenses.removeIf { expense -> expense.id == expenseToDeleteId }
                expenseToDelete.value = null
            },
            onDismiss = { expenseToDelete.value = null }
        )
    }
}

@Composable
fun AddExpenseFab() {
    FloatingActionButton(
        onClick = {},
        elevation = FloatingActionButtonDefaults.elevation(),
    ) {
        Icon(
            Icons.Filled.Add,
            contentDescription = "Add expense",
        )
    }
}
