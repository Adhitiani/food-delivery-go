package repository

type MenuItemRepository interface {
	GetAllSuppliersId() ([]int, error)
	//GetAllMenuItem() (MenuItem []model.MenuItem, err error)
}
