from django.db import models
from django.utils.translation import gettext_lazy as _


class Recurrence(models.TextChoices):
    ONE_TIME = "o", _("one time")
    DAILY = "d", _("daily")
    WEEKLY = "w", _("weekly")
    MONTHLY = "m", _("monthly")


class Expense(models.Model):
    name = models.CharField(max_length=255)
    value = models.PositiveIntegerField()
    recurrence = models.CharField(max_length=1, choices=Recurrence.choices)
    start_date = models.DateField()
    end_date = models.DateField(null=True, default=None, blank=True)
