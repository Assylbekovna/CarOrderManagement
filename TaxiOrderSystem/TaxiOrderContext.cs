using TaxiOrderSystem.States;
namespace TaxiOrderSystem
{
    public class TaxiOrderContext
    {
        private BaseState _state;
        public TaxiOrderContext(BaseState state) { TransitionTo(state); }
        public void TransitionTo(BaseState state) { _state = state; _state.SetContext(this); }
        public void SelectCar() => _state.SelectCar();
        public void ConfirmOrder() => _state.ConfirmOrder();
        public void CarArrived() => _state.CarArrived();
        public void StartTrip() => _state.StartTrip();
        public void CompleteTrip() => _state.CompleteTrip();
        public void CancelOrder() => _state.CancelOrder();
    }
}
