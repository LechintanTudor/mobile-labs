package ro.ubb.bigbucks.ui.component

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import ro.ubb.bigbucks.model.Expense

@Composable
fun ExpenseCard(
    expense: Expense,
    onEditClick: (Expense) -> Unit,
    onDeleteClick: (Expense) -> Unit,
) {
    val expanded = remember {
        mutableStateOf(false)
    }

    Card(
        modifier = Modifier
            .fillMaxWidth()
            .background(Color.Yellow)
            .clickable { expanded.value = !expanded.value },
        elevation = 10.dp,
    ) {
        Column {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(140.dp)
                    .background(MaterialTheme.colors.primary),
                verticalAlignment = Alignment.CenterVertically,
                horizontalArrangement = Arrangement.SpaceAround,
            ) {
                Column {
                    Text(expense.name, style = MaterialTheme.typography.h2)
                    Text(
                        text = expense.subtitleText(),
                        style = MaterialTheme.typography.h3,
                    )
                }
                Box(
                    modifier = Modifier
                        .size(100.dp)
                        .clip(CircleShape)
                        .background(Color.Green),
                    contentAlignment = Alignment.Center,
                ) {
                    Text("\$${expense.value}", style = MaterialTheme.typography.h1)
                }
            }

            if (expanded.value) {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(8.dp),
                    horizontalArrangement = Arrangement.spacedBy(8.dp),
                ) {
                    Button(
                        modifier = Modifier
                            .height(50.dp)
                            .weight(1f),
                        colors = ButtonDefaults.buttonColors(backgroundColor = Color.LightGray),
                        onClick = { onEditClick(expense) },
                    ) {
                        Text("Details...")
                    }
                    Button(
                        modifier = Modifier
                            .height(50.dp)
                            .weight(1f),
                        colors = ButtonDefaults.buttonColors(backgroundColor = Color(0xffee1111)),
                        onClick = { onDeleteClick(expense) },
                    ) {
                        Text("Delete...")
                    }
                }
            }
        }
    }
}
