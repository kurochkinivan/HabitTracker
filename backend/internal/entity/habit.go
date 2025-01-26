package entity

// TODO: Think of making id field of type uuid.UUID
type Habit struct {
	ID              string `json:"id"`
	UserID          string `json:"user_id"`
	Name            string `json:"name"`
	Desc            string `json:"desc"`
	Category        string `json:"category"`
	Interval        string `json:"interval"`
	Active          bool   `json:"active"`
	PopularityIndex string `json:"popularity_index"`
}
