namespace TaxiOrderSystem.States
{
    public abstract class BaseState
    {
        protected TaxiOrderContext _context;
        public void SetContext(TaxiOrderContext context) { _context = context; }
        public abstract void SelectCar();
        public abstract void ConfirmOrder();
        public abstract void CarArrived();
        public abstract void StartTrip();
        public abstract void CompleteTrip();
        public abstract void CancelOrder();
    }
}
