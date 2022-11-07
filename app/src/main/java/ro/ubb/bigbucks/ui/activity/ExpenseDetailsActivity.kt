package ro.ubb.bigbucks.ui.activity

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import ro.ubb.bigbucks.model.Expense

//import ro.ubb.bigbucks.ui.component.ExpenseDetails

class ExpenseDetailsActivity : ComponentActivity() {
    companion object {
        private const val ExpenseId = "expenseId"

        fun intent(context: Context, expense: Expense) {
            Intent(context, ExpenseDetailsActivity::class.java).apply {
                putExtra(ExpenseId, expense)
            }
        }
    }

    private val expense: Expense by lazy {
        intent.getSerializableExtra(ExpenseId, Expense::class.java)!!
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
//            ExpenseDetails(expense)
        }
    }
}