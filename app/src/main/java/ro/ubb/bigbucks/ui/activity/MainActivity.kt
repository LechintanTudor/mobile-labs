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
import ro.ubb.bigbucks.ui.content.ExpenseListBody
import ro.ubb.bigbucks.ui.content.ExpenseListFab
import ro.ubb.bigbucks.ui.theme.BigBucksTheme
import java.util.*

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
    var appState by remember { mutableStateOf(0) }

    val expenses = remember {
        mutableStateListOf(
            Expense(1u, "Electricity", Recurrence.MONTHLY, 100u, Date(), null),
            Expense(2u, "Bus Tickets", Recurrence.DAILY, 3u, Date(), null),
            Expense(3u, "Keyboard", Recurrence.ONE_TIME, 50u, Date(), null),
        )
    }

    Scaffold(
        topBar = { TopBar() },
        content = {
            when (appState) {
                0 -> {
                    ExpenseListBody(expenses, onExpenseDelete = { expenseId ->
                        expenses.removeIf { expense -> expense.id == expenseId }
                    })
                }
                1 -> {
                    AddExpenseBody(
                        onSave = { expense ->
                            expenses.add(expense)
                            appState = 0
                        },
                        onCancel = {
                            appState = 0
                        }
                    )
                }
            }
        },
        floatingActionButton = {
            when (appState) {
                0 -> {
                    ExpenseListFab {
                        appState = 1
                    }
                }
            }
        }
    )
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
