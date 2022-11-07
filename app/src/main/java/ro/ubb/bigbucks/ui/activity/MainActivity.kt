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
import androidx.compose.ui.unit.dp
import ro.ubb.bigbucks.model.Expense
import ro.ubb.bigbucks.model.Recurrence
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
    val expenses = ArrayList<Expense>()
    expenses.add(Expense(1u, "Chair", Recurrence.ONE_TIME, 50u, Date(), null))
    expenses.add(Expense(2u, "Electricity", Recurrence.MONTHLY, 100u, Date(), null))
    expenses.add(Expense(3u, "Electricity", Recurrence.MONTHLY, 100u, Date(), null))
    expenses.add(Expense(4u, "Electricity", Recurrence.MONTHLY, 100u, Date(), null))
    expenses.add(Expense(2u, "Electricity", Recurrence.MONTHLY, 100u, Date(), null))
    expenses.add(Expense(3u, "Electricity", Recurrence.MONTHLY, 100u, Date(), null))
    expenses.add(Expense(4u, "Electricity", Recurrence.MONTHLY, 100u, Date(), null))

    ExpenseList(expenses)
}

@Composable
fun AddExpenseFab() {
    FloatingActionButton(onClick = { /*TODO*/ },
        elevation = FloatingActionButtonDefaults.elevation()

    ) {
        Icon(
            Icons.Filled.Add,
            contentDescription = "Add expense",
        )
    }
}
