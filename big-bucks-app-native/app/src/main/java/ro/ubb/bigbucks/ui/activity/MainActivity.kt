package ro.ubb.bigbucks.ui.activity

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Column
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Menu
import androidx.compose.runtime.*
import androidx.compose.ui.unit.dp
import ro.ubb.bigbucks.model.Expense
import ro.ubb.bigbucks.model.Recurrence
import ro.ubb.bigbucks.ui.content.AddExpenseBody
import ro.ubb.bigbucks.ui.content.EditExpenseBody
import ro.ubb.bigbucks.ui.content.ExpenseListBody
import ro.ubb.bigbucks.ui.content.ExpenseListFab
import ro.ubb.bigbucks.ui.theme.BigBucksTheme
import java.util.*

enum class AppState {
    EXPENSE_LIST, ADD_EXPENSE, EDIT_EXPENSE,
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            BigBucksTheme {
                MainContent()
            }
        }
    }
}

@Composable
fun MainContent() {
    var appState by remember { mutableStateOf(AppState.EXPENSE_LIST) }

    val expenses = remember {
        mutableStateListOf(
            Expense(1u, "Electricity", Recurrence.MONTHLY, 100u, Date(), null),
            Expense(2u, "Bus Tickets", Recurrence.DAILY, 3u, Date(), null),
            Expense(3u, "Keyboard", Recurrence.ONE_TIME, 50u, Date(), null),
        )
    }

    var selectedExpense by remember { mutableStateOf<Expense?>(null) }

    Scaffold(topBar = { TopBar() }, content = {
        when (appState) {
            AppState.EXPENSE_LIST -> {
                ExpenseListBody(
                    expenses,
                    onExpenseEdit = { expense ->
                        selectedExpense = expense
                        appState = AppState.EDIT_EXPENSE
                    },
                    onExpenseDelete = { expenseId ->
                        expenses.removeIf { expense -> expense.id == expenseId }
                    },
                )
            }
            AppState.ADD_EXPENSE -> {
                AddExpenseBody(onSave = { expense ->
                    expenses.add(expense)
                    appState = AppState.EXPENSE_LIST
                }, onCancel = {
                    appState = AppState.EXPENSE_LIST
                })
            }
            AppState.EDIT_EXPENSE -> {
                EditExpenseBody(
                    expense = selectedExpense!!,
                    onSave = { editedExpense ->
                        expenses.removeIf { expense -> expense.id == editedExpense.id }
                        expenses.add(editedExpense)
                        appState = AppState.EXPENSE_LIST
                    },
                    onCancel = { appState = AppState.EXPENSE_LIST },
                )
            }
        }
    }, floatingActionButton = {
        when (appState) {
            AppState.EXPENSE_LIST -> {
                ExpenseListFab {
                    appState = AppState.ADD_EXPENSE
                }
            }
            else -> {}
        }
    })
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
            MainTabRow(tabs, 0)
        }
    }
}

@Composable
fun MainTabRow(tabs: List<String>, selectedTabIndex: Int) {
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
