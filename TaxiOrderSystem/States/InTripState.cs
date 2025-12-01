using System;
namespace TaxiOrderSystem.States
{
    public class InTripState : BaseState
    {
        public override void SelectCar() => Console.WriteLine("Поездка уже в процессе.");
        public override void ConfirmOrder() => Console.WriteLine("Поездка уже в процессе.");
        public override void CarArrived() => Console.WriteLine("Вы уже в машине.");
        public override void StartTrip() => Console.WriteLine("Поездка уже началась.");
        public override void CompleteTrip() { Console.WriteLine("Поездка завершена, ожидается оплата."); _context.TransitionTo(new TripCompletedState()); }
        public override void CancelOrder() { Console.WriteLine("Поездка отменена."); _context.TransitionTo(new TripCancelledState()); }
    }
}
