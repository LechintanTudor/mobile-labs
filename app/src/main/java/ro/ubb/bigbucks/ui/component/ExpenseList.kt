package ro.ubb.bigbucks.ui.component

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import ro.ubb.bigbucks.model.Expense

@Composable
fun ExpenseList(
    expenses: List<Expense>,
    onCardDetailsClick: (Expense) -> Unit,
    onCardDeleteClick: (Expense) -> Unit,
) {
    LazyColumn(
        modifier = Modifier
            .fillMaxSize()
            .padding(horizontal = 8.dp),
        verticalArrangement = Arrangement.spacedBy(8.dp),
    ) {
        item {
            Spacer(modifier = Modifier.height(4.dp))
        }

        items(expenses) { expense ->
            ExpenseCard(expense,
                onDetailsClick = onCardDetailsClick,
                onDeleteClick = onCardDeleteClick)
        }

        item {
            Spacer(modifier = Modifier.height(4.dp))
        }
    }
}
