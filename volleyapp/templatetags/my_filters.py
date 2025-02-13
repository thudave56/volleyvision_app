from django import template

register = template.Library()

@register.filter
def extension(value):
    return value.split('.')[-1]

@register.filter(name='add_class')
def add_class(value, arg):
    return value.as_widget(attrs={'class': arg})